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
    
    static func gatherConstraintsFromView(view: UIView) -> [NSLayoutConstraint]{
        
        var constraintsArray = [NSLayoutConstraint]()
        let constraintsOnView = view.constraints
        let constraintsOnSuperview = view.superview!.constraints.filter({ $0.firstItem as? UIView == view })
        constraintsArray = constraintsOnView + constraintsOnSuperview
        return constraintsArray
        
    }
    
}