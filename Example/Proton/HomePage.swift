//
//  HomePage.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import Proton

class HomePage: Page, Navigatable {
    
    private var items = TableData<ListItem>([
        ListItem(title: "WebView", page: WebViewPage.self),
        ListItem(title: "Alert", page: AlertPage.self)
    ])

    override func layout() -> ProtonView {
        return Table(data: items, cells: [ListItemCell.self])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Proton"
    }
}

private struct ListItem {
    var title: String
    var page: Page.Type
}

private class ListItemCell: TableCellTitleSubtitle<ListItem>, Navigatable {
    
    required init() {}
    
    override func configure(model: ListItem) {
        self.titleLabel.text = model.title
//        self.subtitleLabel.text = 
    }
    
    override func tapped(model: ListItem) {
        self.deselect()
        self.push(model.page.init())
    }
}