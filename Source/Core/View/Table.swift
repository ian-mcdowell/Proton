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
    
    private var tableManager = TableManager<V>()
    
    #if os(OSX)
    private var scrollView: NSScrollView!
    #endif
    
    public init(cells: [AnyClass], style: UITableViewStyle = .Plain) {
        super.init(view: UITableView(frame: CGRectZero, style: style))
        
        self.tableManager.cells = cells
        #if os(iOS)
            self.view.dataSource = self.tableManager
            self.view.delegate = self.tableManager
        
            for cell in cells {
                self.view.registerClass(BaseTableCell.self, forCellReuseIdentifier: NSStringFromClass(cell.self))
            }
        #elseif os(OSX)
       
//            self.scrollView = NSScrollView(frame: NSMakeRect(0, 0, 0, 0))
//            self.scrollView.documentView = self.view
//
//            self.view.addTableColumn(NSTableColumn(identifier: "main"))
//            self.view.headerView = nil
//
//            
//            
//            self.view.setDataSource(self.tableManager)
//            self.view.setDelegate(self.tableManager)
//            
//            for cell in cells {
//                self.view.makeViewWithIdentifier(NSStringFromClass(cell.self), owner: self.tableManager)
//            }
        #endif
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
    
    
    #if os(OSX)
    // On OS X, table views need to be wrapped in scrollviews to be able to scroll :(
    public override func getView() -> UIView {
        return self.scrollView
    }
    #endif

}



#if os(iOS)
private class TableManager<V: Any>: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var sections = [TableSection<V>]()
    var cells = [AnyClass]()
    
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let model = sections[indexPath.section].items[indexPath.row]
        let type = getTypeOfModel(model, cells)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(type), forIndexPath: indexPath) as! BaseTableCell
        cell.tableCell = type.init()
        
        cell.layoutIfNeeded()
        
        cell.tableCell?.configureObjC(model)
        
        return cell
    }
    
    
    @objc func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! BaseTableCell
        cell.tableCell?.tappedObjC(sections[indexPath.section].items[indexPath.row])
    }
    
    @objc func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    

}
    
#elseif os(OSX)
    
private class TableManager<V: Any>: NSObject, NSTableViewDataSource, NSTableViewDelegate {
    var sections = [TableSection<V>]()
    var cells = [AnyClass]()
    
    @objc func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return totalRows()
    }
    
    @objc func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let model = getItemAtTotalRow(row)!
        let type = getTypeOfModel(model, cells)
        let identifier = NSStringFromClass(type)
        
        var cell = tableView.makeViewWithIdentifier(identifier, owner: self) as? BaseTableCell
        
        if cell == nil {
            cell = BaseTableCell(frame: NSMakeRect(0, 0, 0, 0))
            cell?.identifier = identifier
        }
        
        cell?.tableCell = type.init()
        
        cell?.tableCell?.configureObjC(model)
        
        cell?.layout()
        
        return cell
    }
    
    @objc func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 44
    }
    
    @objc func selectionShouldChangeInTableView(tableView: NSTableView) -> Bool {
        let row = tableView.selectedRow
        
        if row != -1 {
            let cell = tableView.viewAtColumn(0, row: row, makeIfNecessary: false) as? BaseTableCell
            cell?.tableCell?.tappedObjC(getItemAtTotalRow(row)!)
        }
        
        return true
    }
    

    
    private func totalRows() -> Int {
        var total = 0
        for section in sections {
            total += section.items.count
        }
        return total
    }
    
    private func getItemAtTotalRow(requestedRow: Int) -> V? {
        var index = 0
        for section in sections {
            for row in section.items {
                if index == requestedRow {
                    return row
                }
                index += 1
            }
        }
        return nil
    }
}
#endif

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