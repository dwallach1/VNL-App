//
//  BenefitsViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/4/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit

class BenefitsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var centerImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleView.backgroundColor = UIColor.VNLBlue()
        titleLabel.textColor = UIColor.whiteColor()
        centerImage.contentMode = .ScaleAspectFill
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let sideMenu = UIBarButtonItem(image: UIImage(named: "sideMenuIcon"), style: .Plain, target: self, action: #selector(sideMenuTapped))
        sideMenu.tintColor = UIColor.grayColor()
        self.navigationItem.leftBarButtonItem = sideMenu
        
        let loginMenu = UIBarButtonItem(image: UIImage(named: "loginIcon"), style: .Plain, target: self, action: #selector(loginButtonTapped))        
        loginMenu.tintColor = UIColor.grayColor()
        self.navigationItem.rightBarButtonItem = loginMenu
    }


}


extension BenefitsViewController {
    func sideMenuTapped() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        view.window!.layer.addAnimation(transition, forKey: kCATransition)
        let sideMenuViewController = SideMenuViewController(nibName: "SideMenuViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: sideMenuViewController)
        presentViewController(navigationController, animated: false, completion: nil)
    }
    
    func loginButtonTapped() {
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.presentViewController(loginVC, animated: true, completion: nil)
    }
}