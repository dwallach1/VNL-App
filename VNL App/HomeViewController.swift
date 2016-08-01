//
//  HomeViewController.swift
//  VNL App
//
//  Created by David Wallach on 7/29/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import Firebase
import MediumMenu

class HomeViewController: BaseViewController {
    
//    var sideMenuButton = UIBarButtonItem()
    
//    var menu: MediumMenu?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.VNLDarkBlue()

    }
//        super.viewDidLoad()
//        self.title = "Welcome"
//        self.view.backgroundColor = UIColor.VNLDarkBlue()
//        
//        sideMenuButton = UIBarButtonItem(image: UIImage(named: "sideMenuIcon"), style: .Plain, target: self, action: #selector(showMenu))
//        sideMenuButton.tintColor = UIColor.VNLBlue()
//        self.navigationItem.leftBarButtonItem = sideMenuButton
//        
//        self.navigationController?.navigationBar.sizeThatFits(CGSizeMake(UIScreen.mainScreen().bounds.size.width, 60))
//        
//        let homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
//        self.navigationController!.setViewControllers([homeViewController], animated: false)
//        
//        let item1 = MediumMenuItem(title: "Home") {
//            let homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
//            self.navigationController!.setViewControllers([homeViewController], animated: false)
//        }
//        
//        let item2 = MediumMenuItem(title: "Settings") {
//            let settingsTableViewController = SettingsTableViewController(nibName: "SettingsTableViewController", bundle: nil)
//            self.navigationController!.setViewControllers([settingsTableViewController], animated: false)
//        }
//        
//        let item3 = MediumMenuItem(title: "Logout") {
//            //            let landingViewController = LandingViewController(nibname: "LandingViewController", bundle: nil)
//            //            self.setViewControllers([landingViewController], animated: false)
//            
//            let firebaseAuth = FIRAuth.auth()
//            do {
//                try firebaseAuth?.signOut()
//                AppState.sharedInstance.signedIn = false
//                let landingViewController = LandingViewController(nibName: "LandingViewController", bundle: nil)
//                self.navigationController!.setViewControllers([landingViewController], animated: false)
//            } catch let signOutError as NSError {
//                print ("Error signing out: \(signOutError)")
//            }
//        }
//        
//        menu = MediumMenu(items: [item1, item2, item3], forViewController: self.navigationController!)
//        menu!.textColor = UIColor.VNLBlue()
//        menu!.backgroundColor = UIColor.VNLDarkBlue()
//        menu!.highlightTextColor = UIColor.whiteColor()
//        menu!.titleAlignment = .Center
//    }
//
//    func showMenu() {
//        menu?.show()
//    }
    
    @IBAction func signOut(sender: UIButton) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            AppState.sharedInstance.signedIn = false
            presentViewController(LandingViewController(nibName: "LandingViewController", bundle: nil), animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError)")
        }
    }

    
}


