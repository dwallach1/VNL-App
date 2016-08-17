//
//  BayHotelViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/10/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit
import SwiftSpinner
import FirebaseDatabase

private let reuseIdentifier = "propertyCell"

class PropertyViewController: UICollectionViewController {
    
    var properties: [PropertyModel] = []
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "\(AppState.sharedInstance.property)"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor()]
        self.navigationController!.navigationBar.barTintColor = UIColor.whiteColor()
        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .Plain, target: self, action: #selector(backButtonTapped))
        leftBarButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        collectionView?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.95)
        collectionView?.alwaysBounceVertical = true

        // Register cell classes
        self.collectionView?.registerNib(UINib(nibName: "PropertyCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewDidAppear(animated: Bool) {
        SwiftSpinner.show("Loading Properties")
        properties = []
        connectToDB()
    }

    func backButtonTapped() {
        let bookingVC = BookingViewController()
        let navVC = UINavigationController(rootViewController: bookingVC)
        presentViewController(navVC, animated: true, completion: nil)

    }
    
    func connectToDB() {

        ref = FIRDatabase.database().reference().child("booking").child("\(AppState.sharedInstance.bookingLocationJSON)").child("\(AppState.sharedInstance.propertyTitleJSON)").child("rooms")
        self.ref.observeEventType(.Value, withBlock: { (snapshot) in
            
            for child in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let childSnapshot = snapshot.childSnapshotForPath(child.key)
                let title = childSnapshot.value!["title"] as! String
                let price = childSnapshot.value!["price"] as! Int
                let description = childSnapshot.value!["description"] as! String
                let type = childSnapshot.key
                let newProperty = PropertyModel(title: title, image: nil, price: price, description: description, type: type)
                self.properties.append(newProperty)
            }
            
            self.collectionView!.reloadData()
            SwiftSpinner.hide()
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
}


extension PropertyViewController {
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return properties.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? PropertyCell
        
        
        cell?.titleLabel.text = properties[indexPath.row].title
        cell?.descriptionTextView.text = properties[indexPath.row].description
        cell?.priceLabel.text = ("R \(properties[indexPath.row].price)")
        cell?.currRoomType = properties[indexPath.row].type
        cell?.bookButton.addTarget(self, action: #selector(bookNowButtonTapped), forControlEvents: .TouchUpInside)

        
        //this is hardcoded for now, will download pics from database once they are encoded
        switch indexPath.row {
        case 0:
            cell?.cellImage.image = UIImage(named: "campsbay1")
            break
        case 1:
            cell?.cellImage.image = UIImage(named: "campsbay2")
            break
        case 2:
            cell?.cellImage.image = UIImage(named: "campsbay3")
            break
        case 3:
            cell?.cellImage.image = UIImage(named: "campsbay1")
            break
        case 4:
            cell?.cellImage.image = UIImage(named: "campsbay2")
            break
        case 5:
            cell?.cellImage.image = UIImage(named: "campsbay3")
            break
        case 6:
            cell?.cellImage.image = UIImage(named: "campsbay1")
            break
        case 7:
            cell?.cellImage.image = UIImage(named: "campsbay2")
            break
        case 8:
            cell?.cellImage.image = UIImage(named: "campsbay3")
            break
        case 9:
            cell?.cellImage.image = UIImage(named: "campsbay1")
            break
        case 10:
            cell?.cellImage.image = UIImage(named: "campsbay2")
            break
        default:
            break
        }
        
        return cell!
    }
    

    func bookNowButtonTapped() {
        let calendarVC = CalendarViewController(nibName: "CalendarViewController", bundle: nil)
        presentViewController(calendarVC, animated: true, completion: nil)
    }
    
}

extension PropertyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 200)
    }
}