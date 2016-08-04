//
//  ProfileViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/4/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var sideTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        sideTableView.delegate = self
        sideTableView.dataSource = self
//        self.view.backgroundColor = UIColor.VNLDarkBlue()
//        sideTableView.separatorColor = UIColor.blackColor()
//        sideTableView.backgroundColor = UIColor.VNLDarkBlue()
        sideTableView.rowHeight = 88
        sideTableView.registerNib(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "profileCell")
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let sideMenu = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .Plain, target: self, action: #selector(sideMenuTapped))
        sideMenu.tintColor = UIColor.grayColor()
        self.navigationItem.leftBarButtonItem = sideMenu
        
        let profileMenu = UIBarButtonItem(image: UIImage(named: "profileIcon"), style: .Plain, target: self, action: #selector(profileIconTapped))
        profileMenu.tintColor = UIColor.grayColor()
        self.navigationItem.rightBarButtonItem = profileMenu
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = sideTableView.dequeueReusableCellWithIdentifier("profileCell", forIndexPath: indexPath) as? ProfileTableViewCell
        
        cell?.cellLabel.textColor = UIColor.blackColor()
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.VNLBlue()
        cell!.selectedBackgroundView = bgColorView
        
        switch (indexPath.row) {
        case 0:
            cell?.cellLabel.text = "PROFILE"
            break
        case 1:
            cell?.cellLabel.text = "RATES"
            break
        case 2:
            cell?.cellLabel.text = "EXCLUSIVE PACKAGES"
            break
        case 3:
            cell?.cellLabel.text = "HOST PARTNERS"
            break
        case 4:
            cell?.cellLabel.text = "CONTACT"
            break
        case 5:
            cell?.cellLabel.text = "LOGOUT"
            break
        default:
            break
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            
            AppState.sharedInstance.screen = "profile"
        }
        if indexPath.row == 1 {
            
            AppState.sharedInstance.screen = "rates"
        }
        if indexPath.row == 2 {
            AppState.sharedInstance.screen = "packages"
        }
        if indexPath.row == 3 {
            AppState.sharedInstance.screen = "partners"
        }
        if indexPath.row == 4 {
            let contactVC = ContactViewController(nibName: "ContactViewController", bundle: nil)
            let navVC = UINavigationController(rootViewController: contactVC)
            self.presentViewController(navVC, animated: true, completion: nil)
            AppState.sharedInstance.screen = "contact"
        }
        if indexPath.row == 5 {

            
            do {
                try! FIRAuth.auth()!.signOut()
                AppState.sharedInstance.signedIn = false
                // Set the view to the login screen after signing out
                let landingVC = LandingViewController(nibName: "LandingViewController", bundle: nil)
                let navVC = UINavigationController(rootViewController: landingVC)
                presentViewController(navVC, animated: true, completion: nil)
            } catch let signOutError as NSError {
                print ("Error signing out: \(signOutError)")
            }

        }
        
    }
}
