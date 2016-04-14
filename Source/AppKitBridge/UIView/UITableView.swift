//
//  UITableView.swift
//  Pods
//
//  Created by Ian McDowell on 4/13/16.
//
//

import AppKit

public enum UITableViewStyle {
    case Plain, Grouped
}

public protocol UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    func tableView(tableView: UITableView, numberOFRowsInSection section: Int) -> Int
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
}

// NOTE: This class is slightly different than others, since a NSTableView is not a subclass of NSScrollView.
// Here the 'view' variable is of type NSScrollView, and we create our own NSTableView.
public class BridgedUITableView<T: NSTableView>: BridgedUIScrollView<NSScrollView> {
    
    private var tableView: T = T()
    
    public var dataSource: UITableViewDataSource?
    
    public init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame)
    
    }
    
    public func reloadData() {
        
    }
}

public class BridgedUITableViewCell<T: NSTableRowView>: BridgedUIView<NSView> {
    
    internal init() {
        super.init(frame: CGRectZero)
    }
    
    public var identifier: String? {
        set {
            self.bridgedView.identifier = newValue
        }
        get {
            return self.bridgedView.identifier
        }
    }
    
    public var contentView: UIView {
        get {
            return self
        }
    }
    
    public func layout() {
        self.bridgedView.layout()
    }
}