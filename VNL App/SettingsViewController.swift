//
//  SettingsViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/1/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppState.sharedInstance.screen = "Settings"
        
        let settingsTableViewCell = UINib(nibName: "SettingsTableViewCell", bundle: nil)
        tableView.registerNib(settingsTableViewCell, forCellReuseIdentifier: "settingCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let sideMenu = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .Plain, target: self, action: #selector(dismissView))
        sideMenu.tintColor = UIColor.grayColor()
        self.navigationItem.leftBarButtonItem = sideMenu
    }
}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("settingCell", forIndexPath: indexPath) as? SettingsTableViewCell
        
        let section = indexPath.section
        switch section {
            case 0:
                if indexPath.row == 0 {
                    cell?.titleLabel?.text = "Allow Push Notifications"
                    cell?.pushSwitch.hidden = false
                }
                if indexPath.row == 1 {
                    cell?.titleLabel?.text = "Join Our Email List"
                }
                return cell!
            case 1:
                cell?.titleLabel?.text = "Add or Update Credit Card"
                return cell!
            case 2:

                if indexPath.row == 0 {
                    cell?.titleLabel?.text = "Change Password"
                }
                else if indexPath.row == 1 {
                    cell?.titleLabel?.text = "Update Hotel Prefrences"
                }
                else if indexPath.row == 2 {
                    cell?.titleLabel?.text = "Delete Account"
                    cell?.titleLabel?.textColor = UIColor.VNLRed()
                }
                return cell!

            default:
                return cell!
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
            case 0:
                return 2
            case 1:
                return 1
            default:
                return 3
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Preferences"
        case 1:
            return "Payment"
        default:
            return "Profile"
        }
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
            case 0:
                return ""
            case 1:
                return "This is to upadate your credit card information to be able to book through our app"
            default:
                return ""
        }
    }
    
}

