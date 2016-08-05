//
//  MemberSideViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/4/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit

class MemberSideViewController: UIViewController {

    @IBOutlet weak var sideTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideTableView.delegate = self
        sideTableView.dataSource = self
        self.view.backgroundColor = UIColor.VNLDarkBlue()
        sideTableView.separatorColor = UIColor.blackColor()
        sideTableView.backgroundColor = UIColor.VNLDarkBlue()
        sideTableView.rowHeight = 88
        sideTableView.registerNib(UINib(nibName: "MemberSideViewCell", bundle: nil), forCellReuseIdentifier: "memberSideCell")
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let sideMenu = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .Plain, target: self, action: #selector(sideMenuTapped))
        sideMenu.tintColor = UIColor.grayColor()
        self.navigationItem.leftBarButtonItem = sideMenu
        
        let profileMenu = UIBarButtonItem(image: UIImage(named: "profileIcon"), style: .Plain, target: self, action: #selector(profileIconTapped))
        profileMenu.tintColor = UIColor.grayColor()
        self.navigationItem.rightBarButtonItem = profileMenu
    }
    
    override func viewDidAppear(animated: Bool) {
        self.viewDidLoad()
        let cells = [0,1,2,3]
        for cell in cells {
            let defaultIndexPath: NSIndexPath = NSIndexPath(forRow: cell, inSection: 0)
            if AppState.sharedInstance.screen == "rates" && cell == 0 {
                sideTableView.selectRowAtIndexPath(defaultIndexPath, animated: true, scrollPosition: .None)
            } else if AppState.sharedInstance.screen == "exclusive" && cell == 1 {
                sideTableView.selectRowAtIndexPath(defaultIndexPath, animated: true, scrollPosition: .None)
            } else if AppState.sharedInstance.screen == "partners" && cell == 2 {
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


extension MemberSideViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4

    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = sideTableView.dequeueReusableCellWithIdentifier("memberSideCell", forIndexPath: indexPath) as? MemberSideViewCell
        
        cell?.cellLabel.textColor = UIColor.whiteColor()
        cell?.backgroundColor = UIColor.VNLDarkBlue()
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.VNLBlue()
        cell!.selectedBackgroundView = bgColorView
        
        switch (indexPath.row) {
        case 0:
            cell?.cellLabel.text = "RATES"
            break
        case 1:
            cell?.cellLabel.text = "EXCLUSIVE PACKAGES"
            break
        case 2:
            cell?.cellLabel.text = "HOST PARTNERS"
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

            AppState.sharedInstance.screen = "rates"
        }
        if indexPath.row == 1 {

            AppState.sharedInstance.screen = "exclusive"
        }
        if indexPath.row == 2 {

            AppState.sharedInstance.screen = "partners"
        }
        if indexPath.row == 3 {
            let contactVC = ContactViewController(nibName: "ContactViewController", bundle: nil)
            let navVC = UINavigationController(rootViewController: contactVC)
            self.presentViewController(navVC, animated: true, completion: nil)
            AppState.sharedInstance.screen = "contact"
        }
    }
}


