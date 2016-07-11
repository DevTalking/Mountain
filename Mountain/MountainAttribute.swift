//
//  Attribute.swift
//  Mountain
//
//  Created by JaceFu on 16/7/11.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import Foundation

public enum MountainAttribute {

    // MARK: Dimension attributes
    case Width
    case Height
    
    // MARK: Default attribute
    case NotAnAttribute
    
    func actualAttribute() -> NSLayoutAttribute {
        
        switch self {
        case .Width:
            return .Width
        case .Height:
            return .Height
        case .NotAnAttribute:
            return .NotAnAttribute
        }
        
    }
    
}