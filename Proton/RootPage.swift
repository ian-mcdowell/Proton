//
//  RootPage.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//
import UIKit

class RootPage: Page {

    override func layout() -> ViewHolder {
        return Stack([
            Label("hello").tapped({ 
                print("Clicked")
            }),
            Label.construct { label in
                label.text = "world"
                label.textColor = UIColor.blueColor()
            },
            Label("this is a test").construct { label in
                label.textColor = UIColor.redColor()
            }
        ])
    }
    
}
