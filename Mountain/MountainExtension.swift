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
    
    public func to(view: UIView, _ attribute: MountainAttribute? = nil) -> Self {
    
        self.currentEquation!.to(view, attribute)
        return self
    
    }
    
    public func with(priority: MountainPriority) -> Self {
        
        self.currentEquation!.with(priority)
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
    
    public func centerX(constantOrMultiplier: Any) -> Self {
        
        CenterX(modifier: constantOrMultiplier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func centerX(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        CenterX(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func centerXWithinMargins() -> Self {
        
        CenterXWithinMargins(item: self).installEquation()
        return self
        
    }
    
    public func centerXWithinMargins(constantOrMultiplier: Any) -> Self {
        
        CenterXWithinMargins(modifier: constantOrMultiplier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func centerXWithinMargins(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        CenterXWithinMargins(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func centerY() -> Self {

        CenterY(item: self).installEquation()
        return self
        
    }
    
    public func centerY(constantOrMultiplier: Any) -> Self {

        CenterY(modifier: constantOrMultiplier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func centerY(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        CenterY(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func centerYWithinMargins() -> Self {
        
        CenterYWithinMargins(item: self).installEquation()
        return self
        
    }
    
    public func centerYWithinMargins(constantOrMultiplier: Any) -> Self {
        
        CenterYWithinMargins(modifier: constantOrMultiplier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func centerYWithinMargins(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        CenterYWithinMargins(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
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
    
    public func centerXY(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        Center(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func centerXYWithinMargins() -> Self {
        
        CenterWithinMargins(item: self).installEquation()
        return self
        
    }
    
    public func centerXYWithinMargins(constantOrMultiplier: Any) -> Self {
        
        CenterWithinMargins(constantOrMultiplier: constantOrMultiplier, item: self).installEquation()
        return self
        
    }
    
    public func centerXYWithinMargins(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        CenterWithinMargins(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func top() -> Self {
        
        Top(item: self).installEquation()
        return self
        
    }
    
    public func top(constantOrMultiplier: Any) -> Self {
        
        Top(modifier: constantOrMultiplier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func top(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        Top(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func topMargin() -> Self {
        
        TopMargin(item: self).installEquation()
        return self
        
    }
    
    public func topMargin(constantOrMultiplier: Any) -> Self {
        
        TopMargin(modifier: constantOrMultiplier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func topMargin(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        TopMargin(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func left() -> Self {
        
        Left(item: self).installEquation()
        return self
        
    }
    
    public func left(constantOrMultiplier: Any) -> Self {
        
        Left(modifier: constantOrMultiplier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func left(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        Left(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func leftMargin() -> Self {
        
        LeftMargin(item: self).installEquation()
        return self
        
    }
    
    public func leftMargin(constantOrMultiplier: Any) -> Self {
        
        LeftMargin(modifier: constantOrMultiplier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func leftMargin(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        LeftMargin(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func right() -> Self {
        
        Right(item: self).installEquation()
        return self
        
    }
    
    public func right(constantOrMultiplier: Any) -> Self {
        
        Right(modifier: constantOrMultiplier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func right(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        Right(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func rightMargin() -> Self {
        
        RightMargin(item: self).installEquation()
        return self
        
    }
    
    public func rightMargin(constantOrMultiplier: Any) -> Self {
        
        RightMargin(modifier: constantOrMultiplier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func rightMargin(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        RightMargin(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func bottom() -> Self {
        
        Bottom(item: self).installEquation()
        return self
        
    }
    
    public func bottom(constantOrMultiplier: Any) -> Self {
        
        Bottom(modifier: constantOrMultiplier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func bottom(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        Bottom(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func bottomMargin() -> Self {
        
        BottomMargin(item: self).installEquation()
        return self
        
    }
    
    public func bottomMargin(constantOrMultiplier: Any) -> Self {
        
        BottomMargin(modifier: constantOrMultiplier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func bottomMargin(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        BottomMargin(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func leading() -> Self {
        
        Leading(item: self).installEquation()
        return self
        
    }
    
    public func leading(constantOrMultiplier: Any) -> Self {
        
        Leading(modifier: constantOrMultiplier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func leading(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        Leading(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func leadingMargin() -> Self {
        
        LeadingMargin(item: self).installEquation()
        return self
        
    }
    
    public func leadingMargin(constantOrMultiplier: Any) -> Self {
        
        LeadingMargin(modifier: constantOrMultiplier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func leadingMargin(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        LeadingMargin(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func trailing() -> Self {
        
        Trailing(item: self).installEquation()
        return self
        
    }
    
    public func trailing(constantOrMultiplier: Any) -> Self {
        
        Trailing(modifier: constantOrMultiplier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func trailing(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        Trailing(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func trailingMargin() -> Self {
        
        TrailingMargin(item: self).installEquation()
        return self
        
    }
    
    public func trailingMargin(constantOrMultiplier: Any) -> Self {
        
        TrailingMargin(modifier: constantOrMultiplier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func trailingMargin(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        TrailingMargin(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func firstBaseline() -> Self {
        
        FirstBaseline(item: self).installEquation()
        return self
        
    }
    
    public func firstBaseline(constantOrMultiplier: Any) -> Self {
        
        FirstBaseline(modifier: constantOrMultiplier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func firstBaseline(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        FirstBaseline(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func lastBaseline() -> Self {
        
        LastBaseline(item: self).installEquation()
        return self
        
    }
    
    public func lastBaseline(constantOrMultiplier: Any) -> Self {
        
        LastBaseline(modifier: constantOrMultiplier, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func lastBaseline(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        LastBaseline(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func edges() -> Self {
        
        Edges(item: self).installEquation()
        return self
        
    }
    
    public func edges(constantOrMultiplier: Any) -> Self {
        
        Edges(constantOrMultiplier: constantOrMultiplier, item: self).installEquation()
        return self
        
    }
    
    public func edges(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        Edges(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func edges(top t: Any, bottom b: Any, left l: Any, right r: Any) -> Self {
        
        Edges(top: t, bottom: b, left: l, right: r, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func margins() -> Self {
        
        Margins(item: self).installEquation()
        return self
        
    }
    
    public func margins(constantOrMultiplier: Any) -> Self {
        
        Margins(constantOrMultiplier: constantOrMultiplier, item: self).installEquation()
        return self
        
    }
    
    public func margins(multiplier: MountainModifier, _ constant: Any) -> Self {
        
        Margins(item: self, constant: constant, multiplier: multiplier, toItem: self.superview).installEquation()
        return self
        
    }
    
    public func margins(top t: Any, bottom b: Any, left l: Any, right r: Any) -> Self {
        
        Margins(top: t, bottom: b, left: l, right: r, item: self, toItem: self.superview).installEquation()
        return self
        
    }
    
}














