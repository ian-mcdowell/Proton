//
//  AppKitBridge.swift
//  Pods
//
//  Created by Ian McDowell on 4/13/16.
//
//

public typealias UIColor = BridgedUIColor<NSColor>
public typealias UIImage = BridgedUIImage<NSImage>

public typealias UIResponder = BridgedUIResponder<NSResponder>
    public typealias UIWindow = BridgedUIWindow<NSWindow>
    public typealias UIView = BridgedUIView<NSView>
        public typealias UIControl = BridgedUIControl<NSControl>
            public typealias UIButton = BridgedUIButton<NSButton>
            // UIDatePicker
            // UISlider
            // UIStepper
            // UISwitch
            public typealias UITextField = BridgedUITextField<NSTextField>
        // UIImageView
        public typealias UILabel = BridgedUILabel<NSTextField>
        // UINavigationBar
        public typealias UIScrollView = BridgedUIScrollView<NSScrollView>
            // UICollectionView
            public typealias UITableView = BridgedUITableView<NSTableView>
            // UITextView
        // UIStackView
        // UITabBar
        // UITableViewCell
        // UIToolbar
        // UIWindow
    public typealias UIViewController = BridgedUIViewController<NSViewController>
        public typealias UINavigationController = BridgedUINavigationController<NSViewController>



// TODO:
public typealias UIStackView = BridgedUIResponder<NSStackView>

public class BridgedView<T: NSObject>: NSObject {
    
    var bridgedView: T!
    
    func createView() -> T {
        return T()
    }
    
    public override init() {
        super.init()
        
        self.bridgedView = self.createView()
    }
    
    public init(existingValue: T) {
        super.init()
        
        self.bridgedView = existingValue
    }
    public init?(existingValue: T?) {
        super.init()
        
        self.bridgedView = existingValue
    }

}

