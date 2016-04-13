//
//  ImageViewPage.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 4/12/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Proton

class ImageViewPage: Page {

    override func layout() -> ProtonView {
        return WebView().construct { view in
            
            view.loadRequest(NSURLRequest(URL: NSURL(string: "https://google.com/")!))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ImageView"
    }
}