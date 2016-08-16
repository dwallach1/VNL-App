//
//  AppState.swift
//  VNL App
//
//  Created by David Wallach on 7/29/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import Foundation

class AppState: NSObject {

  static let sharedInstance = AppState()

    var signedIn = false
    var displayName: String?
    var photoUrl: NSURL?
    var screen: String = "home"  //["home", "benefits", "information", "rates", "exclusive", "booking", "partners", "contact]
    
    var currRoomType: String = "nil" //used for transfering data from booking page to thank you page
    var bookingDates: [String] = [] //used for transfering data from booking page to thank you page
    var updatedDBDates: [String] = [] //used for transfering data from booking page to thank you page
    var price: Int = 0 //used to transfer current booking price to email and thank you page
    var roomTitle: String = "nil" //used to gather correct prices of rooms
    var property: String = "nil" //used for subject of inquire email
    var packageLocation: String = "nil" //used for getting package details from backend
    var adventure: String = "nil" //used for booking package email details 
    var selectedCell: String = "home"
}

