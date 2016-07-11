//
//  Equation.swift
//  Mountain
//
//  Created by JaceFu on 16/7/11.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import UIKit

/**
 This is the abstraction of **item1.attribute1 = multiplier × item2.attribute2 + constant** equation.
 */
public class MountainEquation {
    
    var priority: MountainPriority
    var relation: MountainRelation
    var constant: CGFloat
    var multiplier: CGFloat
    var attribute: MountainAttribute?
    var toItem: AnyObject?
    var toItemAttribute: MountainAttribute?
    
    init(modifier: MountainModifier) {
        
        self.priority = .HighPriority
        self.relation = modifier.relation
        self.constant = modifier.value
        self.multiplier = modifier.multiplier
        self.attribute = attributeFromClass()
        self.toItemAttribute = self.toItem == nil ? .NotAnAttribute : attributeFromClass()
        
    }
    
    func generateConstraint(view: UIView) {
        
        guard let att = self.attribute, let toAtt = self.toItemAttribute, let sv = view.superview else {
            return
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(item: sv, attribute: att.actualAttribute(), relatedBy: self.relation.actualRelation(), toItem: self.toItem, attribute: toAtt.actualAttribute(), multiplier: self.multiplier, constant: self.constant)
        constraint.priority = self.priority.actualPriority()
        constraint.active = true
        
    }
    
    private func attributeFromClass() -> MountainAttribute {
        
        switch self {
        case is Width:
            return .Width
        case is Height:
            return .Height
        default:
            return .NotAnAttribute
        }
        
    }
    
}