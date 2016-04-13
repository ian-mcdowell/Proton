//
//  ActivityIndicator.swift
//  Pods
//
//  Created by McDowell, Ian J [ITACD] on 4/12/16.
//
//

/// Wrapper for UIActivityIndicatorView.
public class ActivityIndicator: View<UIActivityIndicatorView> {
    
    public override init() {
        super.init()
        
        #if os(iOS)
        self.view.activityIndicatorViewStyle = .Gray
        
        self.view.startAnimating()
        
        self.view.hidesWhenStopped = true
        #elseif os(OSX)
        self.view.style = .SpinningStyle
        #endif
    }
    
    public convenience init(color: UIColor) {
        self.init()
        
        #if os(iOS)
        self.view.color = color
        #endif
    }
    
}