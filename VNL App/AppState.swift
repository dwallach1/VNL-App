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
    var screen: String = "home"  //["home", "benefits", "information", "rates", "exclusive", "booking",      "partners", "contact]
    
    var currRoomType: String = "nil"
    
    var selectedCell: String = "home"
    var currCellState: cellState = cellState(open: false, index: nil)


}

struct cellState {
    var open: Bool
    var index: NSIndexPath?
    init (open: Bool, index: NSIndexPath?){
        self.open = open
        self.index = index
    }
}