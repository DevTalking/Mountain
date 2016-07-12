//
//  DimensionEquation.swift
//  Mountain
//
//  Created by JaceFu on 16/7/11.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import Foundation

class MountainDimensionEquation: MountainEquation {
    
    func like(item: UIView, attribute: MountainAttribute? = nil, constantOrMultiplier: Any? = nil) -> Self {
        
        self.toItem = item
        
        if let attr = attribute {
            self.toItemAttribute = attr
        } else {
            self.toItemAttribute = self.attribute
        }
        
        if constantOrMultiplier is MountainModifier {
            if let com = constantOrMultiplier as? MountainModifier {
                self.constant = com.value
                self.relation = com.relation
                self.multiplier = com.multiplier
            }
        } else {
            let modifier = MountainModifier(value: MountainTool.convertToCGFloat(constantOrMultiplier))
            self.constant = modifier.value
            self.relation = modifier.relation
            self.multiplier = modifier.multiplier
        }
        
        
        return self
        
    }
    
    func like(item: UIView, attribute: MountainAttribute? = nil, constant: Any? = nil, multiplier: MountainModifier? = nil) -> Self {
    
        like(item, attribute: attribute, constantOrMultiplier: constant)
        
        if let m = multiplier {
            self.multiplier = m.multiplier
        }
        
        return self
    
    }
    
}

class Width: MountainDimensionEquation { }

class Height: MountainDimensionEquation { }
