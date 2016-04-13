//
//  DatePickerPage.swift
//  Proton
//
//  Created by McDowell, Ian J [ITACD] on 4/12/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Proton

class DatePickerPage: Page {
    
    private var datePicker: UIDatePicker!
    private var label: UILabel!
    
    /// A date formatter to format the `date` property of `datePicker`.
    lazy var dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter
    }()
    
    override func layout() -> ProtonView {
        return StackLayout([
//            DatePicker().onChange { picker in
//                self.label.text = self.dateFormatter.stringFromDate(picker.date)
//            },
            Label(self.dateFormatter.stringFromDate(NSDate())).assign(&label).construct { view in
                view.textAlignment = .Center
            }
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "DatePicker"
    }
    
}
