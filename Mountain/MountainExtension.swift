//
//  Extension.swift
//  Mountain
//
//  Created by JaceFu on 16/7/11.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import Foundation

extension UIView {
    
    // MARK: Dimension
    
    public func width(constant: Any) -> Self {

        Width(modifier: constant, item: self).generateConstraint()
        return self

    }
    
    public func width(when condition: Condition, _ constant: Any) -> Self {

        Width(modifier: constant, item: self).when(condition).generateConstraint()
        return self

    }
    
    public func width(like view: UIView, _ constantOrMultiplier: Any? = nil) -> Self {
        
        Width(item: self).like(view, constantOrMultiplier: constantOrMultiplier).generateConstraint()
        return self
        
    }
    
    public func width(like view: UIView, _ attribute: MountainAttribute, _ constantOrMultiplier: Any? = nil) -> Self {
        
        Width(item: self).like(view, attribute: attribute, constantOrMultiplier: constantOrMultiplier).generateConstraint()
        return self
        
    }
    
    public func width(like view: UIView, _ attribute: MountainAttribute, _ constant: Any, _ multiplier: MountainModifier) -> Self {
    
        Width(item: self).like(view, attribute: attribute, constant: constant, multiplier: multiplier).generateConstraint()
        return self

    }
    
    public func height(constant: Any) -> Self {

        Height(modifier: constant, item: self).generateConstraint()
        return self

    }
    
    public func height(when condition: Condition, _ constant: Any) -> Self {

        Height(modifier: constant, item: self).when(condition).generateConstraint()
        return self

    }
    
    public func height(like view: UIView, _ constantOrMultiplier: Any? = nil) -> Self {
        
        Height(item: self).like(view, constantOrMultiplier: constantOrMultiplier).generateConstraint()
        return self
        
    }
    
    public func height(like view: UIView, _ attribute: MountainAttribute, _ constantOrMultiplier: Any? = nil) -> Self {
        
        Height(item: self).like(view, attribute: attribute, constantOrMultiplier: constantOrMultiplier).generateConstraint()
        return self
        
    }
    
    public func height(like view: UIView, _ attribute: MountainAttribute, _ constant: Any, _ multiplier: MountainModifier) -> Self {
        
        Height(item: self).like(view, attribute: attribute, constant: constant, multiplier: multiplier).generateConstraint()
        return self
        
    }
    
    public func size(modifier: Any) -> Self {

        Width(modifier: modifier, item: self).generateConstraint()
        Height(modifier: modifier, item: self).generateConstraint()
        return self

    }
    
    public func size(width w: Any, height h: Any) -> Self {

        Width(modifier: w, item: self).generateConstraint()
        Height(modifier: h, item: self).generateConstraint()
        return self

    }
    
    public func size(like view: UIView, _ constantOrMultiplier: Any? = nil) -> Self {
        
        Width(item: self).like(view, constantOrMultiplier: constantOrMultiplier).generateConstraint()
        Height(item: self).like(view, constantOrMultiplier: constantOrMultiplier).generateConstraint()
        return self
    }
    
    // MARK: Position
    
    public func centerX() -> Self {
        
        CenterX(item: self).generateConstraint()
        return self
        
    }
    
    public func centerX(modifier: Any) -> Self {
        
        CenterX(modifier: modifier, item: self, toItem: self.superview).generateConstraint()
        return self
        
    }
    
    public func centerXWithinMargins() -> Self {
        
        CenterXWithinMargins(item: self).generateConstraint()
        return self
        
    }
    
    public func centerXWithinMargins(modifier: Any) -> Self {
        
        CenterXWithinMargins(modifier: modifier, item: self, toItem: self.superview).generateConstraint()
        return self
        
    }
    
    public func centerY() -> Self {

        CenterY(item: self).generateConstraint()
        return self
        
    }
    
    public func centerY(modifier: Any) -> Self {

        CenterY(modifier: modifier, item: self, toItem: self.superview).generateConstraint()
        return self
        
    }
    
    public func centerYWithinMargins() -> Self {
        
        CenterYWithinMargins(item: self).generateConstraint()
        return self
        
    }
    
    public func centerYWithinMargins(modifier: Any) -> Self {
        
        CenterYWithinMargins(modifier: modifier, item: self, toItem: self.superview).generateConstraint()
        return self
        
    }
    
    public func top() -> Self {
        
        Top(item: self).generateConstraint()
        return self
        
    }
    
    public func top(modifier: Any) -> Self {
        
        Top(modifier: modifier, item: self, toItem: self.superview).generateConstraint()
        return self
        
    }
    
    public func topMargin(modifier: Any) -> Self {
        
        TopMargin(modifier: modifier, item: self, toItem: self.superview).generateConstraint()
        return self
        
    }
    
    public func topMargin() -> Self {
        
        TopMargin(item: self).generateConstraint()
        return self
        
    }
    
}














