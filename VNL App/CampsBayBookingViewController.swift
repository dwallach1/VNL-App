//
//  BookingViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/1/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CampsBayBookingViewController: UIViewController {
    
    var dbref: FIRDatabaseReference!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        FIRDatabase.database().persistenceEnabled = true
        
        dbref = FIRDatabase.database().reference().child("bookings")
        dbref = dbref.child("camps_bay")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 176
        
        self.view.backgroundColor = UIColor.VNLDarkBlue()
        
        self.navigationItem.title = "Camps Bay"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor()]
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .Plain, target: self, action: #selector(backButtonTapped))
        leftBarButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let campsBayCell = UINib(nibName: "CampsBayTableViewCell", bundle: nil)
        tableView.registerNib(campsBayCell, forCellReuseIdentifier: "campsBayCell")
    }
    
    func backButtonTapped() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
        view.window!.layer.addAnimation(transition, forKey: kCATransition)
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let navVC = UINavigationController(rootViewController: homeVC)
        presentViewController(navVC, animated: true, completion: nil)
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
}

extension CampsBayBookingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("campsBayCell", forIndexPath: indexPath) as? CampsBayTableViewCell
        
        switch (indexPath.row){
        case 0:
            cell?.titleLabel.text = "The Bay Hotel"
            cell?.backgroundImage?.image = UIImage(named: "campsbay1")
            break
        case 1:
            cell?.titleLabel.text = "Camps Bay Retreat"
            cell?.backgroundImage?.image = UIImage(named: "campsbay2")
            break
            
        case 2:
            cell?.titleLabel.text = "The Glen Apartments"
            cell?.backgroundImage?.image = UIImage(named: "campsbay3")
            break
        case 3:
            cell?.titleLabel.text = "The Crystal Apartments"
            cell?.backgroundImage?.image = UIImage(named: "campsbay1")
            break
        case 4:
            cell?.titleLabel.text = "Park Studios"
            cell?.backgroundImage?.image = UIImage(named: "campsbay3")
            break
        case 5:
            cell?.titleLabel.text = "Totness"
            cell?.backgroundImage?.image = UIImage(named: "campsbay2")
            break
        case 6:
            cell?.titleLabel.text = "Wescamp"
            cell?.backgroundImage?.image = UIImage(named: "campsbay1")
            break
        default:
            return cell!
            
        }
        return cell!
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let bayHotelVC = BayHotelViewController(nibName: "BayHotelViewController", bundle: nil)
            let navVC = UINavigationController(rootViewController: bayHotelVC)
            presentViewController(navVC, animated: true, completion: nil)
        } else {
            let caldendarViewController = CalendarViewController(nibName: "CalendarViewController", bundle: nil)
            self.showViewController(caldendarViewController, sender: self)

        }
    }
    
}
