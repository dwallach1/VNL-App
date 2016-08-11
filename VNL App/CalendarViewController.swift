//
//  CalendarViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/2/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import JTAppleCalendar
import SwiftDate
import MaterialKit
import FirebaseDatabase


class CalendarViewController: UIViewController {

    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var startDateTextField: UIDatePickerTextField!
    @IBOutlet weak var endDateTextField: UIDatePickerTextField!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var cancelButton: MKButton!
    @IBOutlet weak var bookButton: MKButton!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    let today = NSDate.today()
    var datesUnavailable: [String] = []
    var datesBookedArray: [String] = []
    var datesCurrentlySelected: [String] = []
    var price: Int = 0
    var currentPayment: Int = 0
    var ref: FIRDatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.registerCellViewXib(fileName: "CalendarViewCell")
        calendarView.cellInset = CGPoint(x: 0, y: 0)
        calendarView.firstDayOfWeek = .Monday
        calendarView.allowsMultipleSelection = true
        self.setAttributes()
        
        ref = FIRDatabase.database().reference().child("campsBay").child("bayHotel").child("rooms").child("\(AppState.sharedInstance.currRoomType)")
        
        self.ref.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            if snapshot.exists() {
                self.datesUnavailable = snapshot.value!["datesBooked"] as! [String]
            }
            self.price = snapshot.value!["price"] as! Int
            
        }) { (error) in
            print(error.localizedDescription)
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        calendarView.scrollToDate(today)
    }

    
    @IBAction func bookButtonTapped() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
//        var startDate = formatter.dateFromString(startDateTextField.text!)
//        let endDate = formatter.dateFromString(endDateTextField.text!)
        datesCurrentlySelected.sortInPlace()
        var startDate = formatter.dateFromString(datesCurrentlySelected.minElement()!)
        let endDate = formatter.dateFromString(datesCurrentlySelected.maxElement()!)
        
        while startDate?.compare(endDate!) != .OrderedDescending {
            
            datesBookedArray.append(formatter.stringFromDate(startDate!))
            startDate = startDate?.add(0, months: 0, weeks: 0, days: 1, hours: 0, minutes: 0, seconds: 0, nanoseconds: 0)
        }

        self.ref.child("datesBooked").setValue(datesBookedArray)

        
    }
}


extension CalendarViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate  {
    // Setting up manditory protocol method
    
    func configureCalendar(calendar: JTAppleCalendarView) -> (startDate: NSDate, endDate: NSDate, calendar: NSCalendar) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"

        let firstDate = formatter.dateFromString("JAN 01, 2016")
        let secondDate = NSDate().add(3)
        let aCalendar = NSCalendar.currentCalendar() // Properly configure your calendar to your time zone here
        
