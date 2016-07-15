//
//  Extension.swift
//  Mountain
//
//  Created by JaceFu on 16/7/11.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import Foundation

var installedConstraintKey: Int = 0
var currentEquationKey: Int = 1

extension Array where Element: MountainEquation {
    
    func convertToConstraints() -> [NSLayoutConstraint] {
        
        return self.map({ $0.generateConstraint() })
        
    }
    
    mutating func removeEquation(equation: MountainEquation) {
        
        for (index, e) in self.enumerate().reverse() {
            
            if e == equation {
                
                self.removeAtIndex(index)
                break
                
            }
            
        }
        
    }
    
}

extension UIView {
    
    // MARK: Associate object
    
    var installedEquations: [MountainEquation] {
        
        get {
            
            if let installedEquations = objc_getAssociatedObject(self, &installedConstraintKey) as? [MountainEquation] {
                
                return installedEquations
                
            }
            
            return []
            
        }
        
        set {
            
            objc_setAssociatedObject(self, &installedConstraintKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
        
    }
    
    var currentEquation: MountainEquation? {
        
        get {
            
            if let currentEquation = objc_getAssociatedObject(self, &currentEquationKey) as? MountainEquation {
                
                return currentEquation
                
            }
            
            return nil
            
        }
        
        set {
            
            objc_setAssociatedObject(self, &currentEquationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
        
    }
    
    // MARK: Instruction
    
    public func climb() {
        
        NSLayoutConstraint.activateConstraints(self.installedEquations.convertToConstraints())
        self.installedEquations.removeAll()
        self.currentEquation = nil
        
    }
    
    public func when(condition: Condition) -> Self {
        
        self.currentEquation!.when(condition)
        return self
        
    }
    
    public func allWhen(condition: Condition) -> Self {
        
        self.currentEquation!.allWhen(condition)
        return self
        
    }
    
    public func like(view: UIView, _ attribute: MountainAttribute? = nil) -> Self {
        
        self.currentEquation!.like(view, attribute)
        return self
        
    }
    
    public func allLike(view: UIView, _ attribute: MountainAttribute? = nil) -> Self {
        
        self.currentEquation!.allLike(view, attribute)
        return self
        
    }
    
    // MARK: Dimension
    
    public func width() -> Self {
        
        Width(item: self).installEquation()
        return self
        
    }
    
    public func width(constantOrMultiplier: Any) -> Self {

        Width(modifier: constantOrMultiplier, item: self).installEquation()
        return self

    }
    
    public func width(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        Width(item: self, constant: constant, multiplier: multiplier).installEquation()
        return self
        
    }
    
    public func height() -> Self {
        
        Height(item: self).installEquation()
        return self
        
    }
    
    public func height(constantOrMultiplier: Any) -> Self {

        Height(modifier: constantOrMultiplier, item: self).installEquation()
        return self

    }
    
    public func height(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        Height(item: self, constant: constant, multiplier: multiplier).installEquation()
        return self
        
    }
    
    public func size() -> Self {
        
        Size(item: self).installEquation()
        return self
        
    }
    
    public func size(constantOrMultiplier: Any) -> Self {

        Size(constantOrMultiplier: constantOrMultiplier, item: self).installEquation()
        return self

    }
    
    public func size(width w: Any, height h: Any) -> Self {

        Size(width: w, height: h, item: self).installEquation()
        return self

    }
    
    public func size(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        Size(item: self, constant: constant, multiplier: multiplier).installEquation()
        return self
        
    }
    
    // MARK: Position
    
    public func centerX() -> Self {
        
        CenterX(item: self).installEquation()
        return self
        
    }
    
    public func centerX(modifier: Any) -> Self {
        
        CenterX(modifier: modifier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func centerXWithinMargins() -> Self {
        
        CenterXWithinMargins(item: self).installEquation()
        return self
        
    }
    
    public func centerXWithinMargins(modifier: Any) -> Self {
        
        CenterXWithinMargins(modifier: modifier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func centerY() -> Self {

        CenterY(item: self).installEquation()
        return self
        
    }
    
    public func centerY(modifier: Any) -> Self {

        CenterY(modifier: modifier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func centerYWithinMargins() -> Self {
        
        CenterYWithinMargins(item: self).generateConstraint()
        return self
        
    }
    
    public func centerYWithinMargins(modifier: Any) -> Self {
        
        CenterYWithinMargins(modifier: modifier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func centerXY() -> Self {
        
        Center(item: self).installEquation()
        return self
        
    }
    
    public func centerXY(constantOrMultiplier: Any) -> Self {
        
        Center(constantOrMultiplier: constantOrMultiplier, item: self).installEquation()
        return self
        
    }
    
    public func top() -> Self {
        
        Top(item: self).installEquation()
        return self
        
    }
    
    public func top(modifier: Any) -> Self {
        
        Top(modifier: modifier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func topMargin(modifier: Any) -> Self {
        
        TopMargin(modifier: modifier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func topMargin() -> Self {
        
        TopMargin(item: self).installEquation()
        return self
        
    }
    
}














