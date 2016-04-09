//
//  View.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//
import UIKit

/// Protocol that is implemented by every view in Proton.
/// This is used as the return type of the `layout` methods.
protocol ProtonView {
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
    let type: LayoutSizeType
    var width: CGFloat? = nil
    var height: CGFloat? = nil
}

internal protocol AbsoluteLayoutView {
    var position: LayoutPosition {get}
    var size: LayoutSize {get}
}

/// Base class of View, which is a holder for a `UIView`. All other Proton views
/// are subclasses of this.
class View<T: UIView>: ProtonView, AbsoluteLayoutView {
    
    var view: T = T()
    
    // internal
    internal var clickHandler = ClickHandler()
    
    internal var position = LayoutPosition()
    internal var size = LayoutSize(type: .None, width: nil, height: nil)
    
    // private
    private var tapGestureRecognizer: UITapGestureRecognizer?
    
    init() {
        
    }
    
    // MARK: Construct
    
    func construct(fn: (view: T) -> Void) -> View {
        fn(view: view)
        
        return self
    }
    
    // MARK: tapped
    
    func tapped(fn: () -> Void) -> View {
        self.clickHandler.tapAction = fn
        
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self.clickHandler, action: #selector(self.clickHandler.handleTap))
        
        self.view.addGestureRecognizer(self.tapGestureRecognizer!)
        self.view.userInteractionEnabled = true
        
        return self
    }
    
    // MARK: assign
    func assign(inout a: T!) -> View {
        a = view
        return self
    }
    
    func assign(inout a: T) -> View {
        a = view
        return self
    }
    
    // MARK: Statics
    
    static func construct(fn: (view: T) -> Void) -> View {
        return View<T>().construct(fn)
    }
    static func assign(inout a: T!) -> View {
        return View<T>().assign(&a)
    }
    static func assign(inout a: T) -> View {
        return View<T>().assign(&a)
    }
    
    
    // MARK: ViewHolder
    
    func getView() -> UIView {
        return view
    }

}


internal class ClickHandler: NSObject {
    
    var tapAction: (() -> Void)?
    
    
    @objc func handleTap() {
        if let action = tapAction {
            action()
        }
    }
}