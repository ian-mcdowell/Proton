//
//  Layout.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/30/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

protocol Layout {
    var views: [ProtonView] {get set}
}

extension Layout {
    
    
    func addXYConstraintsToView(view: ProtonView, superview: UIView) {
        guard let v = view as? AbsoluteLayoutView else {
            fatalError("View was unable to be layed out absolutely.")
        }
        
        let uiView = view.getView()
        
        uiView.translatesAutoresizingMaskIntoConstraints = false
        
        // NOTE: Either centering or a Percent/Absolute value is required for both X and Y axis.
        //       Percent constraints are done via multiplier on the superview's opposite constraint.
        //       Absolute constraints are via a constant on the superview's corresponding constraint.
        
        // Center X or do left/right alignment
        if v.position.cX {
            NSLayoutConstraint(item: uiView, attribute: .CenterX, relatedBy: .Equal, toItem: superview, attribute: .CenterX, multiplier: 1, constant: 0).active = true
        } else {
            switch v.position.type {
            case .Percent:
                if let left = v.position.left {
                    NSLayoutConstraint(item: uiView, attribute: .Left, relatedBy: .Equal, toItem: superview, attribute: .Right, multiplier: left, constant: 0).active = true
                }
                if let right = v.position.right {
                    NSLayoutConstraint(item: uiView, attribute: .Right, relatedBy: .Equal, toItem: superview, attribute: .Right, multiplier: 1 - right, constant: 0).active = true
                }
                break
            case .Absolute:
                if let left = v.position.left {
                    NSLayoutConstraint(item: uiView, attribute: .Left, relatedBy: .Equal, toItem: superview, attribute: .Left, multiplier: 1, constant: left).active = true
                }
                if let right = v.position.right {
                    NSLayoutConstraint(item: uiView, attribute: .Right, relatedBy: .Equal, toItem: superview, attribute: .Right, multiplier: 1, constant: -right).active = true
                }
                break
            case .None:
                fatalError("View in an absolute layout did not have an X position. This is required.")
            }
        }
        
        // Center Y or do top/bottom alignment
        if v.position.cY {
            NSLayoutConstraint(item: uiView, attribute: .CenterY, relatedBy: .Equal, toItem: superview, attribute: .CenterY, multiplier: 1, constant: 0).active = true
        } else {
            switch v.position.type {
            case .Percent:
                if let top = v.position.top {
                    NSLayoutConstraint(item: uiView, attribute: .Top, relatedBy: .Equal, toItem: superview, attribute: .Bottom, multiplier: top, constant: 0).active = true
                }
                if let bottom = v.position.bottom {
                    NSLayoutConstraint(item: uiView, attribute: .Bottom, relatedBy: .Equal, toItem: superview, attribute: .Bottom, multiplier: 1 - bottom, constant: 0).active = true
                }
                break
            case .Absolute:
                if let top = v.position.top {
                    NSLayoutConstraint(item: uiView, attribute: .Top, relatedBy: .Equal, toItem: superview, attribute: .Top, multiplier: 1, constant: top).active = true
                }
                if let bottom = v.position.bottom {
                    NSLayoutConstraint(item: uiView, attribute: .Bottom, relatedBy: .Equal, toItem: superview, attribute: .Bottom, multiplier: 1, constant: -bottom).active = true
                }
                break
            case .None:
                fatalError("View in an absolute layout did not have a Y position. This is required.")
            }
        }
    }

    

    func addSizeConstraintsToView(view: ProtonView, superview: UIView) {
        let uiView = view.getView()
        guard let v = view as? AbsoluteLayoutView else {
            fatalError("Unable to set width and height of view.")
        }
        
        uiView.translatesAutoresizingMaskIntoConstraints = false
        
        // width / height constraints (not required)
        switch v.size.type {
        case .Percent:
            if let width = v.size.width {
                NSLayoutConstraint(item: uiView, attribute: .Width, relatedBy: .Equal, toItem: superview, attribute: .Width, multiplier: width, constant: 0).active = true
            }
            if let height = v.size.height {
                NSLayoutConstraint(item: uiView, attribute: .Height, relatedBy: .Equal, toItem: superview, attribute: .Height, multiplier: height, constant: 0).active = true
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