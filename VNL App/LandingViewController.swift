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
    @IBOutlet weak var registerButton: MKButton!
    @IBOutlet weak var loginButton: MKButton!
    
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
    
    }
    
    override func viewDidAppear(animated: Bool) {
        if let user = FIRAuth.auth()?.currentUser {
            self.signedIn(user)
        }
    }

    func loginButtonTapped(){
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.presentViewController(loginVC, animated: true, completion: nil)
    }
    
    func registerButtonTapped() {
        let registerVC = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        self.presentViewController(registerVC, animated: true, completion: nil)
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
        registerButton.backgroundColor = UIColor.VNLRed()
        registerButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        registerButton.rippleLayerColor = UIColor.blackColor()
        registerButton.rippleLayerColor.colorWithAlphaComponent(1.0)
        registerButton.setTitle("CURIOUS?", forState: .Normal)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), forControlEvents: .TouchUpInside)
        
        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        loginButton.rippleLayerColor = UIColor.whiteColor()
        loginButton.setTitle("MEMBERS", forState: .Normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), forControlEvents: .TouchUpInside)
        
    }
}

