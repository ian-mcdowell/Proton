//
//  WebView.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import WebKit

/// Wrapper for WebView, which allows easy instantiation with a URL, if you wish.
public class WebView: View<WKWebView> {
    
    override public init() {
        super.init()
    }
    
    public convenience init(_ url: String) {
        self.init()
        if let u = NSURL(string: url) {
            view.loadRequest(NSURLRequest(URL: u))
        }
    }

}
