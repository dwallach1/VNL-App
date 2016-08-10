//
//  BayHotelCollectionViewCell.swift
//  VNL App
//
//  Created by David Wallach on 8/10/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import MaterialKit

class BayHotelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bookButton: MKButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.whiteColor()
        titleView.backgroundColor = UIColor.whiteColor()
//        descriptionTextView.backgroundColor = UIColor.VNLDarkBlue()
//        descriptionTextView.textColor = UIColor.whiteColor()
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.adjustsFontSizeToFitWidth = true
        priceLabel.textColor = UIColor.blackColor()
        cellImage.image = UIImage(named: "campsbay1")
        
        bookButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        bookButton.setTitle("Book Now", forState: .Normal)
        bookButton.rippleLayerColor = UIColor.whiteColor()
        bookButton.backgroundColor = UIColor.VNLBlue()
        bookButton.layer.cornerRadius = 4
    }

}