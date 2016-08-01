//
//  BaseViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/1/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let icon = UIBarButtonItem(image: UIImage(named: "sideMenuIcon"), style: .Plain, target: navigationController, action: #selector(NavigationViewController.showMenu))
        icon.tintColor = UIColor.whiteColor()
        navigationItem.leftBarButtonItem = icon
        navigationController?.navigationBar.barTintColor = UIColor.VNLBlue()
        self.title = AppState.sharedInstance.screen
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }

}
