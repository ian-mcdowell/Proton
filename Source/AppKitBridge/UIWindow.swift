//
//  UIWindow.swift
//  Pods
//
//  Created by Ian McDowell on 4/14/16.
//
//

import AppKit

// UIWindow inherits from UIView. NSWindow does not. It inherits from NSResponder.
public class BridgedUIWindow<T: NSWindow>: BridgedUIResponder<T> {
    
    public required init(frame: CGRect) {
        super.init()
        
        
        
    }
    
    // MARK: Internal
    
    internal override init?(existingValue: T?) {
        super.init(existingValue: existingValue)
    }
    
    
    override func createView() -> T {
        let window = NSWindow(contentRect: NSMakeRect(0, 0, width, height), styleMask: NSTitledWindowMask | NSClosableWindowMask | NSResizableWindowMask, backing: .Buffered, defer: false)
        self.centerWindow(window)
        
        return window as! T
    }
    
    private let width: CGFloat = 640
    private let height: CGFloat = 480
    private func centerWindow(window: NSWindow) {
        // center on screen
        let xPos = NSWidth(window.screen!.frame) / 2 - width / 2
        let yPos = NSHeight(window.screen!.frame) / 2 - height / 2
        
        window.setFrameOrigin(NSMakePoint(xPos, yPos))
    }
    
    
    
    
    public func makeKeyAndVisible() {
        self.bridgedView.makeKeyAndOrderFront(NSApp)
        
        debugPrint(self.bridgedView.frame)
    }
    
    
    /// The view’s background color.
    public var backgroundColor: UIColor? {
        set {
            self.bridgedView.backgroundColor = newValue?.bridgedView
        }
        get {
            return UIColor(existingValue: self.bridgedView.backgroundColor)
        }
    }
    
    public var rootViewController: UIViewController? {
        set {
            self.bridgedView.contentViewController = newValue?.bridgedView
        }
        get {
            return UIViewController(existingValue: self.bridgedView.contentViewController as? NSCustomViewController)
        }
    }
    
    
    public var toolbar: UIToolbar? {
        get {
            return self.bridgedView.toolbar?.viewBridge as! UIToolbar
        }
        set {
            self.bridgedView.toolbar = newValue?.bridgedView
        }
    }
    
}