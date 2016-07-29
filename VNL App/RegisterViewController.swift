//
//  RegisterViewController.swift
//  VNL App
//
//  Created by David Wallach on 7/29/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import Firebase
import MaterialKit
import TextFieldEffects

class RegisterViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var registerUserButton: MKButton!
    @IBOutlet weak var passwordField: HoshiTextField!
    @IBOutlet weak var emailField: HoshiTextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.VNLBlue()
        
        self.view.backgroundColor = UIColor.VNLBlue()
        let toolBar = UIToolbar().ToolbarPiker(#selector(dismissPicker))
        
        
        emailField.borderActiveColor = UIColor.whiteColor()
        emailField.borderInactiveColor = UIColor.whiteColor()
        emailField.textColor = UIColor.whiteColor()
        emailField.placeholderColor = UIColor.whiteColor()
        emailField.inputAccessoryView = toolBar
        
        passwordField.borderActiveColor = UIColor.whiteColor()
        passwordField.borderInactiveColor = UIColor.whiteColor()
        passwordField.textColor = UIColor.whiteColor()
        passwordField.placeholderColor = UIColor.whiteColor()
        passwordField.inputAccessoryView = toolBar
        
        registerUserButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        registerUserButton.setTitle("Register", forState: .Normal)
        registerUserButton.rippleLayerColor = UIColor.whiteColor()
        registerUserButton.backgroundColor = UIColor.clearColor()
        registerUserButton.layer.borderWidth = 3
        registerUserButton.layer.borderColor = UIColor.whiteColor().CGColor
    }

    @IBAction func didTapSignUp(sender: AnyObject) {
        let email = emailField.text
        let password = passwordField.text
        FIRAuth.auth()?.createUserWithEmail(email!, password: password!) { (user, error) in
            if let error = error {
                
                print(error.localizedDescription)
                return
            }
            self.setDisplayName(user!)
        }
    }
    
    func setDisplayName(user: FIRUser) {
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = user.email!.componentsSeparatedByString("@")[0]
        changeRequest.commitChangesWithCompletion(){ (error) in
            if let error = error {
                let errorAlert = UIAlertController(title: "Error Creating Account", message: "Please Try Again", preferredStyle: .Alert)
                let dismiss = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
                errorAlert.addAction(dismiss)
                self.presentViewController(errorAlert, animated: true, completion: nil)

                print(error.localizedDescription)
                return
            }
            self.signedIn(FIRAuth.auth()?.currentUser)
        }
    }
    
    func signedIn(user: FIRUser?) {
        
        AppState.sharedInstance.displayName = user?.displayName ?? user?.email
        AppState.sharedInstance.photoUrl = user?.photoURL
        AppState.sharedInstance.signedIn = true
        NSNotificationCenter.defaultCenter().postNotificationName(Constants.NotificationKeys.SignedIn, object: nil, userInfo: nil)
        
        let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let homeNavigationController = UINavigationController(rootViewController: homeVC)
        self.presentViewController(homeNavigationController, animated: true, completion: nil)
    }
    
    func dismissPicker() {
        view.endEditing(true)
    }
}
