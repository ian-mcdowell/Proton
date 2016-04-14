//
//  UITextField.swift
//  Pods
//
//  Created by Ian McDowell on 4/14/16.
//
//

import AppKit

public class BridgedUITextField<T: NSTextField>: BridgedUIControl<T> {
    
    var text: String? {
        set {
            self.bridgedView.stringValue = newValue ?? ""
        }
        get {
            return self.bridgedView.stringValue
        }
    }
    
    var placeholder: String? {
        set {
            self.bridgedView.placeholderString = newValue
        }
        get {
            return self.bridgedView.placeholderString
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