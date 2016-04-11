//
//  AbsoluteLayout.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 4/4/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

/// Wrapper for `UIView`. Absolutely positions subviews. (x, y, width, height)
class AbsoluteLayout: View<UIView>, Layout {

    var views: [ProtonView]
    
    init(_ views: [ProtonView]) {
        self.views = views
        
        super.init()
        
        for view in views {
            guard let v = view as? AbsoluteLayoutView else {
                fatalError("View was unable to be layed out absolutely.")
            }
            
            let uiView = view.getView()
            self.view.addSubview(uiView)

            uiView.translatesAutoresizingMaskIntoConstraints = false
            
            // NOTE: Either centering or a Percent/Absolute value is required for both X and Y axis.
            //       Percent constraints are done via multiplier on the superview's opposite constraint.
            //       Absolute constraints are via a constant on the superview's corresponding constraint.
            
            // Center X or do left/right alignment
            if v.position.cX {
                NSLayoutConstraint(item: uiView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0).active = true
            } else {
                switch v.position.type {
                case .Percent:
                    if let left = v.position.left {
                        NSLayoutConstraint(item: uiView, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: left, constant: 0).active = true
                    }
                    if let right = v.position.right {
                        NSLayoutConstraint(item: uiView, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1 - right, constant: 0).active = true
                    }
                    break
                case .Absolute:
                    if let left = v.position.left {
                        NSLayoutConstraint(item: uiView, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1, constant: left).active = true
                    }
                    if let right = v.position.right {
                        NSLayoutConstraint(item: uiView, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1, constant: -right).active = true
                    }
                    break
                case .None:
                    fatalError("View in an absolute layout did not have an X position. This is required.")
                }
            }
            
            // Center Y or do top/bottom alignment
            if v.position.cY {
                NSLayoutConstraint(item: uiView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0).active = true
            } else {
                switch v.position.type {
                case .Percent:
                    if let top = v.position.top {
                        NSLayoutConstraint(item: uiView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: top, constant: 0).active = true
                    }
                    if let bottom = v.position.bottom {
                        NSLayoutConstraint(item: uiView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1 - bottom, constant: 0).active = true
                    }
                    break
                case .Absolute:
                    if let top = v.position.top {
                        NSLayoutConstraint(item: uiView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: top).active = true
                    }
                    if let bottom = v.position.bottom {
                        NSLayoutConstraint(item: uiView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: -bottom).active = true
                    }
                    break
                case .None:
                    fatalError("View in an absolute layout did not have a Y position. This is required.")
                }
            }

            
            // width / height constraints (not required)
            switch v.size.type {
            case .Percent:
                if let width = v.size.width {
                    NSLayoutConstraint(item: uiView, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: width, constant: 0).active = true
                }
                if let height = v.size.height {
                    NSLayoutConstraint(item: uiView, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: height, constant: 0).active = true
                }
                break
            case .Fixed:
                if let width = v.size.width {
                    NSLayoutConstraint(item: uiView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: width).active = true
                }
                if let height = v.size.height {
                    NSLayoutConstraint(item: uiView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: height).active = true
                }
                break
            case .None:
                break
            }
        }
    }
}