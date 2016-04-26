//
//  UINavigationController.swift
//  Pods
//
//  Created by Ian McDowell on 4/14/16.
//
//

import AppKit


public class BridgedUINavigationController<T: NSCustomViewController>: BridgedUIViewController<T> {

    
    public var viewControllers = [UIViewController]()
    public var navigationBar: UINavigationBar = UINavigationBar(identifier: "navigation_bar")
    
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
    
    public override func viewDidAppear() {
        super.viewDidAppear()
        
        let window = self.view.window
        
        self.view.window?.toolbar = navigationBar
    }
    
    
    public func pushViewController(viewController: UIViewController, animated: Bool) {
        viewControllers.append(viewController)
        navigationBar.pushNavigationItem(viewController.navigationItem, animated: animated)
        
        //viewControllerNavigationControllerMap[viewController] = self
    }
    
    public func popViewControllerAnimated(animated: Bool) -> UIViewController? {
        let last = viewControllers.removeLast()
        navigationBar.popNavigationItemAnimated(animated)
        
        return last
    }
    
    // I am a navigationController. Therefore I know who my navigationController is. Hint: It's me.
    public override var navigationController: UINavigationController? {
        get {
            return self as? UINavigationController
        }
    }
    
    public var topViewController: UIViewController? {
        get {
            return viewControllers.last
        }
    }
    
    public var visibleViewController: UIViewController? {
        get {
            return viewControllers.last
        }
    }
}


public class BridgedUINavigationBar<T: NSToolbar>: BridgedUIToolbar<T> {
    
    private var identifier: String
    public init(identifier: String) {
        self.identifier = identifier
        super.init()
    }
    
    override func createView() -> T {
        return T(identifier: self.identifier)
    }
    
    
    public var items: [UINavigationItem]? = [UINavigationItem]()
    
    public var topItem: UINavigationItem? {
        get {
            return items?.last
        }
    }
    
    public var backItem: UINavigationItem? {
        get {
            if items?.count < 2 {
                return nil
            }
            return items?[items?.count ?? 0 - 2]
        }
    }
    
    public func pushNavigationItem(item: UINavigationItem, animated: Bool) {
        items?.append(item)
    }
    
    public func popNavigationItemAnimated(animated: Bool) -> UINavigationItem? {
        let last = items?.removeLast()
        
        return last
    }
    
    public func setItems(items: [UINavigationItem]?, animated: Bool) {
        self.items = items
    }
}

public class UINavigationItem {
    
    public var title: String?
//    public var prompt: String?
//    public var backBarButtonItem: UIBarButtonItem?
//    public var hidesBackButton: Bool = false
    public var titleView: UIView?
    public var leftBarButtonItems: [UIBarButtonItem]?
    public var leftBarButtonItem: UIBarButtonItem?
    public var rightBarButtonItems: [UIBarButtonItem]?
    public var rightBarButtonItem: UIBarButtonItem?
    
    public init(title: String?) {
        self.title = title
    }
    
    public func setLeftBarButtonItems(items: [UIBarButtonItem]?, animated: Bool) {
        self.leftBarButtonItems = items
    }
    
    func setLeftBarButtonItem(item: UIBarButtonItem?, animated: Bool) {
        self.leftBarButtonItem = item
    }
    
    func setRightBarButtonItems(items: [UIBarButtonItem]?, animated: Bool) {
        self.rightBarButtonItems = items
    }
    
    func setRightBarButtonItem(item: UIBarButtonItem?, animated: Bool) {
        self.rightBarButtonItem = item
    }
}

public class UIBarItem {
    
}
public class UIBarButtonItem: UIBarItem {
    
}