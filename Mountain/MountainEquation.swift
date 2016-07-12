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
    var condition: Condition?
    
    init(modifier: Any, item: UIView, toItem: AnyObject? = nil) {
        
        if modifier is MountainModifier {
            self.relation = (modifier as! MountainModifier).relation
            self.constant = (modifier as! MountainModifier).value
            self.multiplier = (modifier as! MountainModifier).multiplier
        } else {
            self.relation = MountainModifier(value: MountainTool.convertToCGFloat(modifier)).relation
            self.constant = MountainModifier(value: MountainTool.convertToCGFloat(modifier)).value
            self.multiplier = MountainModifier(value: MountainTool.convertToCGFloat(modifier)).multiplier
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
        
    }
    
    convenience init(item: UIView) {
        
        let modifier = MountainModifier()
        self.init(modifier: modifier, item: item, toItem: item.superview)
        
    }
    
    func when(condition: Condition) -> Self {
        
        self.condition = condition
        return self
        
    }
        
    func generateConstraint() {
        
        guard let att = self.attribute, let toAtt = self.toItemAttribute else {
            return
        }
        
        if !(self.condition?() ?? true) {
            return
        }
        
        (self.item as! UIView).translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: self.item, attribute: att.actualAttribute(), relatedBy: self.relation.actualRelation(), toItem: self.toItem, attribute: toAtt.actualAttribute(), multiplier: self.multiplier, constant: self.constant)
        constraint.priority = self.priority.actualPriority()
        constraint.active = true
        
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
        default:
            return .NotAnAttribute
        }
        
    }
    
}






