//
//  AppState.swift
//  VNL App
//
//  Created by David Wallach on 7/29/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import Foundation
import MediumMenu

class AppState: NSObject {

  static let sharedInstance = AppState()

    var signedIn = false
    var displayName: String?
    var photoUrl: NSURL?
    var screen: String = "home"
    var selectedCell: String = "home"
    

}
