//
//  BookingViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/1/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import FirebaseDatabase


struct Booking {
    var bookings = [Booking]()
    let key: String?
    let date: String
    let type: String
    let itemRef: FIRDatabaseReference?
    
    init(date: String, type: String, key: String){
        self.key = key
        self.date = date
        self.type = type
        self.itemRef = nil
    }
    
    init(snapshot: FIRDataSnapshot){
        key = snapshot.key
        itemRef = snapshot.ref
        
        if let bookingType = snapshot.value!["type"] as? String {
            type = bookingType
        } else {
            type = ""
        }
        
        if let datesChosen = snapshot.value!["date"] as? String {
            date = datesChosen
        } else {
            date = ""
        }
    }
    
//    func toAnyObject() -> AnyObject {
////        return ["key": key, "date": date, "type": type]
//        
//    }
}

class BookingViewController: UIViewController {
    
    var dbref: FIRDatabaseReference!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbref = FIRDatabase.database().reference().child("bookings")
        dbref = dbref.child("camps_bay")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 88
        
        self.navigationItem.title = "Booking"        
        self.navigationController!.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        let bookingTableCell = UINib(nibName: "BookingTableViewCell", bundle: nil)
        tableView.registerNib(bookingTableCell, forCellReuseIdentifier: "bookingCell")
    }
    
//    func startObservingDB() {
//        dbref.observeEventType(.Value) { (snapshot: FIRDataSnapshot) in
//            var newBookings = [Booking]()
//            for booking in snapshot.children {
//                let bookingObject = Booking(snapshot: booking as! FIRDataSnapshot)
//                newBookings.append(bookingObject)
//            }
//            
//            self.bookings =
//        }) { (error: NSError) in
//            print(error.description)
//        }
//    }

    
    
    
    @IBAction func newBookingTapped() {
//        let booking = Booking(date: "12/2/01 - 12/15/01", type: "Suite")
    }
}

extension BookingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("bookingCell", forIndexPath: indexPath) as? BookingTableViewCell
        cell?.roomTitle.text = "Ocean Suite"
        cell?.roomSubTitle.text = "Camps Bay"
        cell?.imageView?.image = UIImage(named: "placeholder")

        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let caldendarViewController = CalendarViewController(nibName: "CalendarViewController", bundle: nil)
        self.showViewController(caldendarViewController, sender: self)
    }
    
}
