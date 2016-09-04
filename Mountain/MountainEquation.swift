//
//  Equation.swift
//  Mountain
//
//  Created by JaceFu on 16/7/11.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import UIKit

public typealias Condition = () -> Bool

class MountainEquation {
    
    var priority: MountainPriority
    var relation: MountainRelation
    var constant: CGFloat
    var multiplier: CGFloat
    var attribute: MountainAttribute?
    var item: MountainItem?
    var toItem: MountainItem?
    var toItemAttribute: MountainAttribute?
    var isExecutedAllLike = false
    
    init(modifier: Any, item: MountainItem, toItem: MountainItem? = nil) {
        
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
    
    convenience init(item: MountainItem) {
        
        let modifier = MountainModifier()
        self.init(modifier: modifier, item: item, toItem: item.parentView)
        
    }
 
    func generateConstraint() -> NSLayoutConstraint {

        self.item!.autoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self.item!, attribute: self.attribute!.actualAttribute(), relatedBy: self.relation.actualRelation(), toItem: self.toItem, attribute: self.toItemAttribute!.actualAttribute(), multiplier: self.multiplier, constant: self.constant)
        constraint.priority = self.priority.actualPriority()
        
        return constraint
        
    }
    
    func installEquation() {
        
        self.item!.installedEquations.append(self)
        self.item!.currentEquation = self
        
        let constraintsOnView = self.gatherConstraintsFromItem(self.item!)
        constraintsOnView.forEach {
            
            if $0.firstAttribute == self.attribute!.actualAttribute() {
                
                self.item!.parentView!.removeConstraint($0)
                self.item!.removeConstraint($0)
                
            }
            
        }
        
    }
    
    func like(item: MountainItem, _ attribute: MountainAttribute? = nil) {
        
        for e in self.item!.installedEquations.reverse() {
            
            if self.updateEquation(e, toItem: item, attribute: attribute) {
                
                break
                
            }
            
        }
        
    }
    
    func allLike(item: MountainItem, _ attribute: MountainAttribute? = nil) {
        
        self.item!.installedEquations.forEach {
            
            self.updateEquations($0, toItem: item, attribute: attribute)
            
        }
        
    }
    
    func to(item: MountainItem, _ attribute: MountainAttribute? = nil) {
        
        self.like(item, attribute)
        
    }
    
    func when(condition: Condition) {
        
        if !condition() {
            
            self.item!.installedEquations.removeEquation(self)
            self.item!.currentEquation = nil
            
        }
        
    }
    
    func allWhen(condition: Condition) {
        
        if !condition() {
            
            self.item!.installedEquations.removeAll()
            self.item!.currentEquation = nil

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
    
    // MARK: private methods
    
    private func updateEquation(equation: MountainEquation, toItem: MountainItem, attribute: MountainAttribute?) -> Bool {
        
        if equation == self {
            
            self.updateAttributeOfEquation(equation, attribute: attribute)
            
            equation.toItem = toItem
            
            return true
            
        }
        
        return false
        
    }
    
    private func updateEquations(equation: MountainEquation, toItem: MountainItem, attribute: MountainAttribute?) {
        
        if !equation.isExecutedAllLike {
            
            equation.toItem = toItem
            
            self.updateAttributeOfEquation(equation, attribute: attribute)
            
        }
        
        equation.isExecutedAllLike = true
        
    }
    
    private func updateAttributeOfEquation(equation: MountainEquation, attribute: MountainAttribute?) {
        
        if let att = attribute {
            
            equation.toItemAttribute = att
            
        } else {
            
            equation.toItemAttribute = equation.attribute
            
        }
        
    }
    
    private func gatherConstraintsFromItem(item: MountainItem) -> [NSLayoutConstraint]{
        
        var constraintsArray = [NSLayoutConstraint]()
        
        let constraintsOnParentView = item.parentView!.constraints.filter({ $0.firstItem === item })
        
        constraintsArray = constraintsArray + constraintsOnParentView
        
        if let view = item as? UIView {
            
            let constraintsOnView = view.constraints
            constraintsArray = constraintsArray + constraintsOnView
            
        }
        
        return constraintsArray
        
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



