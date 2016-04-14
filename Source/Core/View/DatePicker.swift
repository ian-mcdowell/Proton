//
//  DatePicker.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

/// Wrapper for UIDatePicker.
public class DatePicker: View<UIDatePicker> {
    
    private var inputManager = InputManager()
    
    #if os(iOS)
    public init(mode: UIDatePickerMode = .DateAndTime) {
        super.init()
        
        self.view.datePickerMode = mode
        
        self.view.addTarget(self.inputManager, action: #selector(InputManager.dateChanged), forControlEvents: .ValueChanged)
    }
    #endif
    
    public func onChange(fn: (picker: UIDatePicker) -> Void) -> Self {
        self.inputManager.changeHandler.action = {
            fn(picker: self.view)
        }
        
        return self
    }

}

private class InputManager: NSObject {
    
    var changeHandler = Handler()

    @objc func dateChanged() {
        changeHandler.handleAction()
    }
}