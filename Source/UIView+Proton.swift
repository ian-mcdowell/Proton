//
//  UIView+Proton.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/29/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

// External extensions. For use everywhere.
#if os(iOS)
public extension UIView {
    
    // makes the current view anchored to all edges of the superview, filling all space.
    func constrainToEdgesOfSuperview() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraintEqualToAnchor(self.superview!.leadingAnchor).active = true
        self.trailingAnchor.constraintEqualToAnchor(self.superview!.trailingAnchor).active = true
        self.topAnchor.constraintEqualToAnchor(self.superview!.topAnchor).active = true
        self.bottomAnchor.constraintEqualToAnchor(self.superview!.bottomAnchor).active = true
    }
}
#endif

// internal extensions for use within Proton.

#if os(iOS)
internal extension UIView {
    
    // retrieves the UIViewController that controls the view. This is done by looping up the UIResponder chain.
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.nextResponder()
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
#endif