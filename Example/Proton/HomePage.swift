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
//        ListItem(title: "ActivityIndicator", subtitle: "ActivityIndicatorPage", page: ActivityIndicatorPage.self),
//        ListItem(title: "Alert", subtitle: "AlertPage", page: AlertPage.self),
//        ListItem(title: "Button", subtitle: "ButtonPage", page: ButtonPage.self),
        //ListItem(title: "DatePicker", subtitle: "DatePickerPage", page: DatePickerPage.self),
//        ListItem(title: "ImageView", subtitle: "ImageViewPage", page: ImageViewPage.self),
        ListItem(title: "WebView", subtitle: "WebViewPage", page: WebViewPage.self)
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
    var subtitle: String
    var page: Page.Type
}

private class ListItemCell: TableCellTitleSubtitle<ListItem>, Navigatable {
    
    required init() {}
    
    override func configure(model: ListItem) {
        self.titleLabel.text = model.title
        self.subtitleLabel.text = model.subtitle
    }
    
    override func tapped(model: ListItem) {
        self.deselect()
        self.push(model.page.init())
    }
}