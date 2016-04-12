//
//  ActivityIndicator.swift
//  Pods
//
//  Created by McDowell, Ian J [ITACD] on 4/12/16.
//
//

import UIKit

/// Wrapper for UIActivityIndicatorView.
public class ActivityIndicator: View<UIActivityIndicatorView> {
    
    public override init() {
        super.init()
        
        self.view.activityIndicatorViewStyle = .Gray
        
        self.view.startAnimating()
        
        self.view.hidesWhenStopped = true
    }
    
    public convenience init(color: UIColor) {
        self.init()

        self.view.color = color
    }
    
}