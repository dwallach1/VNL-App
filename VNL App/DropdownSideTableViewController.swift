//
//  DropdownSideTableViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/5/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit


class DropdownSideTableViewController: UITableViewController {
    
    var childStatus = false // false is closed, true is open
    var parentStatus = false //false is closed, true is open
    
    @IBOutlet var sideTableView: UITableView!
    
    let data = [
        CollapsibleViewModel(label: "RATES", image: nil, children: [
            CollapsibleViewModel(label: "HERMANUS", childTag: -1),
            CollapsibleViewModel(label: "LANGEBAAN", childTag: -1),
            CollapsibleViewModel(label: "CAMPS BAY", childTag: -1),
            CollapsibleViewModel(label: "DE WATERKANT", childTag: -1),
            CollapsibleViewModel(label: "MOUILLE POINT", childTag: -1),
            CollapsibleViewModel(label: "V&A WATERFRONT", childTag: -1)], childTag: 6),
        CollapsibleViewModel(label: "EXCLUSIVE PACKAGES", image: nil, children: [
            CollapsibleViewModel(label: "HERMANUS PACKAGES", childTag: -1),
            CollapsibleViewModel(label: "LANGEBAAN PACKAGES", childTag: -1),
            CollapsibleViewModel(label: "CAPE TOWN PACKAGES", childTag: -1)], childTag: 3),
        CollapsibleViewModel(label: "BOOKING", childTag: 0),
        CollapsibleViewModel(label: "HOST PARTNERS", childTag: 0),
        CollapsibleViewModel(label: "CONTACT", childTag: 0),
        ]
    
    var displayedRows: [CollapsibleViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayedRows = data
        
        sideTableView.backgroundColor = UIColor.VNLDarkBlue()
        sideTableView.separatorColor = UIColor.blackColor()
        sideTableView.backgroundColor = UIColor.VNLDarkBlue()
        sideTableView.rowHeight = 88
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let sideMenu = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .Plain, target: self, action: #selector(sideMenuTapped))
        sideMenu.tintColor = UIColor.grayColor()
        self.navigationItem.leftBarButtonItem = sideMenu
        
        let profileMenu = UIBarButtonItem(image: UIImage(named: "profileIcon"), style: .Plain, target: self, action: #selector(profileIconTapped))
        profileMenu.tintColor = UIColor.grayColor()
        self.navigationItem.rightBarButtonItem = profileMenu
        
    }
    
    override func viewDidAppear(animated: Bool) {
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


extension DropdownSideTableViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedRows.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCellWithIdentifier("CollapsibleTableViewCell") as? CollapsibleTableViewCell) ?? CollapsibleTableViewCell(style: .Default, reuseIdentifier: "CollapsibleTableViewCell")
        

        cell.configure(displayedRows[indexPath.row])
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.VNLBlue()
        cell.selectedBackgroundView = bgColorView
        cell.backgroundColor = UIColor.VNLDarkBlue()
        
        let iconView = UIImageView()
        iconView.frame.origin.x = cell.frame.origin.x + 20
        iconView.frame.origin.y = cell.frame.origin.y
        iconView.image = UIImage(named: "dropDownIcon")
        cell.addSubview(iconView)
        
        let dropDownButton = UIButton()
        dropDownButton.backgroundColor = UIColor.clearColor()
        dropDownButton.frame = cell.frame
        dropDownButton.addTarget(self, action: #selector(dropDownIconTapped), forControlEvents: .TouchUpInside)
        cell.addSubview(dropDownButton)
        cell.bringSubviewToFront(dropDownButton)
        
        if cell.tag < 0 {
            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.textLabel?.textAlignment = .Left
            tableView.rowHeight = 44
        }
        else {
            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.textLabel?.textAlignment = .Center
        }
        
        if cell.tag > 0 {
            cell.addButton()
        }
        
        let viewModel = displayedRows[indexPath.row]
        if viewModel.children.count > 0 {
            cell.backgroundColor = UIColor.VNLDarkBlue()
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let viewModel = displayedRows[indexPath.row]
        if viewModel.children.count > 0 {
            let range = indexPath.row+1...indexPath.row+viewModel.children.count
            let indexPaths = range.map{return NSIndexPath(forRow: $0, inSection: indexPath.section)}
            tableView.beginUpdates()
            if viewModel.isCollapsed {
                childStatus = true
                displayedRows.insertContentsOf(viewModel.children, at: indexPath.row+1)
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            } else {
                childStatus = false
                tableView.rowHeight = 88
                displayedRows.removeRange(range)
                tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            }
            tableView.endUpdates()
        }
        viewModel.isCollapsed = !viewModel.isCollapsed
        setAppState(indexPath)
    }

    
    func setAppState(indexPath: NSIndexPath) {
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
//            let contactVC = ContactViewController(nibName: "ContactViewController", bundle: nil)
//            let navVC = UINavigationController(rootViewController: contactVC)
//            self.presentViewController(navVC, animated: true, completion: nil)
            AppState.sharedInstance.screen = "contact"
        }
    }
    
    func dropDownIconTapped() {
        print("hit here")
    }
}
