//
//  Table.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

/// Wrapper for `UITableView`, which handles all dataSource and delegate methods for you.
class Table: View<UITableView> {
    
    private var tableManager = TableManager()
    
    init(cells: [TableCell.Type]) {
        super.init()
        
        self.tableManager.cells = cells
        self.view.dataSource = self.tableManager
        self.view.delegate = self.tableManager
        
        for cell in cells {
            self.view.registerClass(cell.self, forCellReuseIdentifier: NSStringFromClass(cell.self))
        }
    }
    
    convenience init(data: [AnyObject]..., cells: [TableCell.Type]) {
        self.init(cells: cells)
        
        tableManager.sections = data
    }
    
    convenience init(sections: [[AnyObject]], cells: [TableCell.Type]) {
        self.init(cells: cells)
        
        tableManager.sections = sections
    }


}


/// Base class for all UITableViewCells used within Proton.
/// This allows awesome syntax and never having to use a `UITableViewDataSource`.
class TableCell: UITableViewCell {
    
    /// The result of calling `layout` is stored here.
    internal var lastLayout: ViewHolder?
    
    /// Tells the Table if this particular type of TableCell should display for the given model.
    /// Careful. Only one model should only be allowed to display one type of TableCell. An error
    /// will occur if you return true from this method multiple times per model.
    class func displays(model: AnyObject) -> Bool {
        fatalError("You must override the `displays` method of \(self.self)");
    }
    
    /// Configures the cell to display the given model. This is similar to the `cellForRowAtIndexPath`
    /// method of the `UITableView`.
    func configure(model: AnyObject) { }
    
    /// Called when the cell is tapped. Override this to define behavior.
    func tapped(model: AnyObject) { }
    
    /// Deselects the cell.
    func deselect() {
        self.setSelected(false, animated: true)
    }
    
    /// Selects the cell.
    func select() {
        self.setSelected(true, animated: true)
    }
    
    /// Returns the layout of the cell. Override this to
    func layout() -> ViewHolder {
        return View()
    }
    
    /// Calls the layout function if needed, to put everything in motion. The layout will only
    /// be performed once.
    internal override func layoutIfNeeded() {
        super.layoutIfNeeded()
        if self.lastLayout == nil {
            self.lastLayout = self.layout()
            let view = self.lastLayout!.getView()
            self.contentView.addSubview(view)
            view.constrainToEdgesOfSuperview()
        }
    }
}


/// Pre-defined layout of TableCell, with a title and subtitle
class TableCellTitleSubtitle: TableCell {
    
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    
    override func layout() -> ViewHolder {
        return Stack([
            Label().assign(&titleLabel).construct{ view in
                view.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
            },
            Label().assign(&subtitleLabel).construct{ view in
                view.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
            }
        ])
    }
    
}


@objc private class TableManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var sections = [[AnyObject]]()
    var cells = [TableCell.Type]()
    
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let model = sections[indexPath.section][indexPath.row]
        let type = getTypeOfModel(model)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(type), forIndexPath: indexPath) as! TableCell

        cell.layoutIfNeeded()
        
        cell.configure(model)
        
        return cell
    }
    
    
    @objc func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! TableCell
        cell.tapped(sections[indexPath.section][indexPath.row])
    }
    
    private func getTypeOfModel(model: AnyObject) -> TableCell.Type {
        for cell in cells {
            if cell.displays(model) {
                return cell
            }
        }
        fatalError("No cell type provided to the Table is able to display model of type: \(model.self). Make sure you are implementing the 'displays(model) -> Bool' method of your TableCell")
    }
}