//
//  UserModel.swift
//  VNL App
//
//  Created by David Wallach on 8/10/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import Foundation
import UIKit

class User {
    var uid: String
    var firstName: String
    var lastName: String
    var profileImage: UIImage?
    
    init(uid: String, firstName: String, lastName: String, profileImage: UIImage?) {
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.profileImage = nil
    }
}