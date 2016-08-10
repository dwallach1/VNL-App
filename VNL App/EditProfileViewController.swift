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

class EditProfileViewController: UIViewController {

    @IBOutlet weak var changeUsernameTextField: HoshiTextField!
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


}

extension EditProfileViewController {
    
    func setAttributes() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        
        displayNameLabel.text = "Welcome, \((FIRAuth.auth()?.currentUser?.displayName)!)"
        displayNameLabel.adjustsFontSizeToFitWidth = true
        
        let toolBar = UIToolbar().ToolbarPiker(#selector(dismissPicker))
        let fields = [changeUsernameTextField]
        
        for field in fields {
            field.backgroundColor = UIColor.clearColor()
            field.borderActiveColor = UIColor.VNLGreen()
            field.borderInactiveColor = UIColor.VNLGreen()
            field.textColor = UIColor.blackColor()
            field.placeholderColor = UIColor.blackColor()
//            field.placeholderFontScale = 1.0
            field.inputAccessoryView = toolBar
        }
    }
    
    func dismissPicker() {
        view.endEditing(true)
    }
}