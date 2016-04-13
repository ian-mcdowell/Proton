//
//  Button.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/28/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

/// Wrapper for `UIButton`, which allows easy instantiation with text and image,
/// as well as an easy tap handler.
public class Button: View<UIButton> {

    public override init() {
        super.init()
    }
    
    public init(type: UIButtonType) {
        super.init()
        #if os(iOS)
        view = UIButton(type: type)
        #elseif os(OSX)
        view.setButtonType(type)
        #endif
    }
    
    public convenience init(text: String?, image: UIImage?) {
        self.init()
        #if os(iOS)
        view.setTitle(text, forState: .Normal)
        view.setImage(image, forState: .Normal)
        view.setTitleColor(UIColor.blackColor(), forState: .Normal)
        #elseif os(OSX)
        view.title = text ?? ""
        view.image = image
        #endif
    }
    
    public convenience init(_ text: String?) {
        self.init(text: text, image: nil)
    }
    
    public convenience init(_ image: UIImage?) {
        self.init(text: nil, image: image)
    }
    
    #if os(iOS)
    public override func onTap(fn: () -> Void) -> Self {
        self.clickHandler.action = fn
        self.view.addTarget(self.clickHandler, action: #selector(self.clickHandler.handleAction), forControlEvents: .TouchUpInside)
        
        return self
    }
    #endif
    
}
