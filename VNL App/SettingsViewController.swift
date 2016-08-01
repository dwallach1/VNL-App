//
//  SettingsViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/1/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        AppState.sharedInstance.screen = "Settings"
        
        let settingsTableViewCell = UINib(nibName: "SettingsTableViewCell", bundle: nil)
        tableView.registerNib(settingsTableViewCell, forCellReuseIdentifier: "settingCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("settingCell", forIndexPath: indexPath) as? SettingsTableViewCell
        
        cell?.textLabel?.text = "Hello"
        
        return cell!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
            case 0:
                return 3
            case 1:
                return 1
            default:
                return 2
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Profile"
        case 1:
            return "Payment"
        default:
            return "Preferences"
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

