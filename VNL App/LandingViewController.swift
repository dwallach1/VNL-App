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

    @IBOutlet weak var registerButton: MKButton!
    @IBOutlet weak var loginButton: MKButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.VNLDarkBlue()
        
//        let filePath = NSBundle.mainBundle().pathForResource("Landing", ofType: "gif")
//        let gif = NSData(contentsOfFile: filePath!)
//        
//        let webViewBG = UIWebView(frame: gifView.frame)
//        webViewBG.loadData(gif!, MIMEType: "image/gif", textEncodingName: String(), baseURL: NSURL())
//        webViewBG.userInteractionEnabled = false
//        webViewBG.center.y = gifView.center.y + 60
//        webViewBG.center.x = gifView.center.x - 100
//        webViewBG.frame.size = gifView.frame.size
//        webViewBG.contentMode = .Center
////        webViewBG.center = gifView.center
//        gifView.addSubview(webViewBG)

        
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

        
        self.presentViewController(homeNavigationController, animated: true, completion: nil)
//        self.presentViewController(HomeViewController(), animated: true, completion: nil)

    }

}

