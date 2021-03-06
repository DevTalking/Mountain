//
//  Relation.swift
//  Mountain
//
//  Created by JaceFu on 16/7/11.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import Foundation

enum MountainRelation {
    
    case EqualTo
    case GreaterThanOrEqualTo
    case LessThanOrEqualTo
    
    func actualRelation() -> NSLayoutRelation {
        
        switch self {
        case .EqualTo:
            return .Equal
        case .GreaterThanOrEqualTo:
            return .GreaterThanOrEqual
        case .LessThanOrEqualTo:
            return .LessThanOrEqual
        }
        
    }
    
}

prefix operator <= {}

public prefix func <= (rightValue: CGFloat) -> MountainModifier {
    return MountainModifier(constant: rightValue, relation: .LessThanOrEqualTo)
}

prefix operator >= {}

public prefix func >= (rightValue: CGFloat) -> MountainModifier {
    return MountainModifier(constant: rightValue, relation: .GreaterThanOrEqualTo)
}