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
        
        if let view = item as? UIView {
            view.currentEquation = self
        }
        
        if #available(iOS 9.0, *) {
            
            if let guide = item as? UILayoutGuide {
                guide.currentEquation = self
            }
            
        }
        
    }
    
    override func like(item: AnyObject, _ attribute: MountainAttribute?) {
        
        self.equations.forEach({ $0.like(item, attribute) })
        
    }
    
    override func when(condition: Condition) {
        self.equations.forEach({ $0.when(condition) })
    }
    
}

class Size: MountainCompoundEquation {
    
    override init(modifier: Any, item: AnyObject, toItem: AnyObject? = nil) {
        
        super.init(modifier: modifier, item: item, toItem: toItem)
        
    }

    convenience init(constantOrMultiplier: Any, item: AnyObject) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: nil)
        
        self.equations.append(Width(modifier: constantOrMultiplier, item: item))
        self.equations.append(Height(modifier: constantOrMultiplier, item: item))
        
    }
    
    convenience init(width w: Any, height h: Any, item: AnyObject) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: nil)
        
        self.equations.append(Width(modifier: w, item: item))
        self.equations.append(Height(modifier: h, item: item))
        
    }
    
    convenience init(item: AnyObject) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: nil)
        
        self.equations.append(Width(item: item))
        self.equations.append(Height(item: item))
        
    }
    
    convenience init(item: AnyObject, constant: Any, multiplier: MountainModifier, toItem: AnyObject? = nil) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: toItem)
        
        self.equations.append(Width(item: item, constant: constant, multiplier: multiplier))
        self.equations.append(Height(item: item, constant: constant, multiplier: multiplier))
        
    }
    
}

class Center: MountainCompoundEquation {
    
    override init(modifier: Any, item: AnyObject, toItem: AnyObject? = nil) {
        
        super.init(modifier: modifier, item: item, toItem: toItem)
        
    }
    
    convenience init(constantOrMultiplier: Any, item: AnyObject) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: nil)
        
        self.equations.append(CenterX(modifier: constantOrMultiplier, item: item))
        self.equations.append(CenterY(modifier: constantOrMultiplier, item: item))
        
    }
    
    convenience init(item: AnyObject) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: nil)
        
        self.equations.append(CenterX(item: item))
        self.equations.append(CenterY(item: item))
        
    }
    
    convenience init(item: AnyObject, constant: Any, multiplier: MountainModifier, toItem: AnyObject? = nil) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: toItem)
        
        self.equations.append(CenterX(item: item, constant: constant, multiplier: multiplier))
        self.equations.append(CenterY(item: item, constant: constant, multiplier: multiplier))
        
    }
    
}

class CenterWithinMargins: MountainCompoundEquation {
    
    override init(modifier: Any, item: AnyObject, toItem: AnyObject? = nil) {
        
        super.init(modifier: modifier, item: item, toItem: toItem)
        
    }
    
    convenience init(constantOrMultiplier: Any, item: AnyObject) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: nil)
        
        self.equations.append(CenterXWithinMargins(modifier: constantOrMultiplier, item: item))
        self.equations.append(CenterYWithinMargins(modifier: constantOrMultiplier, item: item))
        
    }
    
    convenience init(item: AnyObject) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: nil)
        
        self.equations.append(CenterXWithinMargins(item: item))
        self.equations.append(CenterYWithinMargins(item: item))
        
    }
    
    convenience init(item: AnyObject, constant: Any, multiplier: MountainModifier, toItem: AnyObject? = nil) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: toItem)
        
        self.equations.append(CenterXWithinMargins(item: item, constant: constant, multiplier: multiplier))
        self.equations.append(CenterYWithinMargins(item: item, constant: constant, multiplier: multiplier))
        
    }
    
}

class Edges: MountainCompoundEquation {
    
    override init(modifier: Any, item: AnyObject, toItem: AnyObject? = nil) {
        
        super.init(modifier: modifier, item: item, toItem: toItem)
        
    }
    
    convenience init(constantOrMultiplier: Any, item: AnyObject) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: nil)
        
        self.equations.append(Top(modifier: constantOrMultiplier, item: item))
        self.equations.append(Bottom(modifier: constantOrMultiplier, item: item))
        self.equations.append(Left(modifier: constantOrMultiplier, item: item))
        self.equations.append(Right(modifier: constantOrMultiplier, item: item))
        
    }
    
    convenience init(item: AnyObject) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: nil)
        
        self.equations.append(Top(item: item))
        self.equations.append(Bottom(item: item))
        self.equations.append(Left(item: item))
        self.equations.append(Right(item: item))
        
    }
    
    convenience init(item: AnyObject, constant: Any, multiplier: MountainModifier, toItem: AnyObject? = nil) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: toItem)
        
        self.equations.append(Top(item: item, constant: constant, multiplier: multiplier))
        self.equations.append(Bottom(item: item, constant: constant, multiplier: multiplier))
        self.equations.append(Left(item: item, constant: constant, multiplier: multiplier))
        self.equations.append(Right(item: item, constant: constant, multiplier: multiplier))
        
    }
    
    convenience init(top t: Any, bottom b: Any, left l: Any, right r: Any, item: AnyObject, toItem: AnyObject? = nil) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: toItem)
        
        self.equations.append(Top(modifier: t, item: item))
        self.equations.append(Bottom(modifier: b, item: item))
        self.equations.append(Left(modifier: l, item: item))
        self.equations.append(Right(modifier: r, item: item))
        
    }
    
}

class Margins: MountainCompoundEquation {
    
    override init(modifier: Any, item: AnyObject, toItem: AnyObject? = nil) {
        
        super.init(modifier: modifier, item: item, toItem: toItem)
        
    }
    
    convenience init(constantOrMultiplier: Any, item: AnyObject) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: nil)
        
        self.equations.append(TopMargin(modifier: constantOrMultiplier, item: item))
        self.equations.append(BottomMargin(modifier: constantOrMultiplier, item: item))
        self.equations.append(LeftMargin(modifier: constantOrMultiplier, item: item))
        self.equations.append(RightMargin(modifier: constantOrMultiplier, item: item))
        
    }
    
    convenience init(item: AnyObject) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: nil)
        
        self.equations.append(TopMargin(item: item))
        self.equations.append(BottomMargin(item: item))
        self.equations.append(LeftMargin(item: item))
        self.equations.append(RightMargin(item: item))
        
    }
    
    convenience init(item: AnyObject, constant: Any, multiplier: MountainModifier, toItem: AnyObject? = nil) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: toItem)
        
        self.equations.append(TopMargin(item: item, constant: constant, multiplier: multiplier))
        self.equations.append(BottomMargin(item: item, constant: constant, multiplier: multiplier))
        self.equations.append(LeftMargin(item: item, constant: constant, multiplier: multiplier))
        self.equations.append(RightMargin(item: item, constant: constant, multiplier: multiplier))
        
    }
    
    convenience init(top t: Any, bottom b: Any, left l: Any, right r: Any, item: AnyObject, toItem: AnyObject? = nil) {
        
        self.init(modifier: MountainModifier(), item: item, toItem: toItem)
        
        self.equations.append(TopMargin(modifier: t, item: item))
        self.equations.append(BottomMargin(modifier: b, item: item))
        self.equations.append(LeftMargin(modifier: l, item: item))
        self.equations.append(RightMargin(modifier: r, item: item))
        
    }
    
}



