//
//  MountainPositionEquation.swift
//  Mountain
//
//  Created by JaceFu on 16/7/12.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import Foundation

class MountainPositionEquation: MountainEquation {
    
    override init(modifier: Any, item: MountainItem, toItem: MountainItem? = nil) {
        
        super.init(modifier: modifier, item: item, toItem: item.parentView)
        
    }
    
    convenience init(item: MountainItem, constant: Any, multiplier: MountainModifier) {
        
        self.init(modifier: constant, item: item, toItem: item.parentView)
        self.multiplier = multiplier.multiplier
        
    }
    
}

class CenterX: MountainPositionEquation { }

class CenterY: MountainPositionEquation { }

class CenterXWithinMargins: MountainPositionEquation { }

class CenterYWithinMargins: MountainPositionEquation { }

class Top: MountainPositionEquation { }

class TopMargin: MountainPositionEquation { }

class Left: MountainPositionEquation { }

class LeftMargin: MountainPositionEquation { }

class Right: MountainPositionEquation { }

class RightMargin: MountainPositionEquation { }

class Bottom: MountainPositionEquation { }

class BottomMargin: MountainPositionEquation { }

class Leading: MountainPositionEquation { }

class LeadingMargin: MountainPositionEquation { }

class Trailing: MountainPositionEquation { }

class TrailingMargin: MountainPositionEquation { }

class FirstBaseline: MountainPositionEquation { }

class LastBaseline: MountainPositionEquation { }