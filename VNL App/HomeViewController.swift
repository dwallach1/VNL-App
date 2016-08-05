//
//  HomeViewController.swift
//  VNL App
//
//  Created by David Wallach on 7/29/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import MaterialKit
import ImageSlideshow

class HomeViewController: UIViewController {
   
    @IBOutlet weak var exclusiveLabel: UILabel!
    @IBOutlet weak var fansLabel: UILabel!
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.VNLDarkBlue()

        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let sideMenu = UIBarButtonItem(image: UIImage(named: "sideMenuIcon"), style: .Plain, target: self, action: #selector(loggedInSideMenuTapped))
        sideMenu.tintColor = UIColor.grayColor()
        self.navigationItem.leftBarButtonItem = sideMenu
        
        let profileMenu = UIBarButtonItem(image: UIImage(named: "profileIcon"), style: .Plain, target: self, action: #selector(profileIconTapped))
        profileMenu.tintColor = UIColor.grayColor()
        self.navigationItem.rightBarButtonItem = profileMenu
        
        slideshow.backgroundColor = UIColor.whiteColor()
        slideshow.slideshowInterval = 5.0
        slideshow.contentScaleMode = .ScaleAspectFill
        slideshow.setImageInputs([ImageSource(imageString: "apply3")!, ImageSource(imageString: "apply2")!, ImageSource(imageString: "apply1")!])
        
        exclusiveLabel.alpha = 0
        fansLabel.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        self.performSelector(#selector(fade), withObject: self, afterDelay: 7)
        exclusiveLabel.fadeIn(2)
        fansLabel.fadeIn(3)
    }
    
    func fade() {
        exclusiveLabel.fadeOut()
        fansLabel.fadeOut()
    }
}


