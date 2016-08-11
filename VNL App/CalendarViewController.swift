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

    @IBOutlet weak var startDateTextField: UIDatePickerTextField!
    @IBOutlet weak var endDateTextField: UIDatePickerTextField!
    @IBOutlet weak var todayButton: MKButton!
    @IBOutlet weak var cancelButton: MKButton!
    @IBOutlet weak var bookButton: MKButton!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    let today = NSDate.today()
    var datesUnavailable: [String] = []
    var datesBookedArray: [String] = []
    var datesCurrentlySelected: [String] = []
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
        

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        calendarView.scrollToDate(today)
        

    }
    
    /****** Set up Database Communication *****/
    
    
    
    @IBAction func bookButtonTapped() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        var startDate = formatter.dateFromString(startDateTextField.text!)
        let endDate = formatter.dateFromString(endDateTextField.text!)
        
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
        // You can set your date using NSDate() or NSDateFormatter. Your choice.
//        let firstDate = "1/1/2016".toDate(DateFormat.Custom("dd/MM/YY"))
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        let firstDate = formatter.dateFromString("JAN 01, 2016")
        let secondDate = NSDate().add(3)
        let aCalendar = NSCalendar.currentCalendar() // Properly configure your calendar to your time zone here
        
        return (startDate: firstDate!, endDate: secondDate, calendar: aCalendar)
    }

    
    func calendar(calendar: JTAppleCalendarView, isAboutToDisplayCell cell: JTAppleDayCellView, date: NSDate, cellState: CellState) {
        let cell = (cell as! CalendarViewCell)
        
        ref = FIRDatabase.database().reference().child("campsBay").child("bayHotel").child("rooms").child("\(AppState.sharedInstance.currRoomType)")
        
        self.ref.child("datesBooked").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            if snapshot.exists() {
                self.datesUnavailable = snapshot.value! as! [String]
            }
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        
    
        for date in datesUnavailable {
            if cellState.date == formatter.dateFromString(date) {
                print("\(cellState.date) +++++ \(formatter.dateFromString(date)) ")
                cell.bookedView.hidden = false
                cell.bookedView.backgroundColor = UIColor.VNLBlue()
                cell.dayLabel.textColor = UIColor.whiteColor()
                cell.bringSubviewToFront(cell.dayLabel)
                cell.userInteractionEnabled = false
            }
        }
        
        cell.setupCellBeforeDisplay(cellState, date: date)
        
    }
    
    func calendar(calendar: JTAppleCalendarView, didSelectDate date: NSDate, cell: JTAppleDayCellView?, cellState: CellState) {
        let cell = (cell as! CalendarViewCell)
        cell.selected = true
        cell.cellSelectionChanged(cellState)
    }
    
    func calendar(calendar: JTAppleCalendarView, didDeselectDate date: NSDate, cell: JTAppleDayCellView?, cellState: CellState) {
        let cell = (cell as! CalendarViewCell)
        cell.selected = true
        cell.cellSelectionChanged(cellState)
    }
    
    
    func calendar(calendar: JTAppleCalendarView, didScrollToDateSegmentStartingWithdate startDate: NSDate, endingWithDate endDate: NSDate) {
        configureCalendar(calendar)
        let monthName = startDate.monthName
        let year = startDate.year
        monthLabel.text = monthName
        yearLabel.text = "\(year)"
        
    }

}


extension CalendarViewController {
    
    func setAttributes() {
        
        let buttons = [cancelButton, bookButton, todayButton]
        
        for button in buttons {
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.rippleLayerColor = UIColor.whiteColor()
            button.backgroundColor = UIColor.VNLBlue()
            button.layer.cornerRadius = 4
        }
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), forControlEvents: .TouchUpInside)
        bookButton.setTitle("Book", forState: .Normal)
        todayButton.setTitle("Today", forState: .Normal)
        todayButton.addTarget(self, action: #selector(todayButtonTapped), forControlEvents: .TouchUpInside)
        
        let toolBar = UIToolbar().ToolbarPiker(#selector(dismissPicker))
        let textFields : [UIDatePickerTextField] = [startDateTextField, endDateTextField]
        
        for textField in textFields {
            textField.inputAccessoryView = toolBar
            textField.borderActiveColor = UIColor.VNLBlue()
            textField.borderInactiveColor = UIColor.VNLBlue()
        }
            
    }
    
    func cancelButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func todayButtonTapped(){
        calendarView.scrollToDate(today)
    }
    
    
    func dismissPicker() {
        view.endEditing(true)
    }

}