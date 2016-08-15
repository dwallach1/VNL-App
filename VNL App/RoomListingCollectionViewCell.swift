//
//  BayHotelCollectionViewCell.swift
//  VNL App
//
//  Created by David Wallach on 8/10/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import MaterialKit

class RoomListingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bookButton: MKButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleView: UIView!
    var currRoomType = "nil"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.whiteColor()
        titleView.backgroundColor = UIColor.whiteColor()
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
    
    @IBAction func bookNowButtonTapped() {
        AppState.sharedInstance.currRoomType = currRoomType
        AppState.sharedInstance.roomTitle = titleLabel.text!
    }
}
