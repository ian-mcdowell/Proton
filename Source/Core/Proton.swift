//
//  Proton.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/28/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

#if os(OSX)
    
    public typealias UINavigationController = UXNavigationController
    public typealias UIView = UXView
    public typealias UIViewController = UXViewController
    public typealias UICollectionView = UXCollectionView
    public typealias UITableView = UXTableView
    public typealias UICollectionViewDataSource = UXCollectionViewDataSource
    public typealias UITableViewDataSource = UXTableViewDataSource
    public typealias UICollectionViewCell = UXCollectionViewCell
    public typealias UITableViewCell = UXTableViewCell
    public typealias UITableViewDelegate = UXTableViewDelegate
    
    public typealias UIImageView = UXImageView
    public typealias UILabel = UXLabel
    public typealias UIToolbar = UXToolbar

    public typealias UIColor = NSColor
    public typealias UIImage = NSImage
    public typealias UITextField = NSTextField
    public typealias UIStackView = NSStackView
    public typealias UIWindow = NSWindow
    
#endif

#if os(iOS)
/// The root of a Proton application. Set the `window` property of your AppDelegate to
/// an instance of this. 
public class Proton: UIWindow {
    
    
    public init(rootPage: Page) {
        super.init(frame: UIScreen.mainScreen().bounds)
    
        setup(rootPage)
    }
    
    
    private func setup(rootPage: Page) {
        self.backgroundColor = UIColor.whiteColor()
        
        // embed root navigation controller if needed.
        if let _ = rootPage as? Navigatable {
            self.rootViewController = UINavigationController(rootViewController: rootPage)
        } else {
            self.rootViewController = rootPage
        }
        
        self.makeKeyAndVisible()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

#elseif os(OSX)
    /// The root of a Proton application. Set the `window` property of your AppDelegate to
    /// an instance of this.
    public class Proton: UXWindowController {
        
        
        public init(rootPage: Page, frame: CGRect) {
            super.init(rootViewController: rootPage)

        }
        
        required public init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        

        
    }

#endif