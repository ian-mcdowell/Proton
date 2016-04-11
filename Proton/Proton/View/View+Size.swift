//
//  View+Size.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 4/5/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

extension View {
    func size(width width: Percent, height: Percent) -> View {
        self.size = LayoutSize(type: .Percent, width: width.value, height: height.value)
        return self
    }
    func size(width width: CGFloat, height: CGFloat) -> View {
        return self.size(size: CGSizeMake(width, height))
    }
    func size(size size: CGSize) -> View {
        self.size = LayoutSize(type: .Fixed, width: size.width, height: size.height)
        return self
    }
}
