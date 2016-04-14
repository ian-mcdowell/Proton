//
//  View+Size.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 4/5/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

public extension View {
    public func size(width width: Percent, height: Percent) -> Self {
        self.size = LayoutSize(type: .Percent, width: width.value, height: height.value)
        return self
    }
    public func size(width width: CGFloat, height: CGFloat) -> Self {
        return self.size(size: CGSizeMake(width, height))
    }
    public func size(size size: CGSize) -> Self {
        self.size = LayoutSize(type: .Fixed, width: size.width, height: size.height)
        return self
    }
    public func width(width: CGFloat) -> Self {
        self.size.type = .Fixed
        self.size.width = width
        return self
    }
    public func height(height: CGFloat) -> Self {
        self.size.type = .Fixed
        self.size.height = height
        return self
    }
    public func width(width: Percent) -> Self {
        self.size.type = .Percent
        self.size.width = width.value
        return self
    }
    public func height(height: Percent) -> Self {
        self.size.type = .Percent
        self.size.height = height.value
        return self
    }
}
