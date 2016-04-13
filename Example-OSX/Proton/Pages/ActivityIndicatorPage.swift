//
//  ActivityIndicatorPage.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/28/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import Proton

class ActivityIndicatorPage: Page {

    private var items = SectionedTableData<IndicatorType>()
    
    override func layout() -> ProtonView {
        return Table(data: items, cells: [IndicatorTypeCell.self], style: .Grouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ActivityIndicator"        
        
        self.items.value = [
            TableSection(title: "Gray", [
                .Gray
            ]),
            TableSection(title: "Tinted", [
                .Tinted
            ])
        ]
    }
    
}

private enum IndicatorType {
    case Gray, Tinted
}

private class IndicatorTypeCell: TableCell<IndicatorType> {
    
    required init() {}
    
    private var indicator: UIActivityIndicatorView!
    
    override func layout() -> ProtonView {
        return AbsoluteLayout([
            ActivityIndicator().assign(&indicator).positionCenter()
        ])
    }
    
    override func configure(model: IndicatorType) {
        switch model {
        case .Gray:
            //self.indicator.color = UIColor.darkGrayColor()
            break
        case .Tinted:
            //self.indicator.color = UIColor.purpleColor()
            break
        }
        
    }
}