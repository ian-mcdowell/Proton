//
//  UITableView.swift
//  Pods
//
//  Created by Ian McDowell on 4/13/16.
//
//

import AppKit

public extension NSIndexPath {
    
    public var row: Int {
        get {
            return item
        }
    }
    
    public convenience init(forRow row: Int, inSection section: Int) {
        self.init(forItem: row, inSection: section)
    }
}

public enum UITableViewStyle {
    case Plain, Grouped
}

public protocol UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
}

public protocol UITableViewDelegate {
    
}

public class NSCustomTableView: NSTableView {
    
    internal var classForIdentifier = [String: UITableViewCell.Type]()
    public override func makeViewWithIdentifier(identifier: String, owner: AnyObject?) -> NSView? {
        if let cl = classForIdentifier[identifier] {
            return cl.init().bridgedView
        }
        return super.makeViewWithIdentifier(identifier, owner: owner)
    }
    
    public func registerClass(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        classForIdentifier[identifier] = cellClass as? UITableViewCell.Type
    }
}

// NOTE: This class is slightly different than others, since a NSTableView is not a subclass of NSScrollView.
// Here the 'view' variable is of type NSScrollView, and we create our own NSTableView.
public class BridgedUITableView<T: NSCustomTableView>: BridgedUIScrollView<NSScrollView> {
    
    private var tableView: T = T()
    private var tableManager = NSTableManager()
    

    // MARK: Init
    public init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame)
        
        self.style = style
        
        self.bridgedView.documentView = tableView
        
        // TODO: Remove constraints
        self.bridgedView.heightAnchor.constraintEqualToConstant(500).active = true
        self.bridgedView.widthAnchor.constraintEqualToConstant(400).active = true
        
        tableView.addTableColumn(NSTableColumn(identifier: "main"))
        tableView.headerView = nil
        
        
        tableManager.bridgedTableView = self as! UITableView
        
        tableView.setDelegate(tableManager)
        tableView.setDataSource(tableManager)
    }
    
    // MARK: Configuration
    
    public var style: UITableViewStyle!
    
    
    private var sectionRowCounts = [Int: Int?]()
    public func numberOfRowsInSection(_ section: Int) -> Int {
        if let val = sectionRowCounts[section], count = val {
            // we cached it and it wasnt nil
            return count
        } else if let count = self.dataSource?.tableView(self as! UITableView, numberOfRowsInSection: section) {
            sectionRowCounts[section] = count
            return count
        } else {
            // invalid section. Not sure what to do but return 0
            return 0
        }
    }
    
    private var sectionCount: Int? = nil
    public var numberOfSections: Int {
        get {
            if sectionCount == nil {
                sectionCount = self.dataSource?.numberOfSectionsInTableView(self as! UITableView)
            }
            return sectionCount!
        }
    }
    
    public var rowHeight: CGFloat {
        set {
            tableView.rowHeight = newValue
        }
        get {
            return tableView.rowHeight
        }
    }
    
    // TODO
//    var separatorStyle: UITableViewCellSeparatorStyle
//    var separatorColor: UIColor?
//    var separatorEffect: UIVisualEffect?
//    var backgroundView: UIView
//    var separatorInset: UIEdgeInsets
//    var cellLayoutMarginsFollowReadableWidth: Bool
    
    
    // MARK: Creating cells
    
    public func registerNib(_ nib: UINib?, forCellReuseIdentifier identifier: String) {
        self.tableView.registerNib(nib?.bridgedView, forIdentifier: identifier)
    }
    
    public func registerClass(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        self.tableView.registerClass(cellClass, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCellWithIdentifier(_ identifier: String, forIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = dequeueReusableCellWithIdentifier(identifier) {
            return cell
        }
        let view = tableView.rowViewAtRow(rowFromIndexPath(indexPath), makeIfNecessary: true)
        if let cl = self.tableView.classForIdentifier[identifier] as? UITableViewCell {
            return cl.dynamicType.init(existingValue: view)!
        }
        return UITableViewCell(existingValue: view)!
    }
    
    func dequeueReusableCellWithIdentifier(_ identifier: String) -> UITableViewCell? {
        let view = (self.tableView as! NSCustomTableView).makeViewWithIdentifier(identifier, owner: self.tableView)
        if let cl = self.tableView.classForIdentifier[identifier] {
            return (cl as! BaseTableCell.Type).init(existingValue: view as? NSTableRowView)!
        }
        return UITableViewCell(existingValue: view as? NSTableRowView)
    }
    
    
    // MARK: Header & Footer views
    
    
    
    // MARK: Cells and Sections
    
    func cellForRowAtIndexPath(_ indexPath: NSIndexPath) -> UITableViewCell? {
        return UITableViewCell(existingValue: tableView.rowViewAtRow(rowFromIndexPath(indexPath), makeIfNecessary: false))
    }
    
    
    public var dataSource: UITableViewDataSource? {
        set {
            self.clearData()
            tableManager.dataSource = newValue
        }
        get {
            return tableManager.dataSource
        }
    }
    public var delegate: UITableViewDelegate? {
        set {
            self.clearData()
            tableManager.delegate = newValue
        }
        get {
            return tableManager.delegate
        }
    }
    
    public func reloadData() {
        self.clearData()
        self.tableView.reloadData()
    }
    
    
    
    // Helpers
    
    private func clearData() {
        sectionRowCounts.removeAll(keepCapacity: false)
        sectionCount = nil
    }
    
    private func rowFromIndexPath(indexPath: NSIndexPath) -> Int {
        var total = 0
        for section in 0..<indexPath.section {
            for row in 0..<numberOfRowsInSection(section) {
                total++
            }
        }
        return total
    }
}


// Manages the NSTableViewDataSource and NSTableViewDelegate
private class NSTableManager: NSObject, NSTableViewDataSource, NSTableViewDelegate {
    
    var dataSource: UITableViewDataSource?
    var delegate: UITableViewDelegate?
    
    var bridgedTableView: UITableView!
    
    @objc func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        if let sections = dataSource?.numberOfSectionsInTableView(bridgedTableView) {
            var total = 0
            
            for section in 0..<sections {
                let rows = bridgedTableView.numberOfRowsInSection(section)
                
                total += rows
            }
            
            return total
        } else {
            return 0
        }
    }
    
    
    @objc func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let indexPath = self.getSectionedIndexPathFromRow(row) else {
            return nil
        }
        return dataSource?.tableView(bridgedTableView, cellForRowAtIndexPath: indexPath).bridgedView
    }
    
    @objc func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 44
    }
    
    @objc func selectionShouldChangeInTableView(tableView: NSTableView) -> Bool {
        let row = tableView.selectedRow
        
        if row != -1 {
            
        }
        
        return true
    }
    
    
    private func getSectionedIndexPathFromRow(requestedRow: Int) -> NSIndexPath? {
        let sections = self.dataSource!.numberOfSectionsInTableView(bridgedTableView)
        
        var index = 0
        for section in 0..<sections {
            for row in 0..<self.bridgedTableView.numberOfRowsInSection(section) {
                if index == requestedRow {
                    return NSIndexPath(forRow: row, inSection: section)
                }
                index += 1
            }
        }
        return nil
    }
}