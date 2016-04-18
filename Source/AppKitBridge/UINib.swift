//
//  UINib.swift
//  Pods
//
//  Created by Ian McDowell on 4/14/16.
//
//

import AppKit

public class BridgedUINib<T: NSNib>: BridgedView<T> {
    
    internal override init?(existingValue: T?) {
        super.init(existingValue: existingValue)
    }
    
    public override init() {
        super.init()
    }
    
}