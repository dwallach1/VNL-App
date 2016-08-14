//
//  PaymentViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/14/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var bookedDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var roomTypeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView.contentMode = .ScaleAspectFit
        bookedDateLabel.text = "You're booked to stay with us from \(AppState.sharedInstance.bookingDates.first!) until \(AppState.sharedInstance.bookingDates.last!)"
        bookedDateLabel.adjustsFontSizeToFitWidth = true
        priceLabel.text = "Your total is R \(AppState.sharedInstance.price)"
        roomTypeLabel.text = "Your room type is \(AppState.sharedInstance.currRoomType)"
        // Do any additional setup after loading the view.
    }



}
