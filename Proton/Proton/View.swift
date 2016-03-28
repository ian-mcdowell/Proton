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
    
    
    // private
    private var tapGestureRecognizer: UITapGestureRecognizer?
    private var tapAction: (() -> Void)?
    
    init() {
        
    }
    
    // MARK: Construct
    
    func construct(fn: (view: T) -> Void) -> View {
        fn(view: view)
        
        return self
    }
    
    static func construct(fn: (view: T) -> Void) -> View {
        let l = View<T>()
        
        return l.construct(fn)
    }
    
    
    // MARK: tapped
    
    func tapped(fn: () -> Void) -> View {
        tapAction = fn
        
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        
        self.view.addGestureRecognizer(self.tapGestureRecognizer!)
        self.view.userInteractionEnabled = true
        
        return self
    }
    
    static func tapped(fn: () -> Void) -> View {
        let l = View<T>()
        
        return l.tapped(fn)
    }
    
    
    // MARK: ViewHolder
    
    func getView() -> UIView {
        return view
    }
    
    
    
    @objc func handleTap() {
        if let action = tapAction {
            action()
        }
    }
}
