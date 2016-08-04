//
//  Extensions.swift
//  VNL App
//
//  Created by David Wallach on 7/29/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import Foundation
import UIKit



extension UIColor {
    class func VNLRed() -> UIColor {
        let colour = UIColor(red: 217/255, green: 32/255, blue: 42/255, alpha: 1)
        return colour
    }
    class func VNLBlue() -> UIColor {
        let colour = UIColor(red: 134/255, green: 167/255, blue: 193/255, alpha: 1)
        return colour
    }
    class func VNLDarkBlue() -> UIColor {
        let colour = UIColor(red: 37/255, green: 41/255, blue: 47/255, alpha: 1)
        return colour
    }
    class func VNLGreen() -> UIColor {
        let colour = UIColor(red: 131/255, green: 179/255, blue: 72/255, alpha: 1)
        return colour
    }

}

extension UIToolbar {
    
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor.blueColor()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        return toolBar
    }
    
}

extension UILabel{
    func addTextSpacing(spacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: self.text!)
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSRange(location: 0, length: self.text!.characters.count))
        self.attributedText = attributedString
    }
}


extension UIViewController {
    func sideMenuTapped() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        view.window!.layer.addAnimation(transition, forKey: kCATransition)
        let sideMenuViewController = SideMenuViewController(nibName: "SideMenuViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: sideMenuViewController)
        presentViewController(navigationController, animated: false, completion: nil)
        
    }
    
    func loginIconTapped() {
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.presentViewController(loginVC, animated: true, completion: nil)
    }
}