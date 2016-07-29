//
//  LandingViewController.swift
//  VNL App
//
//  Created by David Wallach on 7/29/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import MaterialKit

class LandingViewController: UIViewController {

    @IBOutlet weak var registerButton: MKButton!
    @IBOutlet weak var loginButton: MKButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.VNLBlue()
        
//        let filePath = NSBundle.mainBundle().pathForResource("Landing", ofType: "gif")
//        let gif = NSData(contentsOfFile: filePath!)
//        
//        let webViewBG = UIWebView(frame: gifView.frame)
//        webViewBG.loadData(gif!, MIMEType: "image/gif", textEncodingName: String(), baseURL: NSURL())
//        webViewBG.userInteractionEnabled = false
//        webViewBG.center.y = gifView.center.y + 60
//        webViewBG.center.x = gifView.center.x - 100
//        webViewBG.frame.size = gifView.frame.size
//        webViewBG.contentMode = .Center
////        webViewBG.center = gifView.center
//        gifView.addSubview(webViewBG)

        
        registerButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        registerButton.setTitle("Register", forState: .Normal)
        registerButton.rippleLayerColor = UIColor.whiteColor()
        registerButton.backgroundColor = UIColor.clearColor()
        registerButton.layer.borderWidth = 3
        registerButton.layer.borderColor = UIColor.whiteColor().CGColor

        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loginButton.setTitle("Login", forState: .Normal)
        loginButton.rippleLayerColor = UIColor.whiteColor()
        loginButton.backgroundColor = UIColor.clearColor()
        loginButton.layer.borderWidth = 3
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        
    }


}
