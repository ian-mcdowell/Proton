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

    
    public init(text: String? = nil, image: UIImage? = nil, type: UIButtonType = .Custom) {
        super.init()
        
        #if os(iOS)
            view = UIButton(type: type)
            view.setTitleColor(UIColor.blackColor(), forState: .Normal)
        #elseif os(OSX)
            view.setButtonType(.MomentaryLightButton)

        #endif
        
        view.setTitle(text, forState: .Normal)
        view.setImage(image, forState: .Normal)

    }

    
    #if os(iOS)
    public override func onTap(fn: () -> Void) -> Self {
        self.clickHandler.action = fn
        self.view.addTarget(self.clickHandler, action: #selector(self.clickHandler.handleAction), forControlEvents: .TouchUpInside)
        
        return self
    }
    #endif
    
}
