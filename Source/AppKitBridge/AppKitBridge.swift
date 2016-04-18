//
//  AppKitBridge.swift
//  Pods
//
//  Created by Ian McDowell on 4/13/16.
//
//

public typealias UIColor = BridgedUIColor<NSColor>
public typealias UIImage = BridgedUIImage<NSImage>
public typealias UINib = BridgedUINib<NSNib>

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
            public typealias UITableView = BridgedUITableView<NSCustomTableView>
            // UITextView
        public typealias UIStackView = BridgedUIStackView<NSStackView>
        // UITabBar
        public typealias UITableViewCell = BridgedUITableViewCell<NSTableRowView>
        // UIToolbar
        // UIWindow
    public typealias UIViewController = BridgedUIViewController<NSCustomViewController>
        public typealias UINavigationController = BridgedUINavigationController<NSCustomViewController>





public enum UIControlState {
    case Normal, Highlighted, Disabled, Selected, Focused, Application, Reserved
}

public enum UIButtonType {
    case Custom, System, DetailDisclosure, InfoLight, InfoDark, ContactAdd
}

public enum UITableViewCellStyle {
    case Default, Value1, Value2, Subtitle
}


public protocol BridgedNSView {
    func getView() -> NSObject
}

public class BridgedView<T: NSObject>: NSObject, BridgedNSView {
    
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
    
    public func getView() -> NSObject {
        return self.bridgedView
    }

}

