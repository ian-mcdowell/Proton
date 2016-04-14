//
//  UINavigationController.swift
//  Pods
//
//  Created by Ian McDowell on 4/14/16.
//
//

import AppKit


public class BridgedUINavigationController<T: NSCustomViewController>: BridgedUIViewController<T> {

    
    public var viewControllers = Array<UIViewController>()
    
    private var currentViewController = 0
    
    public init(rootViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        
        self.pushViewController(rootViewController, animated: false)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    internal init?(existingValue: T?) {
//        super.init?(existingValue: T)
//    }
    
    public override func loadView() {
        self.bridgedView.view = viewControllers[currentViewController].bridgedView.view
    }
    
    
    public func pushViewController(viewController: UIViewController, animated: Bool) {
        viewControllers.append(viewController)
        
        //viewControllerNavigationControllerMap[viewController] = self
    }
    
    public func popViewControllerAnimated(animated: Bool) -> UIViewController? {
        let last = viewControllers.removeLast()
        
        return last
    }
    
    // I am a navigationController. Therefore I know who my navigationController is. Hint: It's me.
    public override var navigationController: UINavigationController? {
        get {
            return self as? UINavigationController
        }
    }
}