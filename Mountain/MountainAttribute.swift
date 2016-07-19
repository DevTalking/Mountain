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
    
    // MARK: Position attributes
    case CenterX
    case CenterY
    case CenterXWithinMargins
    case CenterYWithinMargins
    
    case Top
    case TopMargin
    case Left
    case LeftMargin
    case Right
    case RightMargin
    case Bottom
    case BottomMargin
    
    // MARK: Default attribute
    case NotAnAttribute
    
    func actualAttribute() -> NSLayoutAttribute {
        
        switch self {
        case .Width:
            return .Width
        case .Height:
            return .Height
        case .CenterX:
            return .CenterX
        case .CenterY:
            return .CenterY
        case .CenterXWithinMargins:
            return .CenterXWithinMargins
        case .CenterYWithinMargins:
            return .CenterYWithinMargins
        case .Top:
            return .Top
        case .TopMargin:
            return .TopMargin
        case .Left:
            return .Left
        case .LeftMargin:
            return .LeftMargin
        case .Right:
            return .Right
        case .RightMargin:
            return .RightMargin
        case .Bottom:
            return .Bottom
        case .BottomMargin:
            return .BottomMargin
        case .NotAnAttribute:
            return .NotAnAttribute
        }
        
    }
    
}