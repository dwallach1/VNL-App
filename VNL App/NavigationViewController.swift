//
//  NavigationViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/1/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import MediumMenu
import Firebase

class NavigationViewController: UINavigationController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var menu: MediumMenu?

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        let item1 = MediumMenuItem(title: "Home") {
            let homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
            self.navigationController!.setViewControllers([homeViewController], animated: false)
        }
        
        let item2 = MediumMenuItem(title: "Settings") {
            let settingsTableViewController = SettingsTableViewController(nibName: "SettingsTableViewController", bundle: nil)
            self.navigationController!.setViewControllers([settingsTableViewController], animated: false)
        }
        
        let item3 = MediumMenuItem(title: "Logout") {
            //            let landingViewController = LandingViewController(nibname: "LandingViewController", bundle: nil)
            //            self.setViewControllers([landingViewController], animated: false)
            
            let firebaseAuth = FIRAuth.auth()
            do {
                try firebaseAuth?.signOut()
                AppState.sharedInstance.signedIn = false
                let landingViewController = LandingViewController(nibName: "LandingViewController", bundle: nil)
                self.navigationController!.setViewControllers([landingViewController], animated: false)
            } catch let signOutError as NSError {
                print ("Error signing out: \(signOutError)")
            }
        }
        
        menu = MediumMenu(items: [item1, item2, item3], forViewController: self)
    }
    
    func showMenu() {
        menu?.show()
    }
}
    




