//
//  UIStackView.swift
//  Pods
//
//  Created by Ian McDowell on 4/18/16.
//
//

import AppKit

public class BridgedUIStackView<T: NSStackView>: BridgedUIView<T> {
    
    public init(arrangedSubviews: [UIView]) {
        super.init(frame: CGRectZero)
        
        self.bridgedView.orientation = .Vertical
        self.bridgedView.distribution = .GravityAreas
        self.bridgedView.alignment = .Left
        
        for view in arrangedSubviews {
            self.bridgedView.addArrangedSubview(view.bridgedView)
        }
    }
    
}