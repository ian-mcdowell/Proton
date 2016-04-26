//
//  ButtonPage.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 4/12/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Proton

class ButtonPage: Page, Alertable {
    
    private var items = SectionedTableData<ButtonType>()
    
    override func layout() -> ProtonView {
        return Table(data: items, cells: [SystemTextButtonCell.self, ContactAddButtonCell.self, DetailDisclosureButtonCell.self, ImageButtonCell.self, AttributedTextButtonCell.self], style: .Grouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Buttons"
        
        self.items.value = [
            TableSection(title: "System (Text)", [
                .SystemText
            ]),
            TableSection(title: "System (Contact Add)", [
                .ContactAdd
            ]),
            TableSection(title: "System (Detail Disclosure)", [
                .DetailDisclosure
            ]),
            TableSection(title: "Image", [
                .Image
            ]),
            TableSection(title: "Attributed Text", [
                .AttributedText
            ])
        ]
    }
    
}

private enum ButtonType {
    case SystemText, ContactAdd, DetailDisclosure, Image, AttributedText
}


private class SystemTextButtonCell: TableCell<ButtonType> {
    
    required init() {}
    
    override class func displays(model: ButtonType) -> Bool {
        return model == .SystemText
    }
    
    override func layout() -> ProtonView {
        return AbsoluteLayout([
            Button(type: .System).construct { view in
                view.setTitle("Button", forState: .Normal)
            }.positionCenter()
        ])
    }
}

private class ContactAddButtonCell: TableCell<ButtonType> {
    
    required init() {}
    
    override class func displays(model: ButtonType) -> Bool {
        return model == .ContactAdd
    }
    
    override func layout() -> ProtonView {
        return AbsoluteLayout([
            Button(type: .ContactAdd).positionCenter()
        ])
    }
}

private class DetailDisclosureButtonCell: TableCell<ButtonType> {
    
    required init() {}
    
    override class func displays(model: ButtonType) -> Bool {
        return model == .DetailDisclosure
    }
    
    override func layout() -> ProtonView {
        return AbsoluteLayout([
            Button(type: .DetailDisclosure).positionCenter()
        ])
    }
}

private class ImageButtonCell: TableCell<ButtonType> {
    
    required init() {}
    
    override class func displays(model: ButtonType) -> Bool {
        return model == .Image
    }
    
    override func layout() -> ProtonView {
        return AbsoluteLayout([
            //Button(image: UIImage(named: "x_icon")).positionCenter()
        ])
    }
}

private class AttributedTextButtonCell: TableCell<ButtonType> {
    
    required init() {}
    
    override class func displays(model: ButtonType) -> Bool {
        return model == .AttributedText
    }
    
    override func layout() -> ProtonView {
        return AbsoluteLayout([
            Button().construct { view in
                let str = NSAttributedString(string: "Button", attributes: [NSStrikethroughStyleAttributeName: NSNumber(integer: NSUnderlineStyle.StyleSingle.rawValue)])
                
                // TODO:
//                view.setAttributedTitle(str, forState: .Normal)
            }.positionCenter()
        ])
    }
}