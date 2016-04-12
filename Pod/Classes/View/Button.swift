//
//  Button.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/28/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

/// Wrapper for `UIButton`, which allows easy instantiation with text and image,
/// as well as an easy tap handler.
public class Button: View<UIButton> {

    public override init() {
        super.init()
    }
    
    public init(type type: UIButtonType) {
        super.init()
        view = UIButton(type: type)
    }
    
    public convenience init(text: String?, image: UIImage?) {
        self.init()
        view.setTitle(text, forState: .Normal)
        view.setImage(image, forState: .Normal)
        view.setTitleColor(UIColor.blackColor(), forState: .Normal)
    }
    
    public convenience init(_ text: String?) {
        self.init(text: text, image: nil)
    }
    
    public convenience init(_ image: UIImage?) {
        self.init(text: nil, image: image)
    }
    
    
    public override func onTap(fn: () -> Void) -> Self {
        self.clickHandler.action = fn
        self.view.addTarget(self.clickHandler, action: #selector(self.clickHandler.handleAction), forControlEvents: .TouchUpInside)
        
        return self
    }
    
}
