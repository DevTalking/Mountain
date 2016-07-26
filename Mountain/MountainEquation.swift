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
    
    init(modifier: Any, item: UIView, toItem: AnyObject? = nil) {
        
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
    
    convenience init(item: UIView) {
        
        let modifier = MountainModifier()
        self.init(modifier: modifier, item: item, toItem: item.superview)
        
    }
    
    convenience init(item: UIView, constant: Any, multiplier: MountainModifier, toItem: UIView? = nil) {
        
        self.init(modifier: constant, item: item, toItem: toItem)
        self.multiplier = multiplier.multiplier
        
    }
 
    func generateConstraint() -> NSLayoutConstraint {
        
        (self.item as! UIView).translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self.item, attribute: self.attribute!.actualAttribute(), relatedBy: self.relation.actualRelation(), toItem: self.toItem, attribute: self.toItemAttribute!.actualAttribute(), multiplier: self.multiplier, constant: self.constant)
        constraint.priority = self.priority.actualPriority()
        
        return constraint
        
    }
    
    func installEquation() {

        (self.item as! UIView).installedEquations.append(self)
        (self.item as! UIView).currentEquation = self
        
    }
    
    func like(view: UIView, _ attribute: MountainAttribute? = nil) {
        
        for e in (self.item as! UIView).installedEquations.reverse() {
            
            if e == self {
                
                if let att = attribute {
                    e.toItemAttribute = att
                } else {
                    e.toItemAttribute = e.attribute
                }
                e.toItem = view
                
                break
                
            }
            
        }
        
    }
    
    func allLike(view: UIView, _ attribute: MountainAttribute? = nil) {
        
        (self.item as! UIView).installedEquations.forEach {
            
            if !$0.isExecutedAllLike {
                
                $0.toItem = view
                if let att = attribute {
                    $0.toItemAttribute = att
                } else {
                    $0.toItemAttribute = $0.attribute
                }
                
            }
                        
            $0.isExecutedAllLike = true
            
        }
        
    }
    
    func to(view: UIView, _ attribute: MountainAttribute? = nil) {
        
        self.like(view, attribute)
        
    }
    
    func when(condition: Condition) {
        
        if !condition() {
            (self.item as! UIView).installedEquations.removeEquation(self)
            (self.item as! UIView).currentEquation = nil
        }
        
    }
    
    func allWhen(condition: Condition) {
        
        if !condition() {
            (self.item as! UIView).installedEquations.removeAll()
            (self.item as! UIView).currentEquation = nil
        }
        
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




