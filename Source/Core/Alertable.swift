//
//  Alertable.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/29/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

/// By placing this protocol on a `Page` or `View`, it allows you to show alerts
public protocol Alertable: class {
    #if os(iOS)
    func alert(title title: String?, message: String?, actions: [UIAlertAction])
    func actionSheet(title title: String?, message: String?, actions: [UIAlertAction])
    #endif
}

/// Extension to provide implementation of the `alert` method.
public extension Alertable {
    
    #if os(iOS)
    func alert(title title: String? = nil, message: String? = nil, actions: [UIAlertAction]) {
        self.showAlert(title, message: message, style: .Alert, actions: actions)
    }
    
    func actionSheet(title title: String? = nil, message: String? = nil, actions: [UIAlertAction]) {
        self.showAlert(title, message: message, style: .ActionSheet, actions: actions)
    }
    
    private func showAlert(title: String?, message: String?, style: UIAlertControllerStyle, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alertController.addAction(action)
        }
        
        if let vc = getViewController() {
            vc.presentViewController(alertController, animated: true, completion: nil)
        } else {
            print("Proton: No UIViewController found to display alert from.")
        }
    }
    
    private func getViewController() -> UIViewController? {
        if let vc = self as? UIViewController {
            return vc
        } else if let view = self as? UIView {
            return view.parentViewController
        } else if let viewHolder = self as? ProtonView {
            return viewHolder.getView().parentViewController
        }
        return nil
    }
    #endif
}

#if os(iOS)
public extension UIAlertAction {
    
    convenience init(title: String? = nil, style: UIAlertActionStyle = .Default) {
        self.init(title: title, style: style, handler: nil)
    }
}
#endif