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

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var topLabelBackground: UIView!
    @IBOutlet weak var sideTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        sideTableView.delegate = self
        sideTableView.dataSource = self
        sideTableView.rowHeight = 60
        sideTableView.frame.size.width = self.view.frame.width
        sideTableView.center.x = self.view.center.x
        sideTableView.registerNib(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        
        let sideMenu = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .Plain, target: self, action: #selector(sideMenuTapped))
        sideMenu.tintColor = UIColor.grayColor()
        self.navigationItem.leftBarButtonItem = sideMenu
        
        topLabelBackground.backgroundColor = UIColor.VNLGrey()
        userImage.layer.cornerRadius = userImage.frame.size.width / 2
        userImage.clipsToBounds = true
        
        welcomeLabel.text = "Welcome, \((FIRAuth.auth()?.currentUser?.displayName)!)"
        welcomeLabel.adjustsFontSizeToFitWidth = true
    }
    
    override func sideMenuTapped() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        view.window!.layer.addAnimation(transition, forKey: kCATransition)
        dismissViewControllerAnimated(false, completion: nil)

    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = sideTableView.dequeueReusableCellWithIdentifier("ProfileCell", forIndexPath: indexPath) as? ProfileCell
        
        cell?.cellLabel.textColor = UIColor.blackColor()
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.VNLGreen()
        cell!.selectedBackgroundView = bgColorView
        
        switch (indexPath.row) {
        case 0:
            cell?.cellLabel.text = "PROFILE"
            cell?.imageIcon.image = UIImage(named: "profileIcon")
            cell?.imageIcon.tintColor = UIColor.VNLGreen()
            cell?.imageIcon.contentMode = .ScaleAspectFit
            break
        case 1:
            cell?.cellLabel.text = "SETTINGS"
            cell?.imageIcon.image = UIImage(named: "IconSettings")
            cell?.imageIcon.tintColor = UIColor.VNLGreen()
            cell?.imageIcon.contentMode = .ScaleAspectFit
            break
        case 2:
            cell?.cellLabel.text = "LOGOUT"
            cell?.imageIcon.image = UIImage(named: "loginIcon")
            cell?.imageIcon.tintColor = UIColor.VNLGreen()
            cell?.imageIcon.contentMode = .ScaleAspectFit
            break
        default:
            break
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            let editUserVC = EditProfileViewController(nibName: "EditProfileViewController", bundle: nil)
            let navVC = UINavigationController(rootViewController: editUserVC)
            presentViewController(navVC, animated: true, completion: nil)
            
            AppState.sharedInstance.screen = "profile"
        }
        if indexPath.row == 1 {
            AppState.sharedInstance.screen = "settings"
            
            let settingsVC = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
            let navVC = UINavigationController(rootViewController: settingsVC)
            presentViewController(navVC, animated: true, completion: nil)
        }
        if indexPath.row == 2 {
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
