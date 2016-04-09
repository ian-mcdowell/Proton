//
//  NewsListPage.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//
import UIKit

class NewsListPage: Page, Navigatable {
    
    private var items = TableData<NewsItem>()

    override func layout() -> ProtonView {
        return Table(data: items, cells: [NewsItemCell.self])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Proton"
        
        self.loadItems()
    }
    
    private func loadItems() {
        self.items.value = [
            NewsItem(title: "Test", description: "Test"),
            NewsItem(title: "Test 2", description: "Test 2")
        ]
    }
}

class NewsItem {
    var title: String
    var description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}



private class NewsItemCell: TableCellTitleSubtitle<NewsItem>, Navigatable {
    
    required init() {}
    
    override class func displays(model: NewsItem) -> Bool  {
        return true
    }
    
    override func configure(model: NewsItem) {
        self.titleLabel.text = model.title
        self.subtitleLabel.text = model.description
    }
    
    override func tapped(model: NewsItem) {
        self.deselect()
        self.push(ThirdPage(text: model.title))
    }
}