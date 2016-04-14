//
//  UIScrollView.swift
//  Pods
//
//  Created by Ian McDowell on 4/13/16.
//
//

import AppKit

public class BridgedUIScrollView<T: NSScrollView>: BridgedUIView<T> {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
}