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
    
    static func gatherConstraintsFromItem(item: AnyObject) -> [NSLayoutConstraint]{
        
        var constraintsArray = [NSLayoutConstraint]()
        
        if let view = item as? UIView {

            let constraintsOnView = view.constraints
            let constraintsOnSuperview = view.superview!.constraints.filter({ $0.firstItem === view })
            constraintsArray = constraintsArray + constraintsOnView + constraintsOnSuperview
            
        }
        
        if #available(iOS 9.0, *) {
            
            if let guide = item as? UILayoutGuide {
                
                let constraintsOnOwningView = guide.owningView!.constraints.filter({ $0.firstItem === guide })
                constraintsArray = constraintsArray + constraintsOnOwningView
                
            }
            
        }
        
        return constraintsArray
        
    }
    
    static func judgeSecondItem(item: AnyObject) -> AnyObject? {
        
        var secondItem: AnyObject?
        
        if let view = item as? UIView {
            
            secondItem = view.superview
            
        }
        
        if #available(iOS 9.0, *) {
            
            if let guide = item as? UILayoutGuide {
                
                secondItem = guide.owningView
                
            }
            
        }
        
        return secondItem
        
    }
    
}