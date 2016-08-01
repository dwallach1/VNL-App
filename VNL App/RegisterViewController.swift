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
        self.view.backgroundColor = UIColor.VNLDarkBlue()
        
        let toolBar = UIToolbar().ToolbarPiker(#selector(dismissPicker))
        
        emailField.borderActiveColor = UIColor.VNLBlue()
        emailField.borderInactiveColor = UIColor.VNLBlue()
        emailField.textColor = UIColor.VNLBlue()
        emailField.placeholderColor = UIColor.VNLBlue()
        emailField.inputAccessoryView = toolBar
        
        passwordField.borderActiveColor = UIColor.VNLBlue()
        passwordField.borderInactiveColor = UIColor.VNLBlue()
        passwordField.textColor = UIColor.VNLBlue()
        passwordField.placeholderColor = UIColor.VNLBlue()
        passwordField.inputAccessoryView = toolBar
        
        registerUserButton.setTitleColor(UIColor.VNLBlue(), forState: .Normal)
        registerUserButton.setTitle("Register", forState: .Normal)
        registerUserButton.rippleLayerColor = UIColor.VNLBlue()
        registerUserButton.backgroundColor = UIColor.clearColor()
        registerUserButton.layer.borderWidth = 3
        registerUserButton.layer.borderColor = UIColor.VNLBlue().CGColor
        
        homeButton.titleLabel?.textColor = UIColor.VNLBlue()
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
    
    @IBAction func homeButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)   
    }
    
    func dismissPicker() {
        view.endEditing(true)
    }
}
