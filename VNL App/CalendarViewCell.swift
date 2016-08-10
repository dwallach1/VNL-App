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

    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    
    var normalDayColor = UIColor.whiteColor()
    var weekendDayColor = UIColor.VNLGrey()
    
    
    func setupCellBeforeDisplay(cellState: CellState, date: NSDate) {
        // Setup Cell text
        dayLabel.text =  cellState.text
        
        // Setup text color
        configureTextColor(cellState)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.whiteColor()
        
        selectedView.layer.cornerRadius = selectedView.frame.size.width / 2
        selectedView.clipsToBounds = true
        selectedView.backgroundColor = UIColor.VNLBlue()
    }
    
    func cellSelectionChanged(cellState: CellState) {
        if cellState.isSelected {
            selectedView.hidden = false
            dayLabel.textColor = UIColor.whiteColor()
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
    }
    
}
