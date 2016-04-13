//
//  View.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

/// Protocol that is implemented by every view in Proton.
/// This is used as the return type of the `layout` methods.
public protocol ProtonView {
    func getView() -> UIView
}

internal struct LayoutPosition {
    enum LayoutPositionType {
        case None, Percent, Absolute
    }
    init() {}
    init(type: LayoutPositionType, top: CGFloat?, bottom: CGFloat?, left: CGFloat?, right: CGFloat?) {
        self.type = type
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
    }
    
    var type: LayoutPositionType = .None
    var top: CGFloat? = nil
    var bottom: CGFloat? = nil
    var left: CGFloat? = nil
    var right: CGFloat? = nil
    
    var cX = false
    var cY = false
    internal mutating func centerX() {
        cX = true
        left = nil
        right = nil
    }
    internal mutating func centerY() {
        cY = true
        top = nil
        bottom = nil
    }
}

internal struct LayoutSize {
    enum LayoutSizeType {
        case None, Percent, Fixed
    }
    var type: LayoutSizeType
    var width: CGFloat? = nil
    var height: CGFloat? = nil
}

internal protocol AbsoluteLayoutView {
    var position: LayoutPosition {get}
    var size: LayoutSize {get}
}

/// Base class of View, which is a holder for a `UIView`. All other Proton views
/// are subclasses of this.
public class View<T: UIView>: ProtonView, AbsoluteLayoutView {
    
    var view: T = T()
    
    // internal
    internal var clickHandler = Handler()
    
    internal var position = LayoutPosition()
    internal var size = LayoutSize(type: .None, width: nil, height: nil)
    
    // private
    #if os(iOS)
    private var tapGestureRecognizer: UITapGestureRecognizer?
    #endif
    
    public init() {
        
    }
    
    // MARK: Construct
    
    public func construct(fn: (view: T) -> Void) -> Self {
        fn(view: view)
        
        return self
    }
    
    // MARK: tapped
    #if os(iOS)
    public func onTap(fn: () -> Void) -> Self {
        self.clickHandler.action = fn
        
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self.clickHandler, action: #selector(self.clickHandler.handleAction))
        
        self.view.addGestureRecognizer(self.tapGestureRecognizer!)
        self.view.userInteractionEnabled = true
        
        return self
    }
    #endif
    
    // MARK: assign
    public func assign(inout a: T!) -> Self {
        a = view
        return self
    }
    
    public func assign(inout a: T) -> Self {
        a = view
        return self
    }
    
    // MARK: Statics
    
    public static func construct(fn: (view: T) -> Void) -> View {
        return View<T>().construct(fn)
    }
    public static func assign(inout a: T!) -> View {
        return View<T>().assign(&a)
    }
    public static func assign(inout a: T) -> View {
        return View<T>().assign(&a)
    }
    
    
    // MARK: ViewHolder
    
    public func getView() -> UIView {
        return view
    }

}


internal class Handler: NSObject {
    
    var action: (() -> Void)?
    
    
    @objc func handleAction() {
        action?()
    }
}