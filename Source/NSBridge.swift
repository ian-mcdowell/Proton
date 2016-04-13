//
//  NSBridge.swift
//  Pods
//
//  Created by McDowell, Ian J [ITACD] on 4/13/16.
//
//

#if os(iOS)
    

#elseif os(OSX)
    
    // ViewControllers
    public typealias UIWindow = NSWindow
    public typealias UIViewController = NSViewController
    
    // Views
    public typealias UIView = NSView
    public typealias UIImageView = NSImageView
    public typealias UITableView = NSTableView
    public typealias UICollectionView = NSCollectionView
    public typealias UIStackView = NSStackView
    public typealias UIActivityIndicatorView = NSProgressIndicator
    
    public typealias UIColor = NSColor
    public typealias UIDatePicker = NSDatePicker
    public typealias UIButton = NSButton
    public typealias UIImage = NSImage

    // Text
    public typealias UITextField = NSTextField
    public typealias UILabel = NSTextView
    
    // Enum
    public typealias UIButtonType = NSButtonType
    public typealias UIDatePickerMode = NSDatePickerMode
    
    public extension UIView {
        
        var backgroundColor: UIColor? {
            set {
                self.wantsLayer = true
                self.layer?.backgroundColor = newValue?.CGColor
            }
            get {
                if self.layer?.backgroundColor == nil {
                    return  nil
                }
                return UIColor(CIColor: CIColor(CGColor: self.layer!.backgroundColor!))
            }
        }
    }
    
#endif