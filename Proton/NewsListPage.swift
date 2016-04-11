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
        return Table(data: items, cells: [NewsItemCell.self, NewsItemImageCell.self])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Proton"
        
        self.loadItems()
    }
    
    private func loadItems() {
        self.items.value = [
            NewsItem(title: "Test", description: "Test", image: nil),
            NewsItem(title: "Image Test", description: "Asdf", image: "Image"),
            NewsItem(title: "Test 2", description: "Test 2", image: nil)
        ]
        
        Dispatch.delay(2) { 
            self.items.value.append(NewsItem(title: "Test 3", description: "ASDF", image: nil))
        }
    }
}

class NewsItem {
    var title: String
    var description: String
    var image: String?
    
    init(title: String, description: String, image: String?) {
        self.title = title
        self.description = description
        self.image = image
    }
}

private class NewsItemImageCell: TableCell<NewsItem>, Navigatable {
    
    required init() { }
    
    override class func displays(model: NewsItem) -> Bool {
        return model.image != nil
    }
    
    override func configure(model: NewsItem) {
        
    }
}


private class NewsItemCell: TableCellTitleSubtitle<NewsItem>, Navigatable {
    
    required init() {}
    
    override class func displays(model: NewsItem) -> Bool  {
        return model.image == nil
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