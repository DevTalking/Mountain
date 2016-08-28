//
//  Equation.swift
//  Mountain
//
//  Created by JaceFu on 16/7/11.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import UIKit

public typealias Condition = () -> Bool

/**
 This is the abstraction of **item1.attribute1 = multiplier × item2.attribute2 + constant** equation.
 */
class MountainEquation {
    
    var priority: MountainPriority
    var relation: MountainRelation
    var constant: CGFloat
    var multiplier: CGFloat
    var attribute: MountainAttribute?
    var item: AnyObject
    var toItem: AnyObject?
    var toItemAttribute: MountainAttribute?
    var isExecutedAllLike = false
    
    init(modifier: Any, item: AnyObject, toItem: AnyObject? = nil) {
        
        if modifier is MountainModifier {
            self.relation = (modifier as! MountainModifier).relation
            self.constant = (modifier as! MountainModifier).constant
            self.multiplier = (modifier as! MountainModifier).multiplier
        } else {
            self.relation = MountainModifier(constant: MountainTool.convertToCGFloat(modifier)).relation
            self.constant = MountainModifier(constant: MountainTool.convertToCGFloat(modifier)).constant
            self.multiplier = MountainModifier(constant: MountainTool.convertToCGFloat(modifier)).multiplier
        }
        self.item = item
        self.priority = .HighPriority
        self.attribute = self.attributeFromClass()
        self.toItem = toItem
        if self.toItem == nil {
            self.toItemAttribute = .NotAnAttribute
        } else {
            self.toItemAttribute = self.attribute
        }
        
        if self.attribute!.ifShouldInvertConstant {
            self.constant = self.constant * -1
        }
        
    }
    
    convenience init(item: AnyObject) {
        
        let modifier = MountainModifier()
        self.init(modifier: modifier, item: item, toItem: MountainTool.judgeSecondItem(item))
        
    }
 
    func generateConstraint() -> NSLayoutConstraint {
        
        self.isUIView {
            
            $0.translatesAutoresizingMaskIntoConstraints = false
            
        }
        
        let constraint = NSLayoutConstraint(item: self.item, attribute: self.attribute!.actualAttribute(), relatedBy: self.relation.actualRelation(), toItem: self.toItem, attribute: self.toItemAttribute!.actualAttribute(), multiplier: self.multiplier, constant: self.constant)
        constraint.priority = self.priority.actualPriority()
        
        return constraint
        
    }
    
    func installEquation() {
        
        self.saveEquationsInArray()
        
        let constraintsOnView = MountainTool.gatherConstraintsFromItem(self.item)
        constraintsOnView.forEach { (constraint) in
            
            if constraint.firstAttribute == self.attribute!.actualAttribute() {
                
                self.isUIView({ (targetView) in
                    
                    targetView.removeConstraint(constraint)
                    targetView.superview?.removeConstraint(constraint)
                    
                })
                
                if #available(iOS 9.0, *) {
                    
                    self.isUILayoutGuide({ (targetGuide) in
                        
                        targetGuide.owningView?.removeConstraint(constraint)
                        
                    })
                    
                }
                
            }
            
        }
        
    }
    
    func like(item: AnyObject, _ attribute: MountainAttribute? = nil) {
        
        self.isUIView {
            
            for e in $0.installedEquations.reverse() {
                
                if self.updateEquation(e, toItem: item, attribute: attribute) {
                    
                    break
                    
                }
                
            }
            
        }
        
        if #available(iOS 9.0, *) {
            
            self.isUILayoutGuide {
                
                for e in $0.installedEquations.reverse() {
                    
                    if self.updateEquation(e, toItem: item, attribute: attribute) {
                        
                        break
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func allLike(item: AnyObject, _ attribute: MountainAttribute? = nil) {
        
        self.isUIView { (view) in
            
            view.installedEquations.forEach {
                
                self.updateEquations($0, toItem: item, attribute: attribute)
                
            }
            
        }
        
        if #available(iOS 9.0, *) {
            
            self.isUILayoutGuide { (view) in
                
                view.installedEquations.forEach {
                    
                    self.updateEquations($0, toItem: item, attribute: attribute)
                    
                }
                
            }
            
        }
        
    }
    
    func to(item: AnyObject, _ attribute: MountainAttribute? = nil) {
        
        self.like(item, attribute)
        
    }
    
    func when(condition: Condition) {
        
        if !condition() {
            
            self.isUIView {
                
                $0.installedEquations.removeEquation(self)
                $0.currentEquation = nil
                
            }
            
            if #available(iOS 9.0, *) {
                
                self.isUILayoutGuide {
                    
                    $0.installedEquations.removeEquation(self)
                    $0.currentEquation = nil
                    
                }
                
            }
            
        }
        
    }
    
    func allWhen(condition: Condition) {
        
        if !condition() {
            
            self.isUIView {
                
                $0.installedEquations.removeAll()
                $0.currentEquation = nil
                
            }
            
            if #available(iOS 9.0, *) {
                
                self.isUILayoutGuide {
                    
                    $0.installedEquations.removeAll()
                    $0.currentEquation = nil
                    
                }
                
            }

        }
        
    }
    
    func with(priority: MountainPriority) {
        
        self.priority = priority
        
    }
    
    func attributeFromClass() -> MountainAttribute {
        
        switch self {
        case is Width:
            return .Width
        case is Height:
            return .Height
        case is CenterX:
            return .CenterX
        case is CenterY:
            return .CenterY
        case is CenterXWithinMargins:
            return .CenterXWithinMargins
        case is CenterYWithinMargins:
            return .CenterYWithinMargins
        case is Top:
            return .Top
        case is TopMargin:
            return .TopMargin
        case is Left:
            return .Left
        case is LeftMargin:
            return .LeftMargin
        case is Right:
            return .Right
        case is RightMargin:
            return .RightMargin
        case is Bottom:
            return .Bottom
        case is BottomMargin:
            return .BottomMargin
        case is Leading:
            return .Leading
        case is LeadingMargin:
            return .LeadingMargin
        case is Trailing:
            return .Trailing
        case is TrailingMargin:
            return .TrailingMargin
        case is FirstBaseline:
            return .FirstBaseline
        case is LastBaseline:
            return .LastBaseline
        default:
            return .NotAnAttribute
        }
        
    }
    
    private func isUIView(code: (UIView) -> Void) {
        
        if let targetView = self.item as? UIView {
        
            code(targetView)
            
        }
        
    }
    
    @available(iOS 9.0, *)
    private func isUILayoutGuide(code: (UILayoutGuide) -> Void) {
    
        if let targetGuide = self.item as? UILayoutGuide {
            
            code(targetGuide)
            
        }
    
    }
    
    private func saveEquationsInArray() {
        
        self.isUIView {
            
            $0.installedEquations.append(self)
            $0.currentEquation = self
            
        }
        
        if #available(iOS 9.0, *) {
            
            self.isUILayoutGuide {
                
                $0.installedEquations.append(self)
                $0.currentEquation = self
                
            }
            
        }
        
    }
    
    private func updateEquation(equation: MountainEquation, toItem: AnyObject, attribute: MountainAttribute?) -> Bool {
        
        if equation == self {
            
            if let att = attribute {
                
                equation.toItemAttribute = att
                
            } else {
                
                equation.toItemAttribute = equation.attribute
                
            }
            
            equation.toItem = toItem
            
            return true
            
        }
        
        return false
        
    }
    
    private func updateEquations(equation: MountainEquation, toItem: AnyObject, attribute: MountainAttribute?) {
        
        if !equation.isExecutedAllLike {
            
            equation.toItem = toItem
            
            if let att = attribute {
                
                equation.toItemAttribute = att
                
            } else {
                
                equation.toItemAttribute = equation.attribute
                
            }
            
        }
        
        equation.isExecutedAllLike = true
        
    }
    
}

extension MountainEquation: Equatable { }

func == (lhs: MountainEquation, rhs: MountainEquation) -> Bool {
    
    if (lhs.item === rhs.item) == false {
        
        return false
        
    }
    
    if (lhs.toItem === rhs.toItem) == false {
        
        return false
        
    }
    
    if (lhs.attribute == rhs.attribute) == false {
        
        return false
        
    }
    
    if (lhs.toItemAttribute == rhs.toItemAttribute) == false {
        
        return false
        
    }
    
    if (lhs.multiplier == rhs.multiplier) == false {
        
        return false
        
    }
    
    if (lhs.constant == rhs.constant) == false {
        
        return false
        
    }
    
    if (lhs.relation.actualRelation() == rhs.relation.actualRelation()) == false {
        
        return false
        
    }
    
    if (lhs.priority.actualPriority() == rhs.priority.actualPriority()) == false {
        
        return false
        
    }
    
    return true
    
}



