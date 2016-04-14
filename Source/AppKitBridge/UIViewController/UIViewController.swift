//
//  UIViewController.swift
//  Pods
//
//  Created by Ian McDowell on 4/14/16.
//
//

import AppKit

//internal var viewControllerNavigationControllerMap = [UIViewController: UINavigationController]()

public class BridgedUIViewController<T: NSViewController>: BridgedUIResponder<T>  {

    public var view: UIView!
    
    public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init()
        
    }

    public override init?(existingValue: T?) {
        super.init(existingValue: existingValue)
    }
    
    
    public var navigationController: UINavigationController? {
        get {
            return nil//viewControllerNavigationControllerMap[self]
        }
    }
    
    
    public func loadView() {
        self.bridgedView.loadView()
    }
    
    public func viewDidLoad() {
        self.bridgedView.viewDidLoad()
    }
    
    public func viewDidAppear() {
        self.bridgedView.viewDidAppear()
    }
    
}