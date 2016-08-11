//
//  CaldendarViewCell.swift
//  VNL App
//
//  Created by David Wallach on 8/2/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewCell: JTAppleDayCellView {

    @IBOutlet weak var isTodayView: UIView!
    @IBOutlet weak var bookedView: UIView!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    
    var booked = false
    var selected = false
    
    func setupCellBeforeDisplay(cellState: CellState, date: NSDate) {
        
        dayLabel.text =  cellState.text
        configureTextColor(cellState)
    }
    
    
    func cellSelectionChanged(cellState: CellState) {
        if cellState.isSelected == true {
            selectedView.hidden = false
            selectedView.backgroundColor = UIColor.VNLBlue()
            dayLabel.textColor = UIColor.whiteColor()
            self.bringSubviewToFront(dayLabel)
        } else {
            selectedView.hidden = true
            dayLabel.textColor = UIColor.blackColor()
        }
    }
    
    func configureTextColor(cellState: CellState) {
        if cellState.dateBelongsTo == .ThisMonth {
            dayLabel.textColor = UIColor.blackColor()
        } else {
            dayLabel.textColor = UIColor.grayColor()
        }
        
        selectedView.layer.cornerRadius = selectedView.frame.size.width / 2
        selectedView.clipsToBounds = true
        bookedView.layer.cornerRadius = bookedView.frame.width / 2
        bookedView.clipsToBounds = true
        
        if bookedView.hidden == false {
            dayLabel.textColor = UIColor.whiteColor()
        }

    }
    
}
