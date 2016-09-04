//
//  DimensionEquation.swift
//  Mountain
//
//  Created by JaceFu on 16/7/11.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import Foundation

class MountainDimensionEquation: MountainEquation {
    
    override init(modifier: Any, item: MountainItem, toItem: MountainItem? = nil) {
        
        super.init(modifier: modifier, item: item, toItem: toItem)
        
    }
    
    convenience init(item: MountainItem, constant: Any, multiplier: MountainModifier) {
        
        self.init(modifier: constant, item: item, toItem: nil)
        self.multiplier = multiplier.multiplier
        
    }
    
}

class Width: MountainDimensionEquation { }

class Height: MountainDimensionEquation { }
