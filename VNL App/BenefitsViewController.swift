//
//  BenefitsViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/4/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import ImageSlideshow


class BenefitsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet var slideshow: ImageSlideshow!

    
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
        slideshow.pageControl.pageIndicatorTintColor = UIColor.blackColor();
        slideshow.contentScaleMode = .ScaleAspectFill
        slideshow.setImageInputs([ImageSource(imageString: "benefits1")!, ImageSource(imageString: "benefits2")!, ImageSource(imageString: "benefits3")!])

    }


}