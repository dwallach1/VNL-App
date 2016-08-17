//
//  PropertyModel.swift
//  VNL App
//
//  Created by David Wallach on 8/17/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import Foundation
import UIKit

class PropertyModel {
    var title: String
    var image: UIImage?
    var price: Int
    var description: String
    var type: String
    
    init(title: String, image: UIImage? = nil, price: Int, description: String, type: String) {
        self.title = title
        self.image = image
        self.price = price
        self.description = description
        self.type = type
    }
}