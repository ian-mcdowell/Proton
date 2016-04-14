//
//  UILabel.swift
//  Pods
//
//  Created by Ian McDowell on 4/14/16.
//
//

import AppKit

public class BridgedUILabel<T: NSTextField>: BridgedUIView<T> {
    
    var text: String? {
        set {
            self.bridgedView.stringValue = newValue ?? ""
        }
        get {
            return self.bridgedView.stringValue
        }
    }
    var textAlignment: NSTextAlignment {
        set {
            self.bridgedView.alignment = textAlignment
        }
        get {
            return self.bridgedView.alignment
        }
    }
    
}