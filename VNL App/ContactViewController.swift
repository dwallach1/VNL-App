//
//  ContactViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/4/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import ImageSlideshow

class ContactViewController: UIViewController {

    @IBOutlet weak var contactPic: UIImageView!
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView.backgroundColor = UIColor.VNLBlue()
        titleLabel.textColor = UIColor.whiteColor()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        var sideMenu = UIBarButtonItem()
        if AppState.sharedInstance.signedIn == true {
            sideMenu = UIBarButtonItem(image: UIImage(named: "sideMenuIcon"), style: .Plain, target: self, action: #selector(loggedInSideMenuTapped))
        } else {
            sideMenu = UIBarButtonItem(image: UIImage(named: "sideMenuIcon"), style: .Plain, target: self, action: #selector(sideMenuTapped))
        }
        sideMenu.tintColor = UIColor.grayColor()
        self.navigationItem.leftBarButtonItem = sideMenu
        
        var rightMenu = UIBarButtonItem()
 
        if AppState.sharedInstance.signedIn == true {
            rightMenu = UIBarButtonItem(image: UIImage(named: "profileIcon"), style: .Plain, target: self, action: #selector(profileIconTapped))
        } else {
            rightMenu = UIBarButtonItem(image: UIImage(named: "loginIcon"), style: .Plain, target: self, action: #selector(loginIconTapped))
        }
        rightMenu.tintColor = UIColor.grayColor()
        self.navigationItem.rightBarButtonItem = rightMenu
        
        slideshow.backgroundColor = UIColor.whiteColor()
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.UnderScrollView
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGrayColor();
        slideshow.contentScaleMode = .ScaleAspectFill
        slideshow.setImageInputs([ImageSource(imageString: "contact1")!, ImageSource(imageString: "contact2")!])
        
        contactPic.contentMode = .ScaleAspectFill

    }


}
