//
//  Page.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

/// Base class of each "Page" of the app, which under the hood is a UIViewController.
/// Override the `layout` method to define it's layout.
public class Page: UIViewController {
    
    private var lastLayout: ProtonView!
    
    required public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func loadView() {
        // perform layout
        lastLayout = self.layout()
        self.view = lastLayout.getView()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        #if os(iOS)
        // don't extend under bars
        self.edgesForExtendedLayout = UIRectEdge.None
        #endif
    }
    
    #if os(iOS)
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    #elseif os(OSX)
    override public func viewDidAppear() {
        super.viewDidAppear()
    }
    #endif
    
    
    public func layout() -> ProtonView {
        return View<UIView>().construct { view in
            view.backgroundColor = UIColor.whiteColor()
        }
    }

}

