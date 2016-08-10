//
//  InformationViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/4/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import ImageSlideshow
import MaterialKit
import MessageUI


class InformationViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var titleView: UIView!

    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var applyButton: MKButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView.backgroundColor = UIColor.VNLBlue()
        titleLabel.textColor = UIColor.whiteColor()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let sideMenu = UIBarButtonItem(image: UIImage(named: "sideMenuIcon"), style: .Plain, target: self, action: #selector(sideMenuTapped))
        sideMenu.tintColor = UIColor.grayColor()
        self.navigationItem.leftBarButtonItem = sideMenu
        
        let loginMenu = UIBarButtonItem(image: UIImage(named: "loginIcon"), style: .Plain, target: self, action: #selector(loginIconTapped))
        loginMenu.tintColor = UIColor.grayColor()
        self.navigationItem.rightBarButtonItem = loginMenu
        
        slideshow.backgroundColor = UIColor.whiteColor()
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.UnderScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGrayColor();
        slideshow.contentScaleMode = .ScaleAspectFill
        slideshow.setImageInputs([ImageSource(imageString: "works1")!, ImageSource(imageString: "works2")!, ImageSource(imageString: "works3")!])
        
        applyButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        applyButton.backgroundColor = UIColor.VNLBlue()
        applyButton.cornerRadius = 4
        applyButton.rippleLayerColor = UIColor.whiteColor()
        applyButton.setTitle("APPLY", forState: .Normal)
        applyButton.addTarget(self, action: #selector(applyButtonTapped), forControlEvents: .TouchUpInside)

    }

}

extension InformationViewController {
    func applyButtonTapped() {
        let mailComposeViewController = configureMailComposeViewController()
        if MFMailComposeViewController.canSendMail()  {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
        
    }
    
    
    func configureMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["members@vlife.co.za"])
        mailComposerVC.setSubject("VNL Lesiure Club Application")
        mailComposerVC.setMessageBody("Hello, \n I would like to become a member. \n", isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert(){
        let sendMailErrorAlert = UIAlertView(title: "Could not send Email", message: "Your device could not send email, please check your internet connection.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}