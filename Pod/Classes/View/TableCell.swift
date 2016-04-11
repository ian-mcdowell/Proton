//
//  TableCell.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 4/9/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

internal class BaseTableCell: UITableViewCell {
    
    var tableCell: TableCellObjC? {
        willSet {
            tableCell?.currentCell = nil
            
            self.lastLayout?.getView().removeFromSuperview()
            self.lastLayout = nil
        }
        didSet {
            tableCell?.currentCell = self
            
            self.lastLayout = self.tableCell?.layout()
            let view = self.lastLayout!.getView()
            self.contentView.addSubview(view)
            view.constrainToEdgesOfSuperview()
        }
    }
    
    /// The result of calling `layout` is stored here.
    var lastLayout: ProtonView?
    
}

internal protocol TableCellObjC {
    func layout() -> ProtonView
    func configureObjC(model: AnyObject)
    func tappedObjC(model: AnyObject)
    var currentCell: BaseTableCell? {get set}
}

/// Base class for all UITableViewCells used within Proton.
/// This allows awesome syntax and never having to use a `UITableViewDataSource`.
public class TableCell<V: AnyObject>: ProtonView, TableCellObjC {
    
    required public init() {}
    
    var currentCell: BaseTableCell?
    
    /// Tells the Table if this particular type of TableCell should display for the given model.
    /// Careful. Only one model should only be allowed to display one type of TableCell. An error
    /// will occur if you return true from this method multiple times per model.
    public class func displays(model: V) -> Bool {
        return true
    }
    
    /// Configures the cell to display the given model. This is similar to the `cellForRowAtIndexPath`
    /// method of the `UITableView`.
    public func configure(model: V) { }
    
    /// Called when the cell is tapped. Override this to define behavior.
    public func tapped(model: V) { }
    
    /// Deselects the cell.
    public func deselect() {
        self.currentCell?.setSelected(false, animated: true)
    }
    
    /// Selects the cell.
    public func select() {
        self.currentCell?.setSelected(true, animated: true)
    }
    
    /// Returns the layout of the cell. Override this to
    public func layout() -> ProtonView {
        return View()
    }
    
    
    // MARK: ObjC bridge functions
    func configureObjC(model: AnyObject) {
        self.configure(model as! V)
    }
    func tappedObjC(model: AnyObject) {
        self.tapped(model as! V)
    }
    
    
    // MARK: ProtonView
    public func getView() -> UIView {
        return self.currentCell!
    }
}


/// Pre-defined layout of TableCell, with a title and subtitle
public class TableCellTitleSubtitle<V: AnyObject>: TableCell<V> {
    
    required public init() {}
    
    public var titleLabel: UILabel!
    public var subtitleLabel: UILabel!
    
    override public func layout() -> ProtonView {
        return StackLayout([
            Label().assign(&titleLabel).construct{ view in
                view.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
            },
            Label().assign(&subtitleLabel).construct{ view in
                view.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
            }
        ])
    }
    
}
