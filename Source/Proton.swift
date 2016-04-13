//
//  Proton.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/28/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

/// The root of a Proton application. Set the `window` property of your AppDelegate to
/// an instance of this. 
public class Proton: UIWindow {
    
    
    public init(rootPage: Page) {
    #if os(iOS)
        super.init(frame: UIScreen.mainScreen().bounds)
        self.makeKeyAndVisible()
    #elseif os(OSX)
        super.init(contentRect: NSMakeRect(0, 0, width, height), styleMask: NSTitledWindowMask | NSClosableWindowMask | NSResizableWindowMask, backing: .Buffered, defer: false)
        self.setSize()
        self.makeKeyAndOrderFront(NSApp)
    #endif
    
        self.backgroundColor = UIColor.whiteColor()
    
        
        // embed root navigation controller if needed.
        if let _ = rootPage as? Navigatable {
            self.setRootViewController(UINavigationController(rootViewController: rootPage))
        } else {
            self.setRootViewController(rootPage)
        }
    }
    
    #if os(OSX)
    
    private let width: CGFloat = 640
    private let height: CGFloat = 480
    private func setSize() {
        // center on screen
        let xPos = NSWidth(self.screen!.frame) / 2 - width / 2
        let yPos = NSHeight(self.screen!.frame) / 2 - height / 2
        
        self.setFrameOrigin(NSMakePoint(xPos, yPos))
    }
    private var rootViewController: UIViewController! {
        didSet {
            self.contentView = rootViewController.view
            
            rootViewController.view.constrainToSidesOfSuperview()
            rootViewController.view.constrainToBottomOfSuperview()
            
            let toolbarView = self.standardWindowButton(NSWindowButton.CloseButton)?.superview
            rootViewController.view.topAnchor.constraintEqualToAnchor(toolbarView!.bottomAnchor).active = true
        }
    }
    
    #endif
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This method is here so the didSet method gets called of `rootViewController` when called from init()
    private func setRootViewController(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
}