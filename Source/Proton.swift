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
    
    #if os(iOS)
    
    public init(rootPage: Page) {
        super.init(frame: UIScreen.mainScreen().bounds)
        self.backgroundColor = UIColor.whiteColor()
        self.makeKeyAndVisible()
        
        // embed root navigation controller if needed.
        if let _ = rootPage as? Navigatable {
            self.rootViewController = UINavigationController(rootViewController: rootPage)
        } else {
            self.rootViewController = rootPage
        }
    }
    
    #elseif os(OSX)
    private var rootViewController: Page!
    private let width: CGFloat = 640
    private let height: CGFloat = 480
    
    public init(rootPage: Page) {
        super.init(contentRect: NSMakeRect(0, 0, width, height), styleMask: NSTitledWindowMask | NSClosableWindowMask | NSResizableWindowMask, backing: .Buffered, defer: false)
        
        // center on screen
        let xPos = NSWidth(self.screen!.frame) / 2 - width / 2
        let yPos = NSHeight(self.screen!.frame) / 2 - height / 2

        self.setFrameOrigin(NSMakePoint(xPos, yPos))
        
        self.rootViewController = rootPage
        self.contentView = rootPage.view
        
        self.makeKeyAndOrderFront(NSApp)
    }
    
    #endif
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}