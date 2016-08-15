//
//  PaymentViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/14/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import MaterialKit
import TextFieldEffects
import FirebaseDatabase
import MessageUI


class PaymentViewController: UIViewController {

    @IBOutlet weak var cvvTextField: HoshiTextField!
    @IBOutlet weak var expirationDateTextField: UIDatePickerTextField!
    @IBOutlet weak var creditCardTextField: HoshiTextField!
    @IBOutlet weak var payButton: MKButton!
    @IBOutlet weak var cancelButton: MKButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var bookedDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    var ref: FIRDatabaseReference!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributes()
    }
    
    
    @IBAction func cancelButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func payButtonTapped() {

        let mailComposeViewController = configureMailComposeViewController()
        if MFMailComposeViewController.canSendMail()  {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }

}


extension PaymentViewController: MFMailComposeViewControllerDelegate {
    func configureMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["members@vlife.co.za"])
        mailComposerVC.setSubject("Mobile Booking at \(AppState.sharedInstance.property)")
        mailComposerVC.setMessageBody("Hello, \n I would like to book the \(AppState.sharedInstance.roomTitle) from \(AppState.sharedInstance.bookingDates.first!) until \(AppState.sharedInstance.bookingDates.last!). \nBest, \n\(AppState.sharedInstance.displayName!) \n", isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert(){
        let sendMailErrorAlert = UIAlertView(title: "Could not send Email", message: "Your device could not send email, please check your internet connection.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        
        ref = FIRDatabase.database().reference().child("campsBay").child("bayHotel").child("rooms").child("\(AppState.sharedInstance.currRoomType)")
        
        if result == MFMailComposeResultSent {
            
            ref.child("datesBooked").setValue(AppState.sharedInstance.updatedDBDates)
            
        }
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}


extension PaymentViewController {
    
    func setAttributes() {
        
        var myMutableString = NSMutableAttributedString()
        
        let nightsCount: Int
        if AppState.sharedInstance.bookingDates.isEmpty {
            nightsCount = 0
        } else {
            nightsCount = AppState.sharedInstance.bookingDates.count
        }
        let bookedLabelString: String
        if nightsCount > 1 {
            bookedLabelString = "You're booked to stay with us for \(nightsCount) nights from \(AppState.sharedInstance.bookingDates.first!) until \(AppState.sharedInstance.bookingDates.last!)"
        } else {
            bookedLabelString = "You're booked to stay with us one night on \(AppState.sharedInstance.bookingDates.first!)"
        }

        
        myMutableString = NSMutableAttributedString(string: bookedLabelString, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 22.0)!])

        bookedDateLabel.attributedText = myMutableString

        
        let priceString: String = "\(AppState.sharedInstance.price)"
        let priceStringCharCount: Int = priceString.characters.count + 2
        let priceLabelString: String = "Your total is R \(AppState.sharedInstance.price)"
        myMutableString = NSMutableAttributedString(string: priceLabelString, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 22.0)!])
        myMutableString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(18.0), range: NSRange(location:14,length: priceStringCharCount))
        
        priceLabel.attributedText = myMutableString
        
        
        
        let roomTypeString: String = "\(AppState.sharedInstance.roomTitle)"
        let roomTypeCharCount: Int = roomTypeString.characters.count
        let roomTypeLabelString: String = "Your room type is \(AppState.sharedInstance.roomTitle)"
        
        myMutableString = NSMutableAttributedString(string: roomTypeLabelString, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 22.0)!])
        myMutableString.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(18.0), range: NSRange(location:18,length: roomTypeCharCount))
        
        roomTypeLabel.attributedText = myMutableString

        
        let buttons = [cancelButton, payButton]
        for button in buttons {
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.rippleLayerColor = UIColor.whiteColor()
            button.backgroundColor = UIColor.VNLBlue()
            button.layer.cornerRadius = 4
        }
    
        backgroundImageView.contentMode = .ScaleAspectFill
    }
    
}
