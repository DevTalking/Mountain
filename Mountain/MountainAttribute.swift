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
    
    case Leading
    case LeadingMargin
    case Trailing
    case TrailingMargin
    
    // MARK: Baseline attribute
    case FirstBaseline
    case LastBaseline
    
    // MARK: Default attribute
    case NotAnAttribute
    
    var ifShouldInvertConstant: Bool {
        switch self {
        case .Width: return false
        case .Height: return false
        case .Left: return false
        case .Right: return true
        case .Top: return false
        case .Bottom:return true
        case .Leading: return false
        case .Trailing: return true
        case .CenterX: return false
        case .CenterY: return false
        case .LeftMargin: return false
        case .RightMargin: return true
        case .TopMargin: return false
        case .BottomMargin: return true
        case .LeadingMargin: return false
        case .TrailingMargin: return true
        case .CenterXWithinMargins: return false
        case .CenterYWithinMargins: return false
        case .FirstBaseline: return false
        case .LastBaseline: return true
        case .NotAnAttribute: return false
        }
    }
    
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
        case .Leading:
            return .Leading
        case .LeadingMargin:
            return .LeadingMargin
        case .Trailing:
            return .Trailing
        case .TrailingMargin:
            return .TrailingMargin
        case .FirstBaseline:
            return .FirstBaseline
        case .LastBaseline:
            return .LastBaseline
        case .NotAnAttribute:
            return .NotAnAttribute
        }
        
    }
    
}