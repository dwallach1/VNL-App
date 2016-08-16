//
//  DropdownSideTableViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/5/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import NYAlertViewController

class DropdownSideTableViewController: UITableViewController {
    
    @IBOutlet var sideTableView: UITableView!
    
    let data = [
        CollapsibleViewModel(label: "RATES", image: nil, children: [
            CollapsibleViewModel(label: "HERMANUS", childTag: -1),
            CollapsibleViewModel(label: "CAMPS BAY", childTag: -1),
            CollapsibleViewModel(label: "LANGEBAAN", childTag: -1),
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
        let cells = [0,1,2,3,4]
        for cell in cells {
            let defaultIndexPath: NSIndexPath = NSIndexPath(forRow: cell, inSection: 0)
            if AppState.sharedInstance.screen == "rates" && cell == 0 {
                sideTableView.selectRowAtIndexPath(defaultIndexPath, animated: true, scrollPosition: .None)
            } else if AppState.sharedInstance.screen == "exclusive" && cell == 1 {
                sideTableView.selectRowAtIndexPath(defaultIndexPath, animated: true, scrollPosition: .None)
            } else if AppState.sharedInstance.screen == "booking" && cell == 2 {
                sideTableView.selectRowAtIndexPath(defaultIndexPath, animated: true, scrollPosition: .None)
            }  else if AppState.sharedInstance.screen == "partners" && cell == 3 {
                sideTableView.selectRowAtIndexPath(defaultIndexPath, animated: true, scrollPosition: .None)
            } else if AppState.sharedInstance.screen == "contact" && cell == 4 {
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
        print(indexPath.row)
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
        setSegue(indexPath)
        
    }

    func setSegue(indexPath: NSIndexPath) {
        let viewModel = displayedRows[indexPath.row]

        if viewModel.label == "CAMPS BAY" && indexPath.row == 3 || viewModel.label == "CAMPS BAY" && indexPath.row == 6 || viewModel.label == "CAMPS BAY" && indexPath.row == 12 || viewModel.label == "CAMPS BAY" && indexPath.row == 9{
            let campsBayVC = CampsBayBookingViewController()
            let navVC = UINavigationController(rootViewController: campsBayVC)
            presentViewController(navVC, animated: true, completion: nil)
            AppState.sharedInstance.screen = "booking"
        }
        
        else if viewModel.label == "CONTACT" && indexPath.row == 4 {
            let contactVC = ContactViewController(nibName: "ContactViewController", bundle: nil)
            let navVC = UINavigationController(rootViewController: contactVC)
            presentViewController(navVC, animated: true, completion: nil)
            AppState.sharedInstance.screen = "contact"
        }
        else if viewModel.label == "HOST PARTNERS" && indexPath.row == 3 || viewModel.label == "HOST PARTNERS" && indexPath.row == 9 || viewModel.label == "HOST PARTNERS" && indexPath.row == 12 || viewModel.label == "HOST PARTNERS" && indexPath.row == 13 {
            let hostVC = HostPartnersViewController(nibName: "HostPartnersViewController", bundle: nil)
            let navVC = UINavigationController(rootViewController: hostVC)
            presentViewController(navVC, animated: true, completion: nil)
            AppState.sharedInstance.screen = "partners"
        }
        else if viewModel.label == "HERMANUS PACKAGES" && indexPath.row == 2 || viewModel.label == "HERMANUS PACKAGES" && indexPath.row == 8 {
            let hermanusPackagesVC = HermanusPackageViewController(nibName: "HermanusPackageViewController", bundle: nil)
            let navVC = UINavigationController(rootViewController: hermanusPackagesVC)
            presentViewController(navVC, animated: true, completion: nil)
            AppState.sharedInstance.screen = "exclusive"
            AppState.sharedInstance.packageLocation = "hermanus"
        } else {
            if viewModel.label != "RATES" && viewModel.label != "EXCLUSIVE PACKAGES" && viewModel.label != "BOOKING" {
                callAlert()
            }
        }
        
    }
    
    
}


extension DropdownSideTableViewController {
    func callAlert() {
        let alertViewController = NYAlertViewController()
        
        // Set a title and message
        alertViewController.title = "Functionality Coming Soon"
        alertViewController.message = "We're just adding some finishing touches."
        
        // Customize appearance as desired
        alertViewController.buttonCornerRadius = 20.0
        alertViewController.view.tintColor = self.view.tintColor
        
        alertViewController.titleFont = UIFont(name: "AvenirNext-Bold", size: 19.0)
        alertViewController.messageFont = UIFont(name: "AvenirNext-Medium", size: 16.0)
        alertViewController.cancelButtonTitleFont = UIFont(name: "AvenirNext-Medium", size: 16.0)
        alertViewController.cancelButtonTitleFont = UIFont(name: "AvenirNext-Medium", size: 16.0)
        alertViewController.buttonColor = UIColor.VNLBlue()
        
        alertViewController.swipeDismissalGestureEnabled = true
        alertViewController.backgroundTapDismissalGestureEnabled = true
        
        // Add alert actions
        let cancelAction = NYAlertAction(
            title: "Dismiss",
            style: .Cancel,
            handler: { (action: NYAlertAction!) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        )
        alertViewController.addAction(cancelAction)
        
        // Present the alert view controller
        self.presentViewController(alertViewController, animated: true, completion: nil)
    }
}