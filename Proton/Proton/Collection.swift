//
//  Collection.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/29/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

class Collection: View<UICollectionView> {

    private var dataSource = CollectionDataSource()
    
    init(cells: [CollectionCell.Type]) {
        super.init()
        
        self.dataSource.cells = cells
        self.view.dataSource = self.dataSource
        
        for cell in cells {
            self.view.registerClass(cell.self, forCellWithReuseIdentifier: NSStringFromClass(cell.self))
        }
    }
    
    convenience init(data: [AnyObject]..., cells: [CollectionCell.Type]) {
        self.init(cells: cells)
        
        dataSource.sections = data
    }
    
    convenience init(sections: [[AnyObject]],  cells: [CollectionCell.Type]) {
        self.init(cells: cells)
        
        dataSource.sections = sections
    }
    
}



class CollectionCell: UICollectionViewCell {
    
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

class CollectionCellTitleSubtitle: CollectionCell {
    
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


@objc private class CollectionDataSource: NSObject, UICollectionViewDataSource {
    
    var sections = [[AnyObject]]()
    var cells = [CollectionCell.Type]()
    
    
    @objc func numberOfSectionsInCollectionView(CollectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    @objc func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    @objc func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let model = sections[indexPath.section][indexPath.row]
        let type = getTypeOfModel(model)
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(NSStringFromClass(type), forIndexPath: indexPath) as! CollectionCell
        
        cell.layoutIfNeeded()
        
        cell.configure(model)
        
        return cell
    }
    
    private func getTypeOfModel(model: AnyObject) -> CollectionCell.Type {
        for cell in cells {
            if cell.displays(model) {
                return cell
            }
        }
        fatalError("No cell type provided to the Collection is able to display model of type: \(model.self). Make sure you are implementing the 'displays(model) -> Bool' method of your CollectionCell")
    }
}