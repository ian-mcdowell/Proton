//
//  UIColor.swift
//  Pods
//
//  Created by Ian McDowell on 4/14/16.
//
//

import AppKit

public class BridgedUIColor<T: NSColor>: BridgedView<T> {
    
    // MARK: Internal init
    internal override init(existingValue: T) {
        super.init(existingValue: existingValue)
    }
    
    // MARK: init
    public init(white: CGFloat, alpha: CGFloat) {
        super.init(existingValue: T(white: white, alpha: alpha))
    }
    
    public init(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        super.init(existingValue: T(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha))
    }
    
    public init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        super.init(existingValue: T(red: red, green: green, blue: blue, alpha: alpha))
    }
    
    public init(CGColor cgColor: CGColor) {
        super.init(existingValue: T(CGColor: cgColor)!)
    }
    
    public init(patternImage: UIImage) {
        super.init(existingValue: T(patternImage: patternImage.bridgedView))
    }
    
    public init(CIColor ciColor: CIColor) {
        super.init(existingValue: T(CIColor: ciColor))
    }
    
    
    
    
    public class func whiteColor() -> UIColor {
        return UIColor(existingValue: NSColor.whiteColor())
    }
    
    public class func lightGrayColor() -> UIColor {
        return UIColor(existingValue: NSColor.lightGrayColor())
    }
    
}