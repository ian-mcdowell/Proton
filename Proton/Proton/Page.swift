//
//  ViewController.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

extension UIView {
    func constrainToEdgesOfSuperview() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraintEqualToAnchor(self.superview!.leadingAnchor).active = true
        self.trailingAnchor.constraintEqualToAnchor(self.superview!.trailingAnchor).active = true
        self.topAnchor.constraintEqualToAnchor(self.superview!.topAnchor).active = true
        self.bottomAnchor.constraintEqualToAnchor(self.superview!.bottomAnchor).active = true
    }
}


protocol Navigatable: class {
    func push(page: Page)
    func pop()
}

extension Navigatable {
    
    // navigatable defaults
    func push(page: Page, animated: Bool = true) {
        if let navController = (self as? UIViewController)?.navigationController {
            navController.pushViewController(page, animated: animated)
        } else {
            print("Proton: No UINavigationController found to push the page to.")
        }
    }
    
    func pop(animated: Bool = true) {
        if let navController = (self as? UIViewController)?.navigationController {
            navController.popViewControllerAnimated(animated)
        } else {
            print("Proton: No UINavigationController found to pop from.")
        }
    }
}

class Page: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = self.layout().getView()
        self.view.addSubview(view)
        view.constrainToEdgesOfSuperview()
    }
    
    func layout() -> ViewHolder {
        return View()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

