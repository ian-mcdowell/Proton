//
//  Table.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

class Table: View<UITableView> {
    
    private var dataSource = TableDataSource()
    
    init(cells: [TableCell.Type]) {
        super.init()
        
        self.dataSource.cells = cells
        self.view.dataSource = self.dataSource
        
        for cell in cells {
            self.view.registerClass(cell.self, forCellReuseIdentifier: NSStringFromClass(cell.self))
        }
    }
    
    convenience init(data: [AnyObject]..., cells: [TableCell.Type]) {
        self.init(cells: cells)
        
        dataSource.sections = data
    }
    
    convenience init(sections: [[AnyObject]],  cells: [TableCell.Type]) {
        self.init(cells: cells)
        
        dataSource.sections = sections
    }


}


class TableCell: UITableViewCell {
    
    internal var lastLayout: ViewHolder?
    
    class func displays(model: AnyObject) -> Bool {
        return false
    }
    
    func configure(model: AnyObject) {
        
    }
    
    func layout() -> ViewHolder {
        return View()
    }
    
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


@objc private class TableDataSource: NSObject, UITableViewDataSource {
    
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
    
    private func getTypeOfModel(model: AnyObject) -> TableCell.Type {
        for cell in cells {
            if cell.displays(model) {
                return cell
            }
        }
        fatalError("No cell type provided to the Table is able to display model of type: \(model.self). Make sure you are implementing the 'displays(model) -> Bool' method of your TableCell")
    }
}