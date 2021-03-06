//
//  Constant.swift
//  Mountain
//
//  Created by JaceFu on 16/7/11.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import Foundation

public struct MountainModifier {
    
    var constant: CGFloat
    var relation: MountainRelation
    var multiplier: CGFloat
    
    init(constant: CGFloat? = nil, relation: MountainRelation? = nil, multiplier: CGFloat? = nil) {
        
        if let c = constant {
            self.constant = c
        } else {
            self.constant = 0.0
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