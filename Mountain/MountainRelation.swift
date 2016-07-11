//
//  Relation.swift
//  Mountain
//
//  Created by JaceFu on 16/7/11.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import Foundation

/**
 Relation enum which offers 3 relationships between the first attribute and the modified second attribute in a constraint.
 */
public enum Relation {
    
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

public prefix func <= (rightValue: CGFloat) -> Modifier {
    return Modifier(value: rightValue, .LessThanOrEqualTo)
}

prefix operator >= {}

public prefix func >= (rightValue: CGFloat) -> Modifier {
    return Modifier(value: rightValue, .GreaterThanOrEqualTo)
}