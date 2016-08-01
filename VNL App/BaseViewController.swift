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
//        icon.imageInsets = UIEdgeInsetsMake(-10, 0, 0, 0)
        icon.tintColor = UIColor.whiteColor()
        navigationItem.leftBarButtonItem = icon
//        navigationController?.navigationBar.tintColor = UIColor.VNLBlue()
        navigationController?.navigationBar.opaque = false
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.backgroundColor = UIColor.VNLBlue()
        navigationController?.navigationBar.barTintColor = UIColor.VNLBlue()
        self.title = "Home"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }

}
