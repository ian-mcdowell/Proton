//
//  AbsoluteLayout.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 4/4/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

/// Wrapper for `UIView`. Absolutely positions subviews. (x, y, width, height)
public class AbsoluteLayout: View<UIView>, Layout {

    var views: [ProtonView]
    
    public init(_ views: [ProtonView]) {
        self.views = views
        
        super.init()
        
        for view in views {
            let uiView = view.getView()
            self.view.addSubview(uiView)
            
            self.addXYConstraintsToView(view, superview: self.view)
            self.addSizeConstraintsToView(view, superview: self.view)
        }
    }
    
 }