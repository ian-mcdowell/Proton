//
//  Proton.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/28/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

class Proton: UIWindow {
    
    init(rootPage: Page) {
        super.init(frame: UIScreen.mainScreen().bounds)
        self.backgroundColor = UIColor.whiteColor()
        self.makeKeyAndVisible()
        
        // embed root navigation controller if needed.
        if let _ = rootPage as? Navigatable {
            self.rootViewController = UINavigationController(rootViewController: rootPage)
        } else {
            self.rootViewController = rootPage
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}