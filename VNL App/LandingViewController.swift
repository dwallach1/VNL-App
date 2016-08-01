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

class LandingViewController: BaseViewController {

    @IBOutlet weak var registerButton: MKButton!
    @IBOutlet weak var loginButton: MKButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.VNLDarkBlue()
        
        registerButton.setTitleColor(UIColor.VNLBlue(), forState: .Normal)
        registerButton.setTitle("Register", forState: .Normal)
        registerButton.rippleLayerColor = UIColor.VNLBlue()
        registerButton.backgroundColor = UIColor.clearColor()
        registerButton.layer.borderWidth = 3
        registerButton.layer.borderColor = UIColor.VNLBlue().CGColor
        registerButton.addTarget(self, action: #selector(registerButtonTapped), forControlEvents: .TouchUpInside)

        loginButton.setTitleColor(UIColor.VNLBlue(), forState: .Normal)
        loginButton.setTitle("Login", forState: .Normal)
        loginButton.rippleLayerColor = UIColor.VNLBlue()
        loginButton.backgroundColor = UIColor.clearColor()
        loginButton.layer.borderWidth = 3
        loginButton.layer.borderColor = UIColor.VNLBlue().CGColor
        loginButton.addTarget(self, action: #selector(loginButtonTapped), forControlEvents: .TouchUpInside)
        
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
        let homeNavigationController = UINavigationController(rootViewController: homeVC)
        homeNavigationController.navigationBar.translucent = false
        homeNavigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        homeNavigationController.navigationBar.barTintColor = UIColor.VNLDarkBlue()

        
//        self.presentViewController(homeNavigationController, animated: true, completion: nil)
        let navigationViewController = NavigationViewController(nibName: "NavigationViewController", bundle: nil)
        self.presentViewController(navigationViewController, animated: true, completion: nil)

    }

}