        return (startDate: firstDate!, endDate: secondDate, calendar: aCalendar)
    }

    
    func calendar(calendar: JTAppleCalendarView, isAboutToDisplayCell cell: JTAppleDayCellView, date: NSDate, cellState: CellState) {
        let cell = (cell as! CalendarViewCell)
        
        cell.bookedView.hidden = true
        cell.selectedView.hidden = true
        cell.dayLabel.textColor = UIColor.blackColor()
        cell.userInteractionEnabled = true

        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        
        if cellState.dateBelongsTo == .ThisMonth {
            cell.dayLabel.textColor = UIColor.blackColor()
        } else {
            if cell.bookedView.hidden {
                cell.dayLabel.textColor = UIColor.grayColor()
            }
        }
        
        if cellState.date == today {
            cell.selectedView.hidden = false
            cell.selectedView.backgroundColor = UIColor.VNLRed()
            cell.dayLabel.textColor = UIColor.whiteColor()
            cell.bringSubviewToFront(cell.dayLabel)
        }

        for date in datesCurrentlySelected {
            if cellState.date == formatter.dateFromString(date) {
                cell.selected = true
                cell.selectedView.hidden = false
                cell.selectedView.backgroundColor = UIColor.VNLBlue()
                cell.dayLabel.textColor = UIColor.whiteColor()
                cell.dayLabel.tintColor = UIColor.whiteColor()
                cell.bringSubviewToFront(cell.dayLabel)
            }
        }
       
        for date in datesUnavailable {
            if cellState.date == formatter.dateFromString(date) {
                
                cell.bookedView.hidden = false
                cell.bookedView.backgroundColor = UIColor.VNLDarkBlue()
                cell.dayLabel.textColor = UIColor.whiteColor()
                cell.bringSubviewToFront(cell.dayLabel)
                cell.userInteractionEnabled = false
            }
        }
        
        cell.setupCellBeforeDisplay(cellState, date: date)
        
    }
    
    func calendar(calendar: JTAppleCalendarView, didSelectDate date: NSDate, cell: JTAppleDayCellView?, cellState: CellState) {
        let cell = (cell as! CalendarViewCell)
        cell.cellSelectionChanged(cellState)
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        
        var duplicate = false
        
        for date in datesCurrentlySelected {
            if cellState.date == formatter.dateFromString(date) {
                duplicate = true
            }
        }
        if duplicate != true {
            datesCurrentlySelected.append(formatter.stringFromDate(cellState.date))
            updatePrices()
        }

    }
    
    func calendar(calendar: JTAppleCalendarView, didDeselectDate date: NSDate, cell: JTAppleDayCellView?, cellState: CellState) {
        let cell = (cell as! CalendarViewCell)
        cell.cellSelectionChanged(cellState)
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        
        var i: Int = 0
        for date in datesCurrentlySelected {
            if cellState.date == formatter.dateFromString(date) {
                datesCurrentlySelected.removeAtIndex(i)
            }
            i += 1
        }
        
        if cellState.date == today {
            cell.selectedView.hidden = false
            cell.selectedView.backgroundColor = UIColor.VNLRed()
            cell.dayLabel.textColor = UIColor.whiteColor()
            cell.bringSubviewToFront(cell.dayLabel)
        }
        
        updatePrices()
    }
    
    
    func calendar(calendar: JTAppleCalendarView, didScrollToDateSegmentStartingWithdate startDate: NSDate, endingWithDate endDate: NSDate) {
        let monthName = startDate.monthName
        let year = startDate.year
        monthLabel.text = monthName
        yearLabel.text = "\(year)"
        monthLabel.textColor = UIColor.VNLBlue()
        yearLabel.textColor = UIColor.VNLBlue()
        
    }

}


extension CalendarViewController {
    
    func setAttributes() {
        
        let buttons = [cancelButton, bookButton]
        
        for button in buttons {
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.rippleLayerColor = UIColor.whiteColor()
            button.backgroundColor = UIColor.VNLBlue()
            button.layer.cornerRadius = 4
        }
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), forControlEvents: .TouchUpInside)
        bookButton.setTitle("Book", forState: .Normal)
        todayButton.tintColor = UIColor.VNLBlue()
        todayButton.setTitle("Today", forState: .Normal)
        todayButton.addTarget(self, action: #selector(todayButtonTapped), forControlEvents: .TouchUpInside)
        
        let toolBar = UIToolbar().ToolbarPiker(#selector(dismissPicker))
        let textFields : [UIDatePickerTextField] = [startDateTextField, endDateTextField]
        
        for textField in textFields {
            textField.inputAccessoryView = toolBar
            textField.borderActiveColor = UIColor.VNLBlue()
            textField.borderInactiveColor = UIColor.VNLBlue()

        }
        
        priceLabel.adjustsFontSizeToFitWidth = true
        priceView.layer.cornerRadius = priceView.frame.width / 2
        priceView.clipsToBounds = true
        priceView.layer.borderColor = UIColor.VNLGreen().CGColor
        priceView.layer.borderWidth = 8
            
    }
    
    func cancelButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func todayButtonTapped(){
        calendarView.scrollToDate(today)
    }
    
    
    func dismissPicker() {
        view.endEditing(true)
        updatePrices()
    }
    
    func updatePrices() {
        priceLabel.hidden = false
        currentPayment = 0
        currentPayment = datesCurrentlySelected.count * price
        priceLabel.text = ("R \(currentPayment)")
        priceLabel.textColor = UIColor.VNLGreen()
    }

}