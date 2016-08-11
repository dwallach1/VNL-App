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
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        calendarView.scrollToDate(today)
    }

    
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
        
        self.ref.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            if snapshot.exists() {
                self.datesUnavailable = snapshot.value!["datesBooked"] as! [String]
            }
            self.price = snapshot.value!["price"] as! Int
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        
        
//        var i: Int = 0
//        for date in datesBookedArray {
//            if formatter.dateFromString(date) < today {
//                datesBookedArray.removeAtIndex(i)
//            }
//            i += 1
//        }

        
        print("got here before") /***********************/
       
        for date in datesUnavailable {
            
            print("got here") /***********************/
            
            if cellState.date == formatter.dateFromString(date) {
                
                print("\(cellState.date) +++++ \(formatter.dateFromString(date)) ") /***********************/
                
                cell.bookedView.hidden = false
                cell.bookedView.backgroundColor = UIColor.VNLDarkBlue()
                cell.dayLabel.textColor = UIColor.whiteColor()
                cell.bringSubviewToFront(cell.dayLabel)
                cell.userInteractionEnabled = false
                
                print("heck ya") /***********************/
            }
        }
        
        cell.setupCellBeforeDisplay(cellState, date: date)
        
    }
    
    func calendar(calendar: JTAppleCalendarView, didSelectDate date: NSDate, cell: JTAppleDayCellView?, cellState: CellState) {
        let cell = (cell as! CalendarViewCell)
        cell.cellSelectionChanged(cellState)
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        datesCurrentlySelected.append(formatter.stringFromDate(cellState.date))
        updatePrices()
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
        
        updatePrices()
    }
    
    
    func calendar(calendar: JTAppleCalendarView, didScrollToDateSegmentStartingWithdate startDate: NSDate, endingWithDate endDate: NSDate) {
        let monthName = startDate.monthName
        let year = startDate.year
        monthLabel.text = monthName
        yearLabel.text = "\(year)"
        viewDidLoad()
        
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
        currentPayment = 0
        currentPayment = datesCurrentlySelected.count * price
        priceLabel.text = ("R \(currentPayment)")
        priceLabel.textColor = UIColor.VNLGreen()
    }

}