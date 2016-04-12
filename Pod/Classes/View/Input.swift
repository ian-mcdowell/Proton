//
//  Input.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 3/25/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

/// Wrapper for UITextField, which allows easy instantiation with text or a placeholder.
public class Input: View<UITextField> {
    
    private var inputManager = InputManager()
    
    public init(text: String? = nil, placeholder: String? = nil) {
        super.init()
        
        self.view.text = text
        self.view.placeholder = placeholder
        
        self.view.delegate = self.inputManager
    }
    
    public func onReturn(fn: (field: UITextField) -> Void) -> Self {
        self.inputManager.returnHandler.action = {
            fn(field: self.view)
        }
        
        return self
    }

}

private class InputManager: NSObject, UITextFieldDelegate {
    
    var returnHandler = Handler()

    @objc func textFieldShouldReturn(textField: UITextField) -> Bool {
        returnHandler.handleAction()
        
        return true
    }
}