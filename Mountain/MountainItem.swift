//
//  MountainItem.swift
//  Mountain
//
//  Created by JaceFu on 16/8/25.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import Foundation

var installedConstraintKey: Int = 0
var currentEquationKey: Int = 1

public protocol MountainItem: NSObjectProtocol {
    
}

extension MountainItem {

    // MARK: Associate object
    
    var installedEquations: [MountainEquation] {
        
        get {
            
            if let installedEquations = objc_getAssociatedObject(self, &installedConstraintKey) as? [MountainEquation] {
                
                return installedEquations
                
            }
            
            return []
            
        }
        
        set {
            
            objc_setAssociatedObject(self, &installedConstraintKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
        
    }
    
    var currentEquation: MountainEquation? {
        
        get {
            
            if let currentEquation = objc_getAssociatedObject(self, &currentEquationKey) as? MountainEquation {
                
                return currentEquation
                
            }
            
            return nil
            
        }
        
        set {
            
            objc_setAssociatedObject(self, &currentEquationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
        
    }
    
    // MARK: Width
    
    public func width() -> Self {
        
        Width(item: self.dynamicType).installEquation()
        return self
        
    }
    
    public func width(constantOrMultiplier: Any) -> Self {
        
        Width(modifier: constantOrMultiplier, item: self.dynamicType).installEquation()
        return self
        
    }
    
}
