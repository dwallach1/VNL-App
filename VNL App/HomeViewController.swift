//
//  HomeViewController.swift
//  VNL App
//
//  Created by David Wallach on 7/29/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import Firebase
import MediumMenu
import MaterialKit

class HomeViewController: BaseViewController {
    
    
    @IBOutlet weak var cellOne: UIView!
    @IBOutlet weak var cellTwo: UIView!
    @IBOutlet weak var cellThree: UIView!
    @IBOutlet weak var cellFour: UIView!
    
    @IBOutlet weak var cellOneButton: MKButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.VNLDarkBlue()
        self.view.frame.size.height = 60

        AppState.sharedInstance.screen = "Home"

        let cells : [UIView] = [cellOne, cellTwo, cellThree, cellFour]
        
        for cell in cells {
            cell.backgroundColor = UIColor.VNLBlue()
            cell.layer.cornerRadius = cell.bounds.size.width / 2
            cell.layer.masksToBounds = true
            cell.layer.borderWidth = 4
            cell.layer.borderColor = UIColor.whiteColor().CGColor
        }
        
        cellOneButton.rippleEnabled = true
        cellOneButton.rippleLayerColor = UIColor.whiteColor()
    }
    
    @IBAction func bookingButtonTapped() {
        let bookingVC = BookingViewController(nibName: "BookingViewController", bundle: nil)
        self.showViewController(bookingVC, sender: self)
        AppState.sharedInstance.screen = "Booking"

    }
}


