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
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
}

// NOTE: This class is slightly different than others, since a NSTableView is not a subclass of NSScrollView.
// Here the 'view' variable is of type NSScrollView, and we create our own NSTableView.
public class BridgedUITableView<T: NSTableView>: BridgedUIScrollView<NSScrollView> {
    
    private var tableView: T = T()
    
    public func reloadData() {
        
    }
}

public class UITableViewCell: NSTableRowView {
    
}