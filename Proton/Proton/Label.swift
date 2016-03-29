//
//  Label.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

/// Wrapper for UILabel, which allows easy instantiation with text, if you wish.
class Label: View<UILabel> {
    
    override init() {
        super.init()
    }
    
    convenience init(_ text: String) {
        self.init()
        view.text = text
    }

}
