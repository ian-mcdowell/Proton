//
//  Table.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

// Observable structure to house an array of data for use with a `Table`.
public class TableData<T: Any> {
    public var value: [T] {
        didSet {
            table?.dataUpdated(value)
        }
    }
    
    internal var table: Table<T>? {
        didSet {
            table?.dataUpdated(value)
        }
    }
    
    public init() {
        value = [T]()
    }
    public init(_ v: [T]) {
        value = v
    }
}

public struct TableSection<T: Any> {
    public var title: String? = nil
    public var items = [T]()
    
    public init(_ items: [T] = [T](), title: String? = nil) {
        self.title = title
        self.items = items
    }
}

// Observable structure to house an array of arrays of data for use with a sectioned `Table`.
public class SectionedTableData<T: Any> {
    public var value: [TableSection<T>] {
        didSet {
            table?.dataUpdated(value)
        }
    }
    
    internal var table: Table<T>? {
        didSet {
            table?.dataUpdated(value)
        }
    }
    
    public init() {
        value = [TableSection<T>]()
    }
    public init(_ v: [TableSection<T>]) {
        value = v
    }
}

/// Wrapper for `UITableView`, which handles all dataSource and delegate methods for you.
public class Table<V: Any>: View<UITableView> {
    
    private var tableManager = GenericTableManager<V>()
    
    
    public init(cells: [AnyClass], style: UITableViewStyle = .Plain) {
        super.init(view: UITableView(frame: CGRectZero, style: style))
        
        self.tableManager.cells = cells
        self.view.dataSource = self.tableManager
        self.view.delegate = self.tableManager
        
        for cell in cells {
            self.view.registerClass(BaseTableCell.self, forCellReuseIdentifier: NSStringFromClass(cell.self))
        }

    }
    
    public convenience init(data: TableData<V>, cells: [AnyClass], style: UITableViewStyle = .Plain) {
        self.init(cells: cells, style: style)
        
        data.table = self
    }
    
    public convenience init(data: SectionedTableData<V>, cells: [AnyClass], style: UITableViewStyle = .Plain) {
        self.init(cells: cells, style: style)
        
        data.table = self
    }
    
    public convenience init(data: [V], cells: [AnyClass], style: UITableViewStyle = .Plain) {
        self.init(cells: cells, style: style)
        
        tableManager.sections = [TableSection(data)]
    }
    
    public convenience init(sections: [TableSection<V>], cells: [AnyClass], style: UITableViewStyle = .Plain) {
        self.init(cells: cells, style: style)
        
        tableManager.sections = sections
    }


    public func bind(items: TableData<V>) -> Self {
        items.table = self
        
        return self
    }
    
    
    internal func dataUpdated(newValue: [V]) {
        tableManager.sections = [TableSection(newValue)]
        
        self.view.reloadData()
    }
    
    internal func dataUpdated(newValue: [TableSection<V>]) {
        tableManager.sections = newValue
        
        self.view.reloadData()
    }

}


class TableManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        fatalError()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
}

private class GenericTableManager<V: Any>: TableManager {
    
    var sections = [TableSection<V>]()
    var cells = [AnyClass]()
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let model = sections[indexPath.section].items[indexPath.row]
        let type = getTypeOfModel(model, cells)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(type), forIndexPath: indexPath) as! BaseTableCell

        cell.tableCell = type.init()

        cell.layoutIfNeeded()

        cell.tableCell?.configureObjC(model)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! BaseTableCell
        cell.tableCell?.tappedObjC(sections[indexPath.section].items[indexPath.row])
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
}

private func getTypeOfModel<V: Any>(model: V, _ cells: [AnyClass]) -> TableCell<V>.Type {
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