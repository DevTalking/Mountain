//
//  Constant.swift
//  Mountain
//
//  Created by JaceFu on 16/7/11.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import Foundation

public struct MountainModifier {
    
    var value: CGFloat
    var relation: MountainRelation
    var multiplier: CGFloat
    
    init(value: CGFloat? = nil, relation: MountainRelation? = nil, multiplier: CGFloat? = nil) {
        
        if let v = value {
            self.value = v
        } else {
            self.value = 0.0
        }
        
        if let r = relation {
            self.relation = r
        } else {
            self.relation = .EqualTo
        }
        
        if let m = multiplier {
            self.multiplier = m
        } else {
            self.multiplier = 1.0
        }
        
    }
    
}

prefix operator * {}

public prefix func * (rightValue: CGFloat) -> MountainModifier {
    
    return MountainModifier(multiplier: rightValue)
    
}