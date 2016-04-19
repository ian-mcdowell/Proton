//
//  UIView+Proton.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/29/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//




#if os(iOS)
    
    // External extensions. For use everywhere.
    public extension UIView {
        
        // makes the current view anchored to all edges of the superview, filling all space.
        func constrainToEdgesOfSuperview() {
            self.constrainToTopOfSuperview()
            self.constrainToBottomOfSuperview()
            self.constrainToSidesOfSuperview()
        }
        
        func constrainToSidesOfSuperview() {
            self.constrainToLeftOfSuperview()
            self.constrainToRightOfSuperview()
        }
        
        func constrainToBottomOfSuperview() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.bottomAnchor.constraintEqualToAnchor(self.superview!.bottomAnchor).active = true
        }
        
        func constrainToLeftOfSuperview() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.leadingAnchor.constraintEqualToAnchor(self.superview!.leadingAnchor).active = true
        }
        
        func constrainToRightOfSuperview() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.trailingAnchor.constraintEqualToAnchor(self.superview!.trailingAnchor).active = true
        }
        
        func constrainToTopOfSuperview() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.topAnchor.constraintEqualToAnchor(self.superview!.topAnchor).active = true
        }
    }
    
    // internal extensions for use within Proton.
    internal extension UIView {

        // retrieves the UIViewController that controls the view. This is done by looping up the UIResponder chain.
        var parentViewController: UIViewController? {
            var parentResponder: UIResponder? = self
            while parentResponder != nil {
                parentResponder = parentResponder?.nextResponder()
                if let viewController = parentResponder as? UIViewController {
                    return viewController
                }
            }
            return nil
        }
    }
#elseif os(OSX)
    // External extensions. For use everywhere.
    public extension BridgedUIView {
        
        // makes the current view anchored to all edges of the superview, filling all space.
        func constrainToEdgesOfSuperview() {
            self.constrainToTopOfSuperview()
            self.constrainToBottomOfSuperview()
            self.constrainToSidesOfSuperview()
        }
        
        func constrainToSidesOfSuperview() {
            self.constrainToLeftOfSuperview()
            self.constrainToRightOfSuperview()
        }
        
        func constrainToBottomOfSuperview() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.bottomAnchor.constraintEqualToAnchor(self.superview!.bottomAnchor).active = true
        }
        
        func constrainToLeftOfSuperview() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.leadingAnchor.constraintEqualToAnchor(self.superview!.leadingAnchor).active = true
        }
        
        func constrainToRightOfSuperview() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.trailingAnchor.constraintEqualToAnchor(self.superview!.trailingAnchor).active = true
        }
        
        func constrainToTopOfSuperview() {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.topAnchor.constraintEqualToAnchor(self.superview!.topAnchor).active = true
        }
    }
    
    // internal extensions for use within Proton.
    internal extension BridgedUIView {
    
        // retrieves the UIViewController that controls the view. This is done by looping up the UIResponder chain.
        var parentViewController: UIViewController? {
            var parentResponder: UIResponder? = self.nextResponder()
            while parentResponder != nil {
                parentResponder = parentResponder?.nextResponder()
                if let viewController = parentResponder as? NSCustomViewController {
                    return UIViewController(existingValue: viewController)
                }
            }
            return nil
        }
    }
#endif
