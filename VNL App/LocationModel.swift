//
//  LocationModel.swift
//  VNL App
//
//  Created by David Wallach on 8/17/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import Foundation
import UIKit

class LocationModel {
    var title: String
    var image: UIImage?
    var locationJSON: String
    
    init(title: String, image: UIImage? = nil, locationJSON: String) {
        self.title = title
        self.image = image
        self.locationJSON = locationJSON
    }
}