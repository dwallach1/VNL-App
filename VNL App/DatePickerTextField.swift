//
//  DatePickerTextField.swift
//  DreamLeague
//
//  Created by David Wallach on 7/21/16.
//  Copyright © 2016 David Wallach. All rights reserved.
//

import Foundation
import TextFieldEffects

class UIDatePickerTextField: HoshiTextField {
    
    let datePicker = UIDatePicker()
    var datePickerMode: UIDatePickerMode = .Date
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.inputView = datePicker
        setDate()
        datePicker.addTarget(self, action: #selector(setDate), forControlEvents: .ValueChanged)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.inputView = datePicker
        setDate()
        datePicker.addTarget(self, action: #selector(setDate), forControlEvents: .ValueChanged)
    }
    
    func setDate() {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateStyle = .MediumStyle
        self.text = timeFormatter.stringFromDate(datePicker.date)
    }
    
}


