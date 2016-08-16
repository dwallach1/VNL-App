//
//  PackageCell.swift
//  VNL App
//
//  Created by David Wallach on 8/16/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import MaterialKit

class PackageCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratesTextView: UITextView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bookButton: MKButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.whiteColor()
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.adjustsFontSizeToFitWidth = true
        imageView.image = UIImage(named: "whale-watching")
        
        bookButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        bookButton.setTitle("Book Now", forState: .Normal)
        bookButton.rippleLayerColor = UIColor.whiteColor()
        bookButton.backgroundColor = UIColor.VNLBlue()
        bookButton.layer.cornerRadius = 4
        bookButton.addTarget(self, action: #selector(bookButtonTapped), forControlEvents: .TouchUpInside)
    }
    
    func bookButtonTapped() {
        AppState.sharedInstance.adventure = titleLabel.text!
    }

}
