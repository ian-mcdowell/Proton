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
    var backgroundColor: UIColor? {
        set {
            self.bridgedView.backgroundColor = newValue?.bridgedView
        }
        get {
            return UIColor(existingValue: self.bridgedView.backgroundColor)
        }
    }
    
    var rootViewController: UIViewController? {
        set {
            self.bridgedView.contentViewController = newValue?.bridgedView
        }
        get {
            return UIViewController(existingValue: self.bridgedView.contentViewController as? NSCustomViewController)
        }
    }
    
}