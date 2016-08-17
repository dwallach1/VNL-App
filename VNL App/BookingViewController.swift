//
//  BookingViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/1/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import NYAlertViewController
import SwiftSpinner
import FirebaseDatabase

class BookingViewController: UIViewController {
    
    var tableView = UITableView()
    var locations: [LocationModel] = []
    var currLocation: Int = 0
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.frame = self.view.frame
        self.view.addSubview(tableView)
        self.view.bringSubviewToFront(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 176
        
        self.view.backgroundColor = UIColor.VNLDarkBlue()
        self.title = ("\(AppState.sharedInstance.bookingLocationTitle)")
        
        self.navigationItem.title = AppState.sharedInstance.bookingLocationTitle
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor()]
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .Plain, target: self, action: #selector(backButtonTapped))
        leftBarButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let locationCell = UINib(nibName: "LocationCell", bundle: nil)
        tableView.registerNib(locationCell, forCellReuseIdentifier: "locationCell")
        currLocation = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        SwiftSpinner.show("Loading Requested Locations...")
        connectToDB()
    }
    
    func backButtonTapped() {
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let navVC = UINavigationController(rootViewController: homeVC)
        presentViewController(navVC, animated: true, completion: nil)
    }
    
    func connectToDB() {
        ref = FIRDatabase.database().reference().child("booking").child("\(AppState.sharedInstance.bookingLocationJSON)")
        self.ref.observeEventType(.Value, withBlock: { (snapshot) in
            
            for child in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let childSnapshot = snapshot.childSnapshotForPath(child.key)
                let title = childSnapshot.value!["title"] as! String
                let locationJSON = childSnapshot.key
                let newLocation = LocationModel(title: title, locationJSON: locationJSON)
                self.locations.append(newLocation)
            }
            
            self.tableView.reloadData()
            SwiftSpinner.hide()
            
        }) { (error) in
            print(error.localizedDescription)
        }


    }
}

extension BookingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath) as? LocationCell
        
        
        cell?.titleLabel.text = locations[indexPath.row].title

        
        //this is hard coded now but should be deleted when we learn to encode images, we will then be able
        //to download the corresponding image 
        switch (indexPath.row){
        case 0:
            cell?.backgroundImage?.image = UIImage(named: "campsbay1")
            break
        case 1:
            cell?.backgroundImage?.image = UIImage(named: "campsbay2")
            break
        case 2:
            cell?.backgroundImage?.image = UIImage(named: "campsbay3")
            break
        case 3:
            cell?.backgroundImage?.image = UIImage(named: "campsbay1")
            break
        case 4:
            cell?.backgroundImage?.image = UIImage(named: "campsbay3")
            break
        case 5:
            cell?.backgroundImage?.image = UIImage(named: "campsbay2")
            break
        case 6:
            cell?.backgroundImage?.image = UIImage(named: "campsbay1")
            break
        default:
            return cell!
            
        }
        return cell!
    }
    


    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            let propertyVC = PropertyViewController(nibName: "PropertyViewController", bundle: nil)
            let navVC = UINavigationController(rootViewController: propertyVC)
            presentViewController(navVC, animated: true, completion: nil)
        } else {
            let alertViewController = NYAlertViewController()
            
            // Set a title and message
            alertViewController.title = "Functionality Coming Soon"
            alertViewController.message = "We're just adding some finishing touches."
            
            // Customize appearance as desired
            alertViewController.buttonCornerRadius = 20.0
            alertViewController.view.tintColor = self.view.tintColor
            
            alertViewController.titleFont = UIFont(name: "AvenirNext-Bold", size: 19.0)
            alertViewController.messageFont = UIFont(name: "AvenirNext-Medium", size: 16.0)
            alertViewController.cancelButtonTitleFont = UIFont(name: "AvenirNext-Medium", size: 16.0)
            alertViewController.cancelButtonTitleFont = UIFont(name: "AvenirNext-Medium", size: 16.0)
            alertViewController.buttonColor = UIColor.VNLBlue()
            
            alertViewController.swipeDismissalGestureEnabled = true
            alertViewController.backgroundTapDismissalGestureEnabled = true
            
            // Add alert actions
            let cancelAction = NYAlertAction(
                title: "Dismiss",
                style: .Cancel,
                handler: { (action: NYAlertAction!) -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            )
            alertViewController.addAction(cancelAction)
            
            // Present the alert view controller
            self.presentViewController(alertViewController, animated: true, completion: nil)
        }
        
        AppState.sharedInstance.property = locations[indexPath.row].title
        AppState.sharedInstance.propertyTitleJSON = locations[indexPath.row].locationJSON
        print("\(AppState.sharedInstance.property) &&&&&&&&&&&&& \(AppState.sharedInstance.propertyTitleJSON)")
    }
    
}
