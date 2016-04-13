//
//  AppDelegate.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 4/13/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Proton

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
        self.window = Proton(rootPage: ImageViewPage())
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

