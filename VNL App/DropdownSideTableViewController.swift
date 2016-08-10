//
//  DropdownSideTableViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/5/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit


class DropdownSideTableViewController: UITableViewController {
    
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
        CollapsibleViewModel(label: "BOOKING", image: nil, children: [
            CollapsibleViewModel(label: "CAMPS BAY", childTag: -1)], childTag: 1),
        CollapsibleViewModel(label: "HOST PARTNERS", childTag: 0),
        CollapsibleViewModel(label: "CONTACT", childTag: 0),
        ]
    
    var displayedRows: [CollapsibleViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayedRows = data
        
        sideTableView.backgroundColor = UIColor.VNLDarkBlue()
        sideTableView.separatorColor = UIColor.blackColor()
        sideTableView.rowHeight = 88
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let sideMenu = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .Plain, target: self, action: #selector(sideMenuTapped))
        sideMenu.tintColor = UIColor.grayColor()
        self.navigationItem.leftBarButtonItem = sideMenu
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
        
        var iconView = UIImageView()
        iconView  = UIImageView(frame:CGRectMake(view.frame.width - 20, 20, 30, 30))
        iconView.tintColor = UIColor.whiteColor()
        iconView.image = UIImage(named: "dropDownIcon")
        
        cell.backgroundColor = UIColor.VNLDarkBlue()

        if cell.tag < 0 {
            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.textLabel?.textAlignment = .Left
            cell.textLabel?.font = UIFont(name: "Helvetica", size: 12.0)
            tableView.rowHeight = 44
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.VNLGreen()
            cell.selectedBackgroundView = bgColorView
        }
        else {
            tableView.rowHeight = 88
            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.textLabel?.textAlignment = .Center
            if cell.tag > 0 {
                cell.accessoryView = iconView
            }
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.VNLBlue()
            cell.selectedBackgroundView = bgColorView
        }
    
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let viewModel = displayedRows[indexPath.row]
        
        print("\(indexPath.row) +++++++ \(viewModel.label)")

        if viewModel.children.count > 0 {
            let range = indexPath.row+1...indexPath.row+viewModel.children.count
            let indexPaths = range.map{return NSIndexPath(forRow: $0, inSection: indexPath.section)}
            tableView.beginUpdates()
            if viewModel.isCollapsed {
                displayedRows.insertContentsOf(viewModel.children, at: indexPath.row+1)
                tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
            } else {
                displayedRows.removeRange(range)
                tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                tableView.rowHeight = 88
                tableView.deselectRowAtIndexPath(indexPath, animated: false)

            }
            tableView.endUpdates()
        }
        viewModel.isCollapsed = !viewModel.isCollapsed
        setAppState(indexPath)
        setSegue(indexPath)
        
    }

    func setSegue(indexPath: NSIndexPath) {
        let viewModel = displayedRows[indexPath.row]
        if viewModel.label == "Rates" {
            if indexPath.row == 0 {
                print("hermanus")
            }
            if indexPath.row == 1 {
                print("lagenbaum")
            }
        }
        
        if viewModel.label == "CAMPS BAY" && indexPath.row == 3 {
            let campsBayVC = CampsBayBookingViewController(nibName: "CampsBayBookingViewController", bundle: nil)
            let navVC = UINavigationController(rootViewController: campsBayVC)
            presentViewController(navVC, animated: true, completion: nil)
        }
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
            AppState.sharedInstance.screen = "contact"
        }
    }
    
}
