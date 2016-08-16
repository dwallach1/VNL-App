//
//  AppDelegate.swift
//  VNL App
//
//  Created by David Wallach on 7/28/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        FIRApp.configure()
        
        let landingVC = LandingViewController(nibName: "LandingViewController", bundle: nil)
        let initialNavigationVC = UINavigationController(rootViewController: landingVC)
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = initialNavigationVC
        self.window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {

    }

    func applicationDidEnterBackground(application: UIApplication) {

    }

    func applicationWillEnterForeground(application: UIApplication) {

    }

    func applicationDidBecomeActive(application: UIApplication) {

    }

    func applicationWillTerminate(application: UIApplication) {

    }


}

