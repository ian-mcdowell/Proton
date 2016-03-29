//
//  Page.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

/// Base class of each "Page" of the app, which under the hood is a UIViewController.
/// Override the `layout` method to define it's layout.
class Page: UIViewController {
    
    private var lastLayout: ViewHolder!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // default background color
        self.view.backgroundColor = UIColor.whiteColor()
        
        // don't extend under bars
        self.edgesForExtendedLayout = UIRectEdge.None
        
        // perform layout
        lastLayout = self.layout()
        let view = lastLayout.getView()
        self.view.addSubview(view)
        view.constrainToEdgesOfSuperview()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func layout() -> ViewHolder {
        return View()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

