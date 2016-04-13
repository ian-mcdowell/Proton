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
    public typealias UITableViewCell = NSTableRowView
    public typealias UICollectionView = NSCollectionView
    public typealias UIStackView = NSStackView
    public typealias UIActivityIndicatorView = NSProgressIndicator
    
    public typealias UIColor = NSColor
    public typealias UIDatePicker = NSDatePicker
    public typealias UIButton = NSButton
    public typealias UIImage = NSImage

    // Text
    public typealias UITextField = NSTextField
    public typealias UILabel = NSTextField
    public typealias UIFont = NSFont
    
    // Enum
    public typealias UIDatePickerMode = NSDatePickerMode
    
    
    public extension NSView {
        
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
    
    public extension NSTextField {
        
        var text: String? {
            set {
                self.stringValue = newValue ?? ""
            }
            get {
                return self.stringValue
            }
        }
        
        var placeholder: String? {
            set {
                self.placeholderString = newValue
            }
            get {
                return self.placeholderString
            }
        }
        
        var textAlignment: NSTextAlignment {
            set {
                self.alignment = textAlignment
            }
            get {
                return self.alignment
            }
        }
    }
    
    public extension NSTextView {
        
        var text: String? {
            set {
                self.string = text
            }
            get {
                return self.string
            }
        }
        
        var textAlignment: NSTextAlignment {
            set {
                self.alignment = textAlignment
            }
            get {
                return self.alignment
            }
        }
    }
    
    public extension NSButton {
        
        func setTitle(title: String?, forState: UIControlState) {
            self.title = title ?? ""
        }
        
        func setImage(image: UIImage?, forState: UIControlState) {
            self.image = image
        }
    }
    
    
    public class UINavigationController: UIViewController {
        
        private var rootViewController: UIViewController!
        public init(rootViewController: UIViewController) {
            super.init(nibName: nil, bundle: nil)!
            
            self.rootViewController = rootViewController
        }
        
        required public init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public override func loadView() {
            self.view = rootViewController.view
        }
    }
    
    public enum UITableViewStyle {
        case Plain, Grouped
    }
    
    public enum UIButtonType {
        case Custom
        case System
        case DetailDisclosure
        case InfoLight
        case InfoDark
        case ContactAdd
    }
    
    public enum UIControlState {
        case Normal
        case Highlighted
        case Disabled
        case Selected
        case Focused
        case Application
        case Reserved
    }
    
#endif