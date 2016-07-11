//
//  Priority.swift
//  Mountain
//
//  Created by JaceFu on 16/7/11.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import Foundation

/**
 Priority enum which offers 3 pre-defined levels of `UILayoutPriority`, and a case which wrapping `Float` associated value to 
 custom priority.
 */
public enum MountainPriority {
    
    case HighPriority
    case MediumPriority
    case LowPriority
    case CustomPriority(Float)
    
    func actualPriority() -> Float {
        
        switch self {
        case .HighPriority:
            return 1000.0
        case .MediumPriority:
            return 500.0
        case .LowPriority:
            return 1.0
        case .CustomPriority(let value):
            return value
        }
        
    }
    
}