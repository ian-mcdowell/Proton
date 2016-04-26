//
//  UIToolbar.swift
//  Pods
//
//  Created by Ian McDowell on 4/26/16.
//
//

import AppKit

public class BridgedUIToolbar<T: NSToolbar>: BridgedView<T> {
    
    internal override init?(existingValue: T?) {
        super.init(existingValue: existingValue)
    }
    
    public override init() {
        super.init()
    }
    
}