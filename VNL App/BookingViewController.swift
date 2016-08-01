//
//  BookingViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/1/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 88
        
        self.navigationItem.title = "Booking"        
        self.navigationController!.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        let bookingTableCell = UINib(nibName: "BookingTableViewCell", bundle: nil)
        tableView.registerNib(bookingTableCell, forCellReuseIdentifier: "bookingCell")
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
        cell?.imageView?.image = UIImage(named: "beach")
        
        return cell!
    }
    
}
