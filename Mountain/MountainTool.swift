//
//  MountainTool.swift
//  Mountain
//
//  Created by JaceFu on 16/7/11.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import Foundation

class MountainTool {
    
    static func convertToCGFloat(modifier: Any) -> CGFloat {
        
        if modifier is Int {
            return CGFloat(modifier as! Int)
        } else if modifier is Double {
            return CGFloat(modifier as! Double)
        } else if modifier is Float {
            return CGFloat(modifier as! Float)
        }
        
        return CGFloat()
        
    }
    
}