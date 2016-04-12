//
//  AlertPage.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/28/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import Proton

class AlertPage: Page, Alertable {

    private var items = SectionedTableData<AlertItem>()
    
    override func layout() -> ProtonView {
        return Table(data: items, cells: [AlertItemCell.self], style: .Grouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Alert"
        
        self.items.value = [
            TableSection([
                AlertItem(title: "Simple", action: {
                    self.alert(
                        title: "A Short Title is Best",
                        message: "A message should be a short, complete sentence.",
                        actions: [UIAlertAction(title: "OK")]
                    )
                }),
                AlertItem(title: "Okay / Cancel", action: {
                    self.alert(
                        title: "A Short Title is Best",
                        message: "A message should be a short, complete sentence.",
                        actions: [
                            UIAlertAction(title: "Cancel", style: .Cancel),
                            UIAlertAction(title: "OK")
                        ]
                    )
                }),
                AlertItem(title: "Other", action: {
                    self.alert(
                        title: "A Short Title is Best",
                        message: "A message should be a short, complete sentence.",
                        actions: [
                            UIAlertAction(title: "Choice One"),
                            UIAlertAction(title: "Choice Two"),
                            UIAlertAction(title: "Cancel", style: .Cancel)
                        ]
                    )
                })
            ]),
            TableSection([
            ])
        ]
    }
    
}

private struct AlertItem {
    var title: String
    var action: () -> Void
}

private class AlertItemCell: TableCellTitle<AlertItem>, Navigatable {
    
    required init() {}
    
    override func configure(model: AlertItem) {
        self.titleLabel.text = model.title
    }
    
    override func tapped(model: AlertItem) {
        self.deselect()
        
        model.action()
    }
}