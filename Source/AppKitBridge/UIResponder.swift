//
//  UIResponder.swift
//  Pods
//
//  Created by Ian McDowell on 4/13/16.
//
//

import AppKit

public class BridgedUIResponder<T: NSResponder>: BridgedView<T> {
    
    internal override init?(existingValue: T?) {
        super.init(existingValue: existingValue)
    }
    
    public override init() {
        super.init()
    }
    
    public func nextResponder() -> UIResponder? {
        return UIResponder(existingValue: self.bridgedView.nextResponder)
    }

}