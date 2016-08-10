//
//  BookingModel.swift
//  VNL App
//
//  Created by David Wallach on 8/10/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class Booking {
    var bookings = [Booking]()
    let key: String?
    let date: String
    let type: String
    let itemRef: FIRDatabaseReference?
    
    init(date: String, type: String, key: String){
        self.key = key
        self.date = date
        self.type = type
        self.itemRef = nil
    }
    
    init(snapshot: FIRDataSnapshot){
        key = snapshot.key
        itemRef = snapshot.ref
        
        if let bookingType = snapshot.value!["type"] as? String {
            type = bookingType
        } else {
            type = ""
        }
        
        if let datesChosen = snapshot.value!["date"] as? String {
            date = datesChosen
        } else {
            date = ""
        }
    }
    
//        func toAnyObject() -> AnyObject {
//            return ["key": key,
//                    "date": date,
//                    "type": type]
//    
//        }
}