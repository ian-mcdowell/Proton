//
//  Dispatch.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 4/11/16.
//  Copyright © 2016 Ian McDowell. All rights reserved.
//

import UIKit

class Dispatch {
    
    class func delay(timeInSeconds: Double, _ action: () -> Void) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(timeInSeconds * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), action)
    }
    
}