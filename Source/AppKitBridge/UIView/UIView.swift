//
//  UIView.swift
//  Pods
//
//  Created by Ian McDowell on 4/13/16.
//
//

import AppKit

public class BridgedUIView<T: NSView>: BridgedUIResponder<T> {
    
    // MARK: Init
    
    internal override init?(existingValue: T?) {
        super.init(existingValue: existingValue)
    }
    
    /// Initializes and returns a newly allocated view object with the specified frame rectangle.
    public required init(frame: CGRect) {
        super.init()
        
        let boundVars = [
            "hidden": "hidden",
            "alpha": "alphaValue",
            "opaque": "opaque",
            "layer": "layer",
            "translatesAutoresizingMaskIntoConstraints": "translatesAutoresizingMaskIntoConstraints"
        ]
        for v in boundVars {
            self.bind(v.0, toObject: self.bridgedView, withKeyPath: v.1, options: nil)
        }
        
    }
    
    // MARK: Visual appearance
    
    /// The view’s background color.
    var backgroundColor: UIColor? {
        set {
            self.bridgedView.wantsLayer = true
            self.bridgedView.layer?.backgroundColor = newValue?.bridgedView?.CGColor
        }
        get {
            if self.bridgedView.layer?.backgroundColor == nil {
                return  nil
            }
            return UIColor(CIColor: CIColor(CGColor: self.bridgedView.layer!.backgroundColor!))
        }
    }
    
    dynamic var hidden: Bool = false
    dynamic var alpha: CGFloat = 1
    dynamic var opaque: Bool = true
    
//    var tintColor: UIColor
//    var tintAdjustmentMode: UIViewTintAdjustmentMode
//    var clipsToBounds: Bool
//    var clearsContextBeforeDrawing: Bool
//    var maskView: UIView? 
//    class func layerClass() -> AnyClass
    dynamic var layer: CALayer? = nil
    
    // MARK: Event-Related behavior
    
    
    
    // MARK: Bounds and Frame
    
    
    
    // MARK: View heirarchy
    
    public var superview: UIView? {
        get {
            return UIView(existingValue: bridgedView.superview)
        }
    }
    
    /// Adds a view to the end of the receiver’s list of subviews.
    public func addSubview(view: UIView) {
        self.bridgedView.addSubview(view.bridgedView)
    }
    
    /// Unlinks the view from its superview and its window, and removes it from the responder chain.
    public func removeFromSuperview() {
        self.bridgedView.removeFromSuperview()
    }
    
    
    // MARK: Resizing
    
    
    
    // MARK: Layout subviews
    
    public class func requiresConstraintBasedLayout() -> Bool {
        return true
//        return self.bridgedView.requiresConstraintBasedLayout()
    }
    
    dynamic var translatesAutoresizingMaskIntoConstraints: Bool = true

    
    
    // MARK: Layout anchors
    public var bottomAnchor: NSLayoutYAxisAnchor {
        get {
            return bridgedView.bottomAnchor
        }
    }
    
    public var centerXAnchor: NSLayoutXAxisAnchor {
        get {
            return bridgedView.centerXAnchor
        }
    }
    
    public var centerYAnchor: NSLayoutYAxisAnchor {
        get {
            return bridgedView.centerYAnchor
        }
    }
    
    public var firstBaselineAnchor: NSLayoutYAxisAnchor {
        get {
            return bridgedView.firstBaselineAnchor
        }
    }
    
    public var heightAnchor: NSLayoutDimension {
        get {
            return bridgedView.heightAnchor
        }
    }
    
    public var lastBaselineAnchor: NSLayoutYAxisAnchor {
        get {
            return bridgedView.lastBaselineAnchor
        }
    }
    
    public var leadingAnchor: NSLayoutXAxisAnchor {
        get {
            return bridgedView.leadingAnchor
        }
    }
    
    public var leftAnchor: NSLayoutXAxisAnchor {
        get {
            return bridgedView.leftAnchor
        }
    }
    
    public var rightAnchor: NSLayoutXAxisAnchor {
        get {
            return bridgedView.rightAnchor
        }
    }
    
    public var topAnchor: NSLayoutYAxisAnchor {
        get {
            return bridgedView.topAnchor
        }
    }
    
    public var trailingAnchor: NSLayoutXAxisAnchor {
        get {
            return bridgedView.trailingAnchor
        }
    }
    
    public var widthAnchor: NSLayoutDimension {
        get {
            return bridgedView.widthAnchor
        }
    }
    
    
    // MARK: Constraints
    
    
    
    // MARK: Layout guides
    
    
    
    // MARK: Measuring in auto layout
    
    
    // MARK: Aligning views in auto layout
    
    
    // MARK: Triggering auto layout
    
    

    

}