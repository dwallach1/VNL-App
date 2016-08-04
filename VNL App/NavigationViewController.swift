//
//  NavigationViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/1/16.
//  Copyright © 2016 TCA. All rights reserved.
//
//
//import UIKit
//import Firebase
//
//class NavigationViewController: UINavigationController {
//    
//    var sideMenu = UIBarButtonItem()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.navigationBar.barTintColor = UIColor.whiteColor()
//        sideMenu = UIBarButtonItem(image: UIImage(named: "sideMenuIcon"), style: .Plain, target: self, action: #selector(sideMenuTapped))
//        sideMenu.tintColor = UIColor.grayColor()
//        navigationItem.leftBarButtonItem = sideMenu
//    
//        let landingVC = LandingViewController(nibName: "LandingViewController", bundle: nil)
//        setViewControllers([landingVC], animated: false)
//        
//    }
//    
//    override func viewDidAppear(animated: Bool) {
//        self.viewDidLoad()
//       
//    }
//    
//    func sideMenuTapped() {
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.type = kCATransitionPush
//        transition.subtype = kCATransitionFromLeft
//        view.window!.layer.addAnimation(transition, forKey: kCATransition)
//        let sideMenuViewController = SideMenuViewController(nibName: "SideMenuViewController", bundle: nil)
//        presentViewController(sideMenuViewController, animated: false, completion: nil)
//        
//    }
//}
//    




