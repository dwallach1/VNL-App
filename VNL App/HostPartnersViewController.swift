//
//  HostPartnersViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/16/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit

class HostPartnersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 176
        tableView.backgroundColor = UIColor(colorLiteralRed: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
        self.navigationItem.title = "Host Partners"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor()]
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .Plain, target: self, action: #selector(backButtonTapped))
        leftBarButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = leftBarButton


        let hostCell = UINib(nibName: "HostCell", bundle: nil)
        tableView.registerNib(hostCell, forCellReuseIdentifier: "hostCell")
    
    }

    func backButtonTapped() {
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let navVC = UINavigationController(rootViewController: homeVC)
        presentViewController(navVC, animated: true, completion: nil)
    }

}


extension HostPartnersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("hostCell", forIndexPath: indexPath) as? HostCell
        
        switch (indexPath.row){
        case 0:
            cell?.backgroundImage?.image = UIImage(named: "cbr-sml")
            break
        case 1:
            cell?.backgroundImage?.image = UIImage(named: "cbvillage-sml")
            break
            
        case 2:
            cell?.backgroundImage?.image = UIImage(named: "dwv-sml")
            break
        case 3:
            cell?.backgroundImage?.image = UIImage(named: "farmhouse")
            break
        case 4:
            cell?.backgroundImage?.image = UIImage(named: "hhh-sml")
            break
        case 5:
            cell?.backgroundImage?.image = UIImage(named: "mint-wellness-sml")
            break
        case 6:
            cell?.backgroundImage?.image = UIImage(named: "mpv-sml")
            break
        case 7:
            cell?.backgroundImage?.image = UIImage(named: "panorama-sml")
            break
        case 8:
            cell?.backgroundImage?.image = UIImage(named: "selkirks-sml")
            break
        case 9:
            cell?.backgroundImage?.image = UIImage(named: "tapas-sml")
            break
        case 10:
            cell?.backgroundImage?.image = UIImage(named: "tbh-1_300_1")
            break
        case 11:
            cell?.backgroundImage?.image = UIImage(named: "thegallery-sml")
            break
        case 12:
            cell?.backgroundImage?.image = UIImage(named: "tides-sml")
            break
        case 13:
            cell?.backgroundImage?.image = UIImage(named: "traders-sml")
            break
        case 14:
            cell?.backgroundImage?.image = UIImage(named: "von-kampz-sml")
            break
        case 15:
            cell?.backgroundImage?.image = UIImage(named: "wfv-sml")
            break
        default:
            return cell!
        }
        
        cell?.backgroundImage.contentMode = .ScaleAspectFit
        return cell!
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //do nothing
        return
        
    }
    
}