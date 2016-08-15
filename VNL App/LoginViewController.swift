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
import SwiftSpinner
import Firebase
import NYAlertViewController

class LoginViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var emailField: HoshiTextField!
    @IBOutlet weak var passwordField: HoshiTextField!
    
    @IBOutlet weak var loginButton: MKButton!
    
    let alertViewController = NYAlertViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackground()
        self.setAtributes()
        self.setUpAlert()

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
        
        SwiftSpinner.show("Connecting to Database to Authenticate User...")
        
        FIRAuth.auth()?.signInWithEmail(email!, password: password!) { (user, error) in
            if let error = error {
                SwiftSpinner.hide()
//                let errorAlert = UIAlertController(title: "Invalid Email or Password", message: "Please try again", preferredStyle: .Alert)
//                let dismiss = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
//                errorAlert.addAction(dismiss)
//                self.presentViewController(errorAlert, animated: true, completion: nil)
//                
                // Set a title and message
                self.alertViewController.title = "Invalid Email or Password"
                self.alertViewController.message = "Please try again."
                
                // Present the alert view controller
                self.presentViewController(self.alertViewController, animated: true, completion: nil)
                
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
        
                    // Set a title and message
                    self.alertViewController.title = "Error Retrieving Account"
                    self.alertViewController.message = "No matching email was found in our database."
                    
                    // Present the alert view controller
                    self.presentViewController(self.alertViewController, animated: true, completion: nil)
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
        let navigationVC = UINavigationController(rootViewController: homeVC)
        self.presentViewController(navigationVC, animated: false, completion: nil)
        SwiftSpinner.hide()

    }
    
    func dismissPicker() {
        view.endEditing(true)
    }
}


extension LoginViewController {
    func addBackground() {
        // screen width and height:
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: "prime")
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        imageViewBackground.alpha = 0.7
        self.view.addSubview(imageViewBackground)
        self.view.sendSubviewToBack(imageViewBackground)
    }
    
    func setAtributes(){
        
        let toolBar = UIToolbar().ToolbarPiker(#selector(dismissPicker))
        let textFields : [HoshiTextField] = [passwordField, emailField]
        
        for field in textFields {
            field.backgroundColor = UIColor.clearColor()
            field.borderActiveColor = UIColor.VNLGreen()
            field.borderInactiveColor = UIColor.VNLGreen()
            field.textColor = UIColor.blackColor()
            field.placeholderColor = UIColor.blackColor()
            field.placeholderFontScale = 1.0
            field.inputAccessoryView = toolBar
            
        }
        
        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginButton.setTitle("Login", forState: .Normal)
        loginButton.rippleLayerColor = UIColor.whiteColor()
        loginButton.backgroundColor = UIColor.VNLBlue()
        loginButton.layer.cornerRadius = 4
        
        loginView.layer.cornerRadius = 4
        loginView.opaque = true
    }
    
    func setUpAlert() {
        self.alertViewController.buttonCornerRadius = 20.0
        self.alertViewController.view.tintColor = self.view.tintColor
        
        self.alertViewController.titleFont = UIFont(name: "AvenirNext-Bold", size: 19.0)
        self.alertViewController.messageFont = UIFont(name: "AvenirNext-Medium", size: 16.0)
        self.alertViewController.cancelButtonTitleFont = UIFont(name: "AvenirNext-Medium", size: 16.0)
        self.alertViewController.cancelButtonTitleFont = UIFont(name: "AvenirNext-Medium", size: 16.0)
        self.alertViewController.buttonColor = UIColor.VNLBlue()
        
        self.alertViewController.swipeDismissalGestureEnabled = false
        self.alertViewController.backgroundTapDismissalGestureEnabled = false
        
        // Add alert actions
        let cancelAction = NYAlertAction(
            title: "Dismiss",
            style: .Cancel,
            handler: { (action: NYAlertAction!) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        )
        self.alertViewController.addAction(cancelAction)

    }
}

