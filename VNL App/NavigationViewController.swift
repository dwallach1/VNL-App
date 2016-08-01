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
    
    var menu: MediumMenu?

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.navigationBar.tintColor = UIColor.VNLDarkBlue()
        self.navigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 400)
        
        let homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        setViewControllers([homeViewController], animated: false)
        
        let item1 = MediumMenuItem(title: "Home") {
            let homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
            self.setViewControllers([homeViewController], animated: false)
        }
        
        let item2 = MediumMenuItem(title: "Settings") {
            let settingsViewController = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
            self.setViewControllers([settingsViewController], animated: false)
            AppState.sharedInstance.screen = "Settings"

        }
        
        let item3 = MediumMenuItem(title: "Logout") {            
            let firebaseAuth = FIRAuth.auth()
            do {
                try firebaseAuth?.signOut()
                AppState.sharedInstance.signedIn = false
                let landingViewController = LandingViewController(nibName: "LandingViewController", bundle: nil)
//                self.setViewControllers([landingViewController], animated: false)
                self.presentViewController(landingViewController, animated: true, completion: nil)
            } catch let signOutError as NSError {
                print ("Error signing out: \(signOutError)")
            }
        }
        
        menu = MediumMenu(items: [item1, item2, item3], forViewController: self)
        menu!.textColor = UIColor.VNLBlue()
        menu!.backgroundColor = UIColor.VNLDarkBlue()
        menu!.highlightTextColor = UIColor.whiteColor()
        menu!.titleAlignment = .Center
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.viewDidLoad()
    }
    
    func showMenu() {
        menu?.show()
    }
}
    




