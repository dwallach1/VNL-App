//
//  HermanusPackageViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/16/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import ImageSlideshow
import MessageUI
import FirebaseDatabase
import FirebaseStorage
import SwiftSpinner

class PackageViewController: UIViewController {
    
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var ref: FIRDatabaseReference!
    var storage: FIRStorage!
    var packages: [PackageModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributes()
        
        collectionView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.95)
        self.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.95)
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(UINib(nibName: "PackageCell", bundle: nil), forCellWithReuseIdentifier: "packageCell")
        collectionView.reloadData()
        slideshow.backgroundColor = UIColor.whiteColor()
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.UnderScrollView
        slideshow.contentScaleMode = .ScaleAspectFill
        
        if AppState.sharedInstance.packageLocation == "hermanus" {
            slideshow.setImageInputs([ImageSource(imageString: "hermanusp1")!, ImageSource(imageString: "hermanusp2")!, ImageSource(imageString: "hermanusp3")!])
        } else if AppState.sharedInstance.packageLocation == "langebaan" {
            slideshow.setImageInputs([ImageSource(imageString: "langebaanp1")!, ImageSource(imageString: "langebaanp1")!, ImageSource(imageString: "langebaanp1")!])
        } else if AppState.sharedInstance.packageLocation == "capeTown" {
            slideshow.setImageInputs([ImageSource(imageString: "capetown1")!, ImageSource(imageString: "capetown2")!, ImageSource(imageString: "capetown3")!])
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        connectToDB()
        SwiftSpinner.show("Loading Deals...")
        packages = []
    }
    
    func connectToDB() {
        storage = FIRStorage.storage()
        let storageRef = storage.referenceForURL("gs://vnl-mobile-application.appspot.com")
        ref = FIRDatabase.database().reference().child("packages").child("\(AppState.sharedInstance.packageLocation)")

        self.ref.observeEventType(.Value, withBlock: { (snapshot) in
            
            for child in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let childSnapshot = snapshot.childSnapshotForPath(child.key)
                let title = childSnapshot.value!["title"] as! String
                let description = childSnapshot.value!["description"] as! String
                let rates = childSnapshot.value!["rates"] as! String
                let imageJSON = childSnapshot.value!["image"] as! String
                
                
                let imagesRef = storageRef.child("\(imageJSON).jpg")

                imagesRef.dataWithMaxSize(1 * 1024 * 1024) { (data, error) -> Void in
                    if (error != nil) {
                        // Uh-oh, an error occurred!
                        let currPackage = PackageModel(title: title,  description: description, rates: rates)
                        self.packages.append(currPackage)
                    } else {
                        // Data for "images/island.jpg" is returned
                        let packageImage: UIImage! = UIImage(data: data!)
                        let currPackage = PackageModel(title: title,  description: description, rates: rates, image: packageImage)
                        self.packages.append(currPackage)
                        self.collectionView.reloadData()
                        SwiftSpinner.hide()
                    }
                }

            }
            
            self.viewDidLoad()

        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
}


extension PackageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return packages.count
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("packageCell", forIndexPath: indexPath) as? PackageCell
        
        cell?.titleLabel.text = packages[indexPath.row].title
        cell?.descriptionTextView.text = packages[indexPath.row].description
        cell?.ratesTextView.text = packages[indexPath.row].rates
        cell?.imageView.image = packages[indexPath.row].image
        cell?.bookButton.addTarget(self, action: #selector(bookNowButtonTapped), forControlEvents: .TouchUpInside)

        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 300)
    }
}

extension PackageViewController {
    func setAttributes() {
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        let sideMenu = UIBarButtonItem(image: UIImage(named: "sideMenuIcon"), style: .Plain, target: self, action: #selector(loggedInSideMenuTapped))
        sideMenu.tintColor = UIColor.grayColor()
        self.navigationItem.leftBarButtonItem = sideMenu
        
        let profileMenu = UIBarButtonItem(image: UIImage(named: "profileIcon"), style: .Plain, target: self, action: #selector(profileIconTapped))
        profileMenu.tintColor = UIColor.grayColor()
        self.navigationItem.rightBarButtonItem = profileMenu
        
        titleView.backgroundColor = UIColor.VNLBlue()
        titleLabel.text = AppState.sharedInstance.packageLocationTitle
    }
    
    func bookNowButtonTapped() {
        let mailComposeViewController = configureMailComposeViewController()
        if MFMailComposeViewController.canSendMail()  {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
}

extension PackageViewController: MFMailComposeViewControllerDelegate {
    func configureMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["members@vlife.co.za"])
        mailComposerVC.setSubject("Adventure Booking at \(AppState.sharedInstance.packageLocationTitle)")
        mailComposerVC.setMessageBody("Hello, \n I would like to book \(AppState.sharedInstance.adventure) on sunday july 4th for 5 people \n", isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert(){
        let sendMailErrorAlert = UIAlertView(title: "Could not send Email", message: "Your device could not send email, please check your internet connection.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        
        controller.dismissViewControllerAnimated(true, completion: nil)
       
        if result == MFMailComposeResultSent {
            let homeVC = HomeViewController(nibName: "HomeViewController", bundle: nil)
            let navVC = UINavigationController(rootViewController: homeVC)
            self.presentViewController(navVC, animated: true, completion: nil)
            
        }
    }
    
}

