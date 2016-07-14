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
    
}




