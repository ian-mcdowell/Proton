//
//  WebViewPage.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 4/4/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import Proton
import WebKit

class WebViewPage: Page {
    
    private var webView: WKWebView!
    
    override func layout() -> ProtonView {
        return StackLayout([
            Input(text: "https://google.com").height(40).onReturn { field in
                if let url = NSURL(string: field.text!) {
                    self.webView.loadRequest(NSURLRequest(URL: url))
                }
            },
            Hairline(),
            WebView("https://google.com").assign(&webView)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "WebView"
    }
    
}
