//
//  Table.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

// Observable structure to house an array of data for use with a `Table`.
class TableData<V: AnyObject> {
    var value: [V] {
        didSet {
            table?.dataUpdated(value)
        }
    }
    
    internal var table: Table<V>?
    
    init() {
        value = [V]()
    }
    init(_ v: [V]) {
        value = v
    }
}

/// Wrapper for `UITableView`, which handles all dataSource and delegate methods for you.
class Table<V: AnyObject>: View<UITableView> {
    
    private var tableManager = TableManager<V>()
    
    init(cells: [AnyClass]) {
        super.init()
        
        self.tableManager.cells = cells
        self.view.dataSource = self.tableManager
        self.view.delegate = self.tableManager
        
        for cell in cells {
            self.view.registerClass(BaseTableCell.self, forCellReuseIdentifier: NSStringFromClass(cell.self))
        }
    }
    
    convenience init(data: TableData<V>, cells: [AnyClass]) {
        self.init(cells: cells)
        
        data.table = self
    }
    
    convenience init(data: [V]..., cells: [AnyClass]) {
        self.init(cells: cells)
        
        tableManager.sections = data
    }
    
    convenience init(sections: [[V]], cells: [AnyClass]) {
        self.init(cells: cells)
        
        tableManager.sections = sections
    }


    func bind(items: TableData<V>) -> Table {
        items.table = self
        
        return self
    }
    
    
    internal func dataUpdated(newValue: [V]) {
        if let sections = newValue as Any as? Array<Array<V>> {
            tableManager.sections = sections
        } else if let items = newValue as Any as? Array<V> {
            tableManager.sections = [items]
        }
        
        self.view.reloadData()
    }

}




private class TableManager<V: AnyObject>: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var sections = [[V]]()
    var cells = [AnyClass]()
    
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let model = sections[indexPath.section][indexPath.row]
        let type = getTypeOfModel(model)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(type), forIndexPath: indexPath) as! BaseTableCell
        cell.tableCell = type.init()
        
        cell.layoutIfNeeded()
        
        cell.tableCell?.configureObjC(model)
        
        return cell
    }
    
    
    @objc func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! BaseTableCell
        cell.tableCell?.tappedObjC(sections[indexPath.section][indexPath.row])
    }
    
    private func getTypeOfModel(model: V) -> TableCell<V>.Type {
        var foundCount = 0
        var type: TableCell<V>.Type? = nil
        for cell in cells {
            if let thisType = cell as? TableCell<V>.Type {
                if thisType.displays(model) {
                    foundCount = foundCount + 1
                    type = thisType
                }
            }
        }
        if foundCount == 0 {
            fatalError("No cell type provided to the Table is able to display model of type: \(model.self). Make sure you are implementing the 'displays(model) -> Bool' method of your TableCell")
        } else if foundCount > 1 {
            fatalError("Multiple cell types provided to the Table are able to display model of type: \(model.self). Make sure you are returning true only once per model from the 'displays(model) -> Bool' method of your TableCell")
        }
        return type!
    }
}