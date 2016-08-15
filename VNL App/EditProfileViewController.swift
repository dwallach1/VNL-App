//
//  EditProfileViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/5/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase
import FirebaseAuth
import MaterialKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var updateButton: MKButton!
    @IBOutlet weak var lastNameTextField: HoshiTextField!
    @IBOutlet weak var firstNameTextField: HoshiTextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAttributes()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let sideMenu = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .Plain, target: self, action: #selector(dismissView))
        sideMenu.tintColor = UIColor.grayColor()
        self.navigationItem.leftBarButtonItem = sideMenu

    }

    @IBAction func imageButtonTapped(sender: AnyObject) {
        
    }

    @IBAction func updateButtonTapped(sender: AnyObject) {
//        var user = FIRAuth.auth()!.currentUser
//       
//        user.updateProfile({
//            displayName: "\(firstNameTextField.text)",
//            photoURL: "https://example.com/jane-q-user/profile.jpg"
//        }).then(function() {
//            // Update successful.
//            }, function(error) {
//                // An error happened.
//            });
    }

}

extension EditProfileViewController {
    
    func setAttributes() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        
        displayNameLabel.text = "Welcome, \((FIRAuth.auth()?.currentUser?.displayName)!)"
        displayNameLabel.adjustsFontSizeToFitWidth = true
        
        let toolBar = UIToolbar().ToolbarPiker(#selector(dismissPicker))
        let fields = [firstNameTextField, lastNameTextField]
        
        for field in fields {
            field.backgroundColor = UIColor.clearColor()
            field.borderActiveColor = UIColor.VNLGreen()
            field.borderInactiveColor = UIColor.VNLGreen()
            field.textColor = UIColor.blackColor()
            field.placeholderColor = UIColor.blackColor()
            field.inputAccessoryView = toolBar
        }
        
        updateButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        updateButton.setTitle("Update", forState: .Normal)
        updateButton.rippleLayerColor = UIColor.whiteColor()
        updateButton.backgroundColor = UIColor.VNLBlue()
        updateButton.layer.cornerRadius = 4

    
    }
    
    func dismissPicker() {
        view.endEditing(true)
    }
}