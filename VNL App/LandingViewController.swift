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
        
        let buttons: [MKButton] = [registerButton, loginButton]
        
        for button in buttons {
            button.setTitleColor(UIColor.VNLBlue(), forState: .Normal)
            button.rippleLayerColor = UIColor.VNLBlue()
            button.backgroundColor = UIColor.clearColor()
            button.layer.borderWidth = 3
            button.layer.borderColor = UIColor.VNLBlue().CGColor
        }
        
        registerButton.setTitle("Register", forState: .Normal)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), forControlEvents: .TouchUpInside)

        loginButton.setTitle("Login", forState: .Normal)
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

        let navigationViewController = NavigationViewController(nibName: "NavigationViewController", bundle: nil)
        self.presentViewController(navigationViewController, animated: true, completion: nil)
    }

}

