//
//  Label.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

class Label: View<UILabel> {
    
    override init() {

    }
    
    convenience init(_ text: String) {
        self.init()
        view.text = text
    }

}
