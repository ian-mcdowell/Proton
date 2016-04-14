//
//  NSBridge.swift
//  Pods
//
//  Created by McDowell, Ian J [ITACD] on 4/13/16.
//
//

#if os(iOS)
    

#elseif os(OSX)

    

    
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