//
//  StackLayout.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/28/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

/// Wrapper for `UIStackView`. Allows either Vertical or Horizontal orientation of subviews.
public class StackLayout: View<UIStackView>, Layout {
    var views: [ProtonView]
    
    public init(_ views: [ProtonView], direction: UILayoutConstraintAxis = .Vertical, distribution: UIStackViewDistribution = .Fill) {
        self.views = views
        
        super.init()
        
        self.view = UIStackView(arrangedSubviews: self.uiViews())
        self.view.axis = direction
        self.view.distribution = distribution
        
        // add width and height constraints
        for view in self.views {
            self.addSizeConstraintsToView(view, superview: self.view)
        }
    }
    
    private func uiViews() -> [UIView] {
        return self.views.map({ (view) -> UIView in
            return view.getView()
        })
    }
}