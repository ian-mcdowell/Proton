//
//  RootPage.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//
import UIKit

class RootPage: Page, Navigatable {
    
    var worldLabel: UILabel!

    override func layout() -> ViewHolder {
        return Stack([
            Label("hello").tapped {
                self.push(SecondPage())
            },
            
            Label.assign(&worldLabel).construct { label in
                label.text = "world"
                label.textColor = UIColor.blueColor()
            },
            
            Label("this is a test").construct { label in
                label.textColor = UIColor.redColor()
            }.tapped {
                self.worldLabel.text! += "!"
            }
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Proton"
    }
}
