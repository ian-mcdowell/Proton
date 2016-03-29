//
//  SecondPage.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/28/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

class SecondPage: Page {

    override func layout() -> ViewHolder {
        return Table(data: [
            DataModel(title: "Test", description: "Test"),
            DataModel(title: "Test 2", description: "Test 2")
        ], cells: [DataModelCell.self])
    }
    
}



class DataModel {
    var title: String
    var description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}



class DataModelCell: TableCellTitleSubtitle, Navigatable {
    
    override class func displays(model: AnyObject) -> Bool  {
        return true
    }
    
    override func configure(model: AnyObject) {
        let m = model as! DataModel
        self.titleLabel.text = m.title
        self.subtitleLabel.text = m.description
    }
    
    override func tapped(model: AnyObject) {
        self.deselect()
        self.push(RootPage())
    }
}