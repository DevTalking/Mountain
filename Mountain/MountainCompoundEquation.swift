//
//  MountainCompoundEquation.swift
//  Mountain
//
//  Created by JaceFu on 16/7/14.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import Foundation

class MountainCompoundEquation: MountainEquation {
    
    var equations: [MountainEquation] = []

    override func installEquation() {
        
        self.equations.forEach({ $0.installEquation() })
        (self.item as! UIView).currentEquation = self
        
    }
    
    override func like(view: UIView, _ attribute: MountainAttribute?) {
        
        self.equations.forEach({ $0.like(view, attribute) })
        
    }
    
    override func when(condition: Condition) {
        self.equations.forEach({ $0.when(condition) })
    }
    
}

class Size: MountainCompoundEquation {
    
    override init(modifier: Any, item: UIView, toItem: AnyObject?) {
        super.init(modifier: modifier, item: item, toItem: toItem)
    }

    convenience init(constantOrMultiplier: Any, item: UIView) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: nil)
        
        self.equations.append(Width(modifier: constantOrMultiplier, item: item))
        self.equations.append(Height(modifier: constantOrMultiplier, item: item))
        
    }
    
    convenience init(width w: Any, height h: Any, item: UIView) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: nil)
        
        self.equations.append(Width(modifier: w, item: item))
        self.equations.append(Height(modifier: h, item: item))
        
    }
    
    convenience init(item: UIView) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: nil)
        
        self.equations.append(Width(item: item))
        self.equations.append(Height(item: item))
        
    }
    
    convenience init(item: UIView, constant: Any, multiplier: MountainModifier, toItem: UIView? = nil) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: toItem)
        
        self.equations.append(Width(item: item, constant: constant, multiplier: multiplier))
        self.equations.append(Height(item: item, constant: constant, multiplier: multiplier))
        
    }
    
}

class Center: MountainCompoundEquation {
    
    override init(modifier: Any, item: UIView, toItem: AnyObject?) {
        
        super.init(modifier: modifier, item: item, toItem: toItem)
        
    }
    
    convenience init(constantOrMultiplier: Any, item: UIView) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: nil)
        
        self.equations.append(CenterX(modifier: constantOrMultiplier, item: item, toItem: item.superview))
        self.equations.append(CenterY(modifier: constantOrMultiplier, item: item, toItem: item.superview))
        
    }
    
    convenience init(item: UIView) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: nil)
        
        self.equations.append(CenterX(item: item))
        self.equations.append(CenterY(item: item))
        
    }
    
    convenience init(item: UIView, constant: Any, multiplier: MountainModifier, toItem: UIView? = nil) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: toItem)
        
        self.equations.append(CenterX(item: item, constant: constant, multiplier: multiplier, toItem: toItem))
        self.equations.append(CenterY(item: item, constant: constant, multiplier: multiplier, toItem: toItem))
        
    }
    
}

class Edges: MountainCompoundEquation {
    
    override init(modifier: Any, item: UIView, toItem: AnyObject?) {
        
        super.init(modifier: modifier, item: item, toItem: toItem)
        
    }
    
    convenience init(constantOrMultiplier: Any, item: UIView) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: nil)
        
        self.equations.append(Top(modifier: constantOrMultiplier, item: item, toItem: item.superview))
        self.equations.append(Bottom(modifier: constantOrMultiplier, item: item, toItem: item.superview))
        self.equations.append(Left(modifier: constantOrMultiplier, item: item, toItem: item.superview))
        self.equations.append(Right(modifier: constantOrMultiplier, item: item, toItem: item.superview))
        
    }
    
    convenience init(item: UIView) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: nil)
        
        self.equations.append(Top(item: item))
        self.equations.append(Bottom(item: item))
        self.equations.append(Left(item: item))
        self.equations.append(Right(item: item))
        
    }
    
    convenience init(item: UIView, constant: Any, multiplier: MountainModifier, toItem: UIView? = nil) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: toItem)
        
        self.equations.append(Top(item: item, constant: constant, multiplier: multiplier, toItem: toItem))
        self.equations.append(Bottom(item: item, constant: constant, multiplier: multiplier, toItem: toItem))
        self.equations.append(Left(item: item, constant: constant, multiplier: multiplier, toItem: toItem))
        self.equations.append(Right(item: item, constant: constant, multiplier: multiplier, toItem: toItem))
        
    }
    
    convenience init(top t: Any, bottom b: Any, left l: Any, right r: Any, item: UIView, toItem: UIView? = nil) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: toItem)
        
        self.equations.append(Top(modifier: t, item: item, toItem: toItem))
        self.equations.append(Bottom(modifier: b, item: item, toItem: toItem))
        self.equations.append(Left(modifier: l, item: item, toItem: toItem))
        self.equations.append(Right(modifier: r, item: item, toItem: toItem))
        
    }
    
}




