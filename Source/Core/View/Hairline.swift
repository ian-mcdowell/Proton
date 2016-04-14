//
//  Hairline.swift
//  Pods
//
//  Created by McDowell, Ian J [ITACD] on 4/11/16.
//
//

public enum Direction {
    case Vertical, Horizontal
}

public class Hairline: View<UIView> {

    public init(color: UIColor = UIColor.lightGrayColor(), direction: Direction = .Horizontal) {
        super.init()
        
        switch direction {
        case .Vertical:
            self.width(1)
        case .Horizontal:
            self.height(1)
        }
        
        self.view.backgroundColor = color
    }
}
