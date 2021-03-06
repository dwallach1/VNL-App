//
//  SideMenuViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/4/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    @IBOutlet weak var sideTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideTableView.delegate = self
        sideTableView.dataSource = self
        self.view.backgroundColor = UIColor.VNLDarkBlue()
        sideTableView.separatorColor = UIColor.blackColor()
        sideTableView.backgroundColor = UIColor.VNLDarkBlue()
        sideTableView.rowHeight = 88
        sideTableView.registerNib(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "sideCell")
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let sideMenu = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .Plain, target: self, action: #selector(sideMenuTapped))
        sideMenu.tintColor = UIColor.grayColor()
        self.navigationItem.leftBarButtonItem = sideMenu
        
        let loginMenu = UIBarButtonItem(image: UIImage(named: "loginIcon"), style: .Plain, target: self, action: #selector(loginIconTapped))
        loginMenu.tintColor = UIColor.grayColor()
        self.navigationItem.rightBarButtonItem = loginMenu
    }
    
    override func viewDidAppear(animated: Bool) {
        self.viewDidLoad()
        let cells = [0,1,2,3]
        for cell in cells {
            let defaultIndexPath: NSIndexPath = NSIndexPath(forRow: cell, inSection: 0)
            if AppState.sharedInstance.screen == "home" && cell == 0 {
                sideTableView.selectRowAtIndexPath(defaultIndexPath, animated: true, scrollPosition: .None)
            } else if AppState.sharedInstance.screen == "benefits" && cell == 1 {
                sideTableView.selectRowAtIndexPath(defaultIndexPath, animated: true, scrollPosition: .None)
            } else if AppState.sharedInstance.screen == "information" && cell == 2 {
                sideTableView.selectRowAtIndexPath(defaultIndexPath, animated: true, scrollPosition: .None)
            } else if AppState.sharedInstance.screen == "contact" && cell == 3 {
                sideTableView.selectRowAtIndexPath(defaultIndexPath, animated: true, scrollPosition: .None)
            }
        }
    }
    
    override func sideMenuTapped() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        view.window!.layer.addAnimation(transition, forKey: kCATransition)
        dismissViewControllerAnimated(false, completion: nil)
    }
}


extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = sideTableView.dequeueReusableCellWithIdentifier("sideCell", forIndexPath: indexPath) as? SideMenuTableViewCell

        cell?.cellLabel.textColor = UIColor.whiteColor()
        cell?.backgroundColor = UIColor.VNLDarkBlue()
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.VNLBlue()
        cell!.selectedBackgroundView = bgColorView

        switch (indexPath.row) {
        case 0:
            cell?.cellLabel.text = "HOME"
            break
        case 1:
            cell?.cellLabel.text = "BENEFITS"
            break
        case 2:
            cell?.cellLabel.text = "HOW DOES IT WORK"
            break
        case 3:
            cell?.cellLabel.text = "CONTACT"
            break
        default:
            break
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if indexPath.row == 0 {
            let landingVC = LandingViewController(nibName: "LandingViewController", bundle: nil)
            let navVC = UINavigationController(rootViewController: landingVC)
            self.presentViewController(navVC, animated: true, completion: nil)
            AppState.sharedInstance.screen = "home"
        }
        if indexPath.row == 1 {
            let benefitsVC = BenefitsViewController(nibName: "BenefitsViewController", bundle: nil)
            let navVC = UINavigationController(rootViewController: benefitsVC)
            self.presentViewController(navVC, animated: true, completion: nil)
            AppState.sharedInstance.screen = "benefits"
        }
        if indexPath.row == 2 {
            let informationVC = InformationViewController(nibName: "InformationViewController", bundle: nil)
            let navVC = UINavigationController(rootViewController: informationVC)
            self.presentViewController(navVC, animated: true, completion: nil)
            AppState.sharedInstance.screen = "information"
        }
        if indexPath.row == 3 {
            let contactVC = ContactViewController(nibName: "ContactViewController", bundle: nil)
            let navVC = UINavigationController(rootViewController: contactVC)
            self.presentViewController(navVC, animated: true, completion: nil)
            AppState.sharedInstance.screen = "contact"
        }
        
    }
}
