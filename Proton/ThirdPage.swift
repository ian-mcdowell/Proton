//
//  ThirdPage.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 4/4/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

class ThirdPage: Page {

    init(text: String) {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layout() -> ProtonView {
        return AbsoluteLayout([
//            Label("Test").positionCenter().size(width: 50%, height: 50%),
//            Label("testing a longer string overlapping").position(top: 10%, left: 0%),
            View<UIWebView>().construct { view in
                view.loadRequest(NSURLRequest(URL: NSURL(string: "https://google.com")!))
            }.position(top: 10%, left: 10%).size(width: 80%, height: 80%)
        ])
    }
    
}
