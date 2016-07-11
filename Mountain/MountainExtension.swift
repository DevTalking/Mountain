//
//  Extension.swift
//  Mountain
//
//  Created by JaceFu on 16/7/11.
//  Copyright © 2016年 DevTalking. All rights reserved.
//

import Foundation

extension UIView {
    
    public func width(modifier: MountainModifier) -> Self {
        Width(modifier: modifier).generateConstraint(self)
        return self
    }
    
    public func height(modifier: MountainModifier) -> Self {
        Height(modifier: modifier).generateConstraint(self)
        return self
    }
    
}