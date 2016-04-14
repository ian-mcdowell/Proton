//
//  StackLayout.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/28/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

/// Wrapper for `UIStackView`. Allows either Vertical or Horizontal orientation of subviews.
public class StackLayout: View<UIView>, Layout {
    var views: [ProtonView]
    
    private var stackView: UIStackView!
    
    #if os(iOS)
    public init(_ views: [ProtonView], direction: UILayoutConstraintAxis = .Vertical, distribution: UIStackViewDistribution = .Fill) {
        self.views = views
        
        super.init()
        
        stackView = UIStackView(arrangedSubviews: self.uiViews())
        stackView.axis = direction
        stackView.distribution = distribution
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.view.addSubview(stackView)
        stackView.constrainToEdgesOfSuperview()
        
        // add width and height constraints
        for view in self.views {
            self.addSizeConstraintsToView(view, superview: self.view)
        }
    }
    #elseif os(OSX)
    public init(_ views: [ProtonView]) {
        self.views = views
        
        super.init()
        
//        stackView = UIStackView(views: self.uiViews())
//        stackView.orientation = .Vertical
//        stackView.distribution = .GravityAreas
//        stackView.alignment = .Left
//        
//        self.view.backgroundColor = UIColor.whiteColor()
//        
//        self.view.addSubview(stackView)
//        stackView.constrainToEdgesOfSuperview()
//        
//        // add width and height constraints
//        for view in self.views {
//            self.addSizeConstraintsToView(view, superview: self.view)
//        }
    }
    #endif
    
    private func uiViews() -> [UIView] {
        return self.views.map({ (view) -> UIView in
            return view.getView()
        })
    }
}