//
//  View.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//
import UIKit

protocol ViewHolder {
    func getView() -> UIView
}

class View<T: UIView>: ViewHolder {
    
    var view: T = T()
    
    // internal
    internal var clickHandler = ClickHandler()
    
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
    
    
    static func construct(fn: (view: T) -> Void) -> View {
        return View<T>().construct(fn)
    }
    
    static func tapped(fn: () -> Void) -> View {
        return View<T>().tapped(fn)
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