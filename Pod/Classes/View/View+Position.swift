//
//  View+Position.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 4/5/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

public extension View {
    public func position(top top: Percent? = nil, bottom: Percent? = nil, left: Percent? = nil, right: Percent? = nil) -> Self {
        self.position.type = .Percent
        if top != nil {
            self.position.top = top?.value
        }
        if bottom != nil {
            self.position.bottom = bottom?.value
        }
        if left != nil {
            self.position.left = left?.value
        }
        if right != nil {
            self.position.right = right?.value
        }
        return self
    }
    public func position(top top: CGFloat? = nil, bottom: CGFloat? = nil, left: CGFloat? = nil, right: CGFloat? = nil) -> Self {
        self.position.type = .Absolute
        if top != nil {
            self.position.top = top
        }
        if bottom != nil {
            self.position.bottom = bottom
        }
        if left != nil {
            self.position.left = left
        }
        if right != nil {
            self.position.right = right
        }
        return self
    }
    
    public func positionCenter() -> Self {
        positionCenterX()
        positionCenterY()
        return self
    }
    public func positionCenterX() -> Self {
        self.position.centerX()
        return self
    }
    public func positionCenterY() -> Self {
        self.position.centerY()
        return self
    }
    
    public func positionTopLeft(offset: CGFloat? = 0) -> Self {
        self.position.type = .Absolute
        self.position.top = offset
        self.position.left = offset
        return self
    }
    public func positionTopRight(offset: CGFloat? = 0) -> Self {
        self.position.type = .Absolute
        self.position.top = offset
        self.position.right = offset
        return self
    }
    public func positionBottomLeft(offset: CGFloat? = 0) -> Self {
        self.position.type = .Absolute
        self.position.bottom = offset
        self.position.left = offset
        return self
    }
    public func positionBottomRight(offset: CGFloat? = 0) -> Self {
        self.position.type = .Absolute
        self.position.bottom = offset
        self.position.right = offset
        return self
    }
    
    public func positionTopLeft(offset: Percent) -> Self {
        self.position.type = .Percent
        self.position.top = offset.value
        self.position.left = offset.value
        return self
    }
    public func positionTopRight(offset: Percent) -> Self {
        self.position.type = .Percent
        self.position.top = offset.value
        self.position.right = offset.value
        return self
    }
    public func positionBottomLeft(offset: Percent) -> Self {
        self.position.type = .Percent
        self.position.bottom = offset.value
        self.position.left = offset.value
        return self
    }
    public func positionBottomRight(offset: Percent) -> Self {
        self.position.type = .Percent
        self.position.bottom = offset.value
        self.position.right = offset.value
        return self
    }
    
    public func positionFill(offset: CGFloat? = 0) -> Self {
        self.position = LayoutPosition(type: .Absolute, top: offset, bottom: offset, left: offset, right: offset)
        return self
    }
    public func positionFill(offset: Percent) -> Self {
        self.position = LayoutPosition(type: .Percent, top: offset.value, bottom: offset.value, left: offset.value, right: offset.value)
        return self
    }
}
