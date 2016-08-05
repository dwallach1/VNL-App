//
//  LandingViewController.swift
//  VNL App
//
//  Created by David Wallach on 7/29/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import MaterialKit
import Firebase

class LandingViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var curiousButton: MKButton!
    @IBOutlet weak var memberButton: MKButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackground()
        self.setButtonAttributes()
        welcomeLabel.addTextSpacing(9.0)
        detailLabel.addTextSpacing(4.0)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let sideMenu = UIBarButtonItem(image: UIImage(named: "sideMenuIcon"), style: .Plain, target: self, action: #selector(sideMenuTapped))
        sideMenu.tintColor = UIColor.grayColor()
        self.navigationItem.leftBarButtonItem = sideMenu
        
        let loginMenu = UIBarButtonItem(image: UIImage(named: "loginIcon"), style: .Plain, target: self, action: #selector(loginIconTapped))
        loginMenu.tintColor = UIColor.grayColor()
        loginMenu.title = "LOGIN"
        self.navigationItem.rightBarButtonItem = loginMenu
        
        memberButton.alpha = 0
        curiousButton.alpha = 0
        detailLabel.alpha = 0
        welcomeLabel.alpha = 0
    
    }
    
    override func viewDidAppear(animated: Bool) {
        if let user = FIRAuth.auth()?.currentUser {
            self.signedIn(user)
        }
        welcomeLabel.fadeIn(2)
        detailLabel.fadeIn(3)
        memberButton.fadeIn(4)
        curiousButton.fadeIn(4)
    }

    func memberButtonTapped(){
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.presentViewController(loginVC, animated: true, completion: nil)
    }
    
    func curiousButtonTapped() {
        let curiousVC = CuriousViewController(nibName: "CuriousViewController", bundle: nil)
        let navVC = UINavigationController(rootViewController: curiousVC)
        self.presentViewController(navVC, animated: true, completion: nil)
        AppState.sharedInstance.screen = "curious"
    }
    
    func signedIn(user: FIRUser?) {
        
        AppState.sharedInstance.displayName = user?.displayName ?? user?.email
        AppState.sharedInstance.photoUrl = user?.photoURL
        AppState.sharedInstance.signedIn = true
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.NotificationKeys.SignedIn, object: nil, userInfo: nil)
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let navigationVC = UINavigationController(rootViewController: homeVC)
        self.presentViewController(navigationVC, animated: true, completion: nil)
    }

}

extension LandingViewController {
    func addBackground() {
        // screen width and height:
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "Main Background")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.view.addSubview(imageViewBackground)
        self.view.sendSubviewToBack(imageViewBackground)
    }
    
    func setButtonAttributes() {
        curiousButton.backgroundColor = UIColor.VNLRed()
        curiousButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        curiousButton.rippleLayerColor = UIColor.blackColor()
        curiousButton.rippleLayerColor.colorWithAlphaComponent(1.0)
        curiousButton.setTitle("CURIOUS?", forState: .Normal)
        curiousButton.addTarget(self, action: #selector(curiousButtonTapped), forControlEvents: .TouchUpInside)
        
        memberButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        memberButton.layer.borderWidth = 1
        memberButton.layer.borderColor = UIColor.whiteColor().CGColor
        memberButton.rippleLayerColor = UIColor.whiteColor()
        memberButton.setTitle("MEMBERS", forState: .Normal)
        memberButton.addTarget(self, action: #selector(memberButtonTapped), forControlEvents: .TouchUpInside)
        
    }
}

