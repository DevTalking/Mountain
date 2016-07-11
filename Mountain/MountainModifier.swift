//
//  Constant.swift
//  Mountain
//
//  Created by JaceFu on 16/7/11.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import Foundation

public struct MountainModifier {
    
    public var value: CGFloat
    public var relation: MountainRelation
    public var multiplier: CGFloat
    
    init(value: CGFloat) {
        self.value = value
        self.relation = .EqualTo
        self.multiplier = 1.0
    }
    
    init(value: CGFloat, _ relation: MountainRelation) {
        self.value = value
        self.relation = relation
        self.multiplier = 1.0
    }
    
}