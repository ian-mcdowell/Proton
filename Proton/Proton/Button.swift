//
//  Button.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/28/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

class Button: View<UIButton> {

    override init() {
        super.init()
    }
    
    convenience init(text: String?, image: UIImage?) {
        self.init()
        view.setTitle(text, forState: .Normal)
        view.setImage(image, forState: .Normal)
        view.setTitleColor(UIColor.blackColor(), forState: .Normal)
    }
    
    convenience init(_ text: String) {
        self.init(text: text, image: nil)
    }
    
    convenience init(_ image: UIImage) {
        self.init(text: nil, image: image)
    }
    
    
    override func tapped(fn: () -> Void) -> Button {
        self.clickHandler.tapAction = fn
        self.view.addTarget(self.clickHandler, action: #selector(self.clickHandler.handleTap), forControlEvents: .TouchUpInside)
        
        return self
    }
    
}
