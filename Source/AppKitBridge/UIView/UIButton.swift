//
//  UIButton.swift
//  Pods
//
//  Created by Ian McDowell on 4/13/16.
//
//

import AppKit

public class BridgedUIButton<T: NSButton>: BridgedUIControl<T> {
    
    func setTitle(title: String?, forState: UIControlState) {
        self.bridgedView.title = title ?? ""
    }
    
    func setImage(image: UIImage?, forState: UIControlState) {
        self.bridgedView.image = image?.bridgedView
    }
    
}