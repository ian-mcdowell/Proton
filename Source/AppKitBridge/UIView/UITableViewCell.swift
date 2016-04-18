//
//  UITableViewCell.swift
//  Pods
//
//  Created by Ian McDowell on 4/14/16.
//
//

import AppKit

public class BridgedUITableViewCell<T: NSTableRowView>: BridgedUIView<T> {
    
    public required init() {
        super.init(frame: CGRectZero)
    }
    
    public override required init?(existingValue: T?) {
        super.init(existingValue: existingValue)
    }
    
    public var identifier: String? {
        set {
            self.bridgedView.identifier = newValue
        }
        get {
            return self.bridgedView.identifier
        }
    }
    
//    public var contentView: UIView {
//        get {
//            return self as! BridgedUITableViewCell<NSTableRowView>
//        }
//    }
    
    public func layout() {
        self.bridgedView.layout()
    }
}