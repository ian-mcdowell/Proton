//
//  UIViewController.swift
//  Pods
//
//  Created by Ian McDowell on 4/14/16.
//
//

import AppKit

//internal var viewControllerNavigationControllerMap = [UIViewController: UINavigationController]()
var token: dispatch_once_t = 0

//internal extension NSViewController {
//    
//    public override class func initialize() {
//        if self !== NSViewController.self {
//            return
//        }
//        
//        dispatch_once(&token) {
//            let originalSelector = #selector(NSViewController.loadView)
//            let swizzledSelector = #selector(NSViewController.swizzled_loadView)
//            
//            let originalMethod = class_getInstanceMethod(self, originalSelector)
//            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
//            
//            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
//            
//            if didAddMethod {
//                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
//            } else {
//                method_exchangeImplementations(originalMethod, swizzledMethod)
//            }
//        }
//    }
//    
//    func swizzled_loadView() {
//        
//    }
//    
//}

public protocol NSLoadView {
    func loadView()
}
public class NSCustomViewController: NSViewController {
    
    internal var bridgedController: NSLoadView?
    
    public override func loadView() {
        bridgedController?.loadView()
    }
}

public class BridgedUIViewController<T: NSCustomViewController>: BridgedUIResponder<T>, NSLoadView  {

    
    
    
    public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init()
        
        self.bridgedView.bridgedController = self
    }

    public override init?(existingValue: T?) {
        super.init(existingValue: existingValue)
    }
    
    
    public var view: UIView! {
        set {
            self.bridgedView.view = newValue.bridgedView
        }
        get {
            return UIView(existingValue: self.bridgedView.view)
        }
    }
    
    public var navigationController: UINavigationController? {
        get {
            return nil//viewControllerNavigationControllerMap[self]
        }
    }
    
    public var title: String? {
        set {
            self.bridgedView.title = newValue
        }
        get {
            return self.bridgedView.title
        }
    }
    
    public func loadView() {
        
    }
    
    public func viewDidLoad() {
        self.bridgedView.viewDidLoad()
    }
    
    public func viewDidAppear() {
        self.bridgedView.viewDidAppear()
    }
    
}