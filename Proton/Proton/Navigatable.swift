//
//  Navigatable.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/29/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

/// By placing this protocol on a `Page` or `View`, it allows you to push and pop
/// pages on and off the navigation stack.
protocol Navigatable: class {
    func push(page: Page, animated: Bool)
    func pop(animated: Bool)
}

/// Extension to provide implementation of `push` and `pop` methods.
extension Navigatable {
    
    // navigatable defaults
    func push(page: Page, animated: Bool = true) {
        if let navController = getNavController() {
            navController.pushViewController(page, animated: animated)
        } else {
            print("Proton: No UINavigationController found to push the page to.")
        }
    }
    
    func pop(animated: Bool = true) {
        if let navController = getNavController() {
            navController.popViewControllerAnimated(animated)
        } else {
            print("Proton: No UINavigationController found to pop from.")
        }
    }
    
    private func getNavController() -> UINavigationController? {
        if let vc = self as? UIViewController {
            return vc.navigationController
        } else if let view = self as? UIView {
            return view.parentViewController?.navigationController
        } else if let viewHolder = self as? ProtonView {
            return viewHolder.getView().parentViewController?.navigationController
        }
        return nil
    }
}