//
//  StackLayout.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/28/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

/// Wrapper for `UIStackView`. Allows either Vertical or Horizontal orientation of subviews.
class StackLayout: View<UIStackView>, Layout {
    var views: [ProtonView]
    
    init(_ views: [ProtonView], direction: UILayoutConstraintAxis = .Vertical) {
        self.views = views
        
        super.init()
        
        self.view = UIStackView(arrangedSubviews: self.uiViews())
        self.view.axis = direction
        self.view.distribution = .FillEqually
    }
    
    private func uiViews() -> [UIView] {
        return self.views.map({ (view) -> UIView in
            return view.getView()
        })
    }
}