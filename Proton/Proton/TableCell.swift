//
//  TableCell.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 4/9/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

internal class BaseTableCell: UITableViewCell {
    
    var tableCell: TableCellObjC!
    
    /// The result of calling `layout` is stored here.
    var lastLayout: ProtonView?
    
    /// Calls the layout function if needed, to put everything in motion. The layout will only
    /// be performed once.
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        if self.lastLayout == nil {
            self.lastLayout = self.tableCell.layout()
            let view = self.lastLayout!.getView()
            self.contentView.addSubview(view)
            view.constrainToEdgesOfSuperview()
        }
    }
}

internal protocol TableCellObjC {
    func layout() -> ProtonView
    func configureObjC(model: AnyObject)
    func tappedObjC(model: AnyObject)
}

/// Base class for all UITableViewCells used within Proton.
/// This allows awesome syntax and never having to use a `UITableViewDataSource`.
public class TableCell<V: AnyObject>: TableCellObjC {
    
    required public init() {}
    
    private var currentCell: BaseTableCell?
    
    /// Tells the Table if this particular type of TableCell should display for the given model.
    /// Careful. Only one model should only be allowed to display one type of TableCell. An error
    /// will occur if you return true from this method multiple times per model.
    class func displays(model: V) -> Bool {
        return true
    }
    
    /// Configures the cell to display the given model. This is similar to the `cellForRowAtIndexPath`
    /// method of the `UITableView`.
    func configure(model: V) { }
    
    /// Called when the cell is tapped. Override this to define behavior.
    func tapped(model: V) { }
    
    /// Deselects the cell.
    func deselect() {
        self.currentCell?.setSelected(false, animated: true)
    }
    
    /// Selects the cell.
    func select() {
        self.currentCell?.setSelected(true, animated: true)
    }
    
    /// Returns the layout of the cell. Override this to
    func layout() -> ProtonView {
        return View()
    }
    
    
    // MARK: ObjC bridge functions
    func configureObjC(model: AnyObject) {
        self.configure(model as! V)
    }
    func tappedObjC(model: AnyObject) {
        self.tapped(model as! V)
    }
}


/// Pre-defined layout of TableCell, with a title and subtitle
public class TableCellTitleSubtitle<V: AnyObject>: TableCell<V> {
    
    required public init() {}
    
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    
    override func layout() -> ProtonView {
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
