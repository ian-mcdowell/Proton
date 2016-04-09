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
    
    private var lastLayout: ProtonView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        // perform layout
        lastLayout = self.layout()
        self.view = lastLayout.getView()
        
        self.view.backgroundColor = UIColor.whiteColor()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // don't extend under bars
        self.edgesForExtendedLayout = UIRectEdge.None
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    func layout() -> ProtonView {
        return View().construct { view in
            view.backgroundColor = UIColor.whiteColor()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

