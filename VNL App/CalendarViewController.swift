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

class CalendarViewController: UIViewController {

    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    let today = NSDate.today()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendarView.dataSource = self
        self.calendarView.delegate = self
        self.calendarView.registerCellViewXib(fileName: "CalendarViewCell")
        calendarView.cellInset = CGPoint(x: 0, y: 0)
        calendarView.firstDayOfWeek = .Monday
        calendarView.allowsMultipleSelection = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        calendarView.scrollToDate(today)

    }

}


extension CalendarViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate  {
    // Setting up manditory protocol method
   
    
    func configureCalendar(calendar: JTAppleCalendarView) -> (startDate: NSDate, endDate: NSDate, numberOfRows: Int, calendar: NSCalendar) {
        // You can set your date using NSDate() or NSDateFormatter. Your choice.
//        let firstDate = "1/1/2016".toDate(DateFormat.Custom("dd/MM/YY"))
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let firstDate = formatter.dateFromString("2016 01 05")
        let secondDate = NSDate()
        let numberOfRows = 6
        let aCalendar = NSCalendar.currentCalendar() // Properly configure your calendar to your time zone here
        return (startDate: firstDate!, endDate: secondDate, numberOfRows: numberOfRows, calendar: aCalendar)
    }

    
    func calendar(calendar: JTAppleCalendarView, isAboutToDisplayCell cell: JTAppleDayCellView, date: NSDate, cellState: CellState) {
        let cell = (cell as! CalendarViewCell)
        
        cell.setupCellBeforeDisplay(cellState, date: date)
    }
    
    func calendar(calendar: JTAppleCalendarView, didDeselectDate date: NSDate, cell: JTAppleDayCellView?, cellState: CellState) {
        let cell = (cell as! CalendarViewCell)
        cell.cellSelectionChanged(cellState)
    }
    
    func calendar(calendar: JTAppleCalendarView, didScrollToDateSegmentStartingWithdate startDate: NSDate, endingWithDate endDate: NSDate) {
        let monthName = startDate.monthName
        let year = startDate.year
        monthLabel.text = monthName
        yearLabel.text = "\(year)"
    }
}
