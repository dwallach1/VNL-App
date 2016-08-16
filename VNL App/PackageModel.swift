//
//  PackageModel.swift
//  VNL App
//
//  Created by David Wallach on 8/16/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import Foundation
import UIKit

class PackageModel {
    let title: String
    let description: String
    let rates: String
    let image: UIImage?
    
    
    init (title: String, description: String, rates: String, image: UIImage? = nil){
        self.title = title
        self.description = description
        self.rates = rates
        self.image = image
    }
}