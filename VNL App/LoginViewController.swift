//
//  LoginViewController.swift
//  VNL App
//
//  Created by David Wallach on 7/29/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import MaterialKit
import TextFieldEffects
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: HoshiTextField!
    @IBOutlet weak var passwordField: HoshiTextField!
    
    @IBOutlet weak var loginButton: MKButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginButton.setTitle("Login", forState: .Normal)
        loginButton.rippleLayerColor = UIColor.whiteColor()
        loginButton.backgroundColor = UIColor.clearColor()
        loginButton.layer.borderWidth = 3
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        
    }
    
    override func viewDidAppear(animated: Bool) {
        if let user = FIRAuth.auth()?.currentUser {
            self.signedIn(user)
        }
    }
    
    
    @IBAction func didTapSignIn(sender: AnyObject) {
        // Sign In with credentials.
        let email = emailField.text
        let password = passwordField.text
        FIRAuth.auth()?.signInWithEmail(email!, password: password!) { (user, error) in
            if let error = error {
                let errorAlert = UIAlertController(title: "Invalid Email or Password", message: "Please try again", preferredStyle: .Alert)
                let dismiss = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
                errorAlert.addAction(dismiss)
                self.presentViewController(errorAlert, animated: true, completion: nil)
                
                print(error.localizedDescription)
                return
            }
            self.signedIn(user!)
        }
    }
    

    @IBAction func didRequestPasswordReset(sender: AnyObject) {
        let prompt = UIAlertController.init(title: nil, message: "Email:", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Default) { (action) in
            let userInput = prompt.textFields![0].text
            if (userInput!.isEmpty) {
                return
            }
            FIRAuth.auth()?.sendPasswordResetWithEmail(userInput!) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    let errorAlert = UIAlertController(title: "Error Retrieving Account", message: "No matching email was found in our database", preferredStyle: .Alert)
                    let dismiss = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
                    errorAlert.addAction(dismiss)
                    self.presentViewController(errorAlert, animated: true, completion: nil)

                    return
                }
            }
        }
        prompt.addTextFieldWithConfigurationHandler(nil)
        prompt.addAction(okAction)
        presentViewController(prompt, animated: true, completion: nil);
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

