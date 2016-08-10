//
//  BayHotelViewController.swift
//  VNL App
//
//  Created by David Wallach on 8/10/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit

private let reuseIdentifier = "hotelRoomCell"

class BayHotelViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.title = "The Bay Hotel"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor()]
        self.navigationController!.navigationBar.barTintColor = UIColor.whiteColor()
        
        let leftBarButton = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(backButtonTapped))
        navigationController?.navigationItem.leftBarButtonItem = leftBarButton
        
        collectionView?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.95)
        collectionView?.alwaysBounceVertical = true

        // Register cell classes
        self.collectionView?.registerNib(UINib(nibName: "BayHotelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

    }

    func backButtonTapped() {
        let campsBayVC = CampsBayBookingViewController(nibName: "CampsBayBookingViewController", bundle: nil)
        let navVC = UINavigationController(rootViewController: campsBayVC)
        presentViewController(navVC, animated: true, completion: nil)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 11
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? BayHotelCollectionViewCell
        
        switch indexPath.row {
        case 0:
            cell?.titleLabel.text = "Mountain Room"
            cell?.priceLabel.text = "R 1,100"
            cell?.cellImage.image = UIImage(named: "campsbay1")
            break
        case 1:
            cell?.titleLabel.text = "Classic Room"
            cell?.priceLabel.text = "R 1,100"
            cell?.cellImage.image = UIImage(named: "campsbay2")
            break
        case 2:
            cell?.titleLabel.text = "Club Classic Room"
            cell?.priceLabel.text = "R 1,100"
            cell?.cellImage.image = UIImage(named: "campsbay3")
            break
        case 3:
            cell?.titleLabel.text = "Premier Mountain Room"
            cell?.priceLabel.text = "R 1,200"
            cell?.cellImage.image = UIImage(named: "campsbay1")
            break
        case 4:
            cell?.titleLabel.text = "Premier Pool Room"
            cell?.priceLabel.text = "R 1,200"
            cell?.cellImage.image = UIImage(named: "campsbay2")
            break
        case 5:
            cell?.titleLabel.text = "Premeir Sea Room"
            cell?.priceLabel.text = "R 1,350"
            cell?.cellImage.image = UIImage(named: "campsbay3")
            break
        case 6:
            cell?.titleLabel.text = "Cabana Room"
            cell?.priceLabel.text = "R 1,350"
            cell?.cellImage.image = UIImage(named: "campsbay1")
            break
        case 7:
            cell?.titleLabel.text = "Luxury Room"
            cell?.priceLabel.text = "R 1,200"
            cell?.cellImage.image = UIImage(named: "campsbay2")
            break
        case 8:
            cell?.titleLabel.text = "Suite"
            cell?.priceLabel.text = "R 1,200"
            cell?.cellImage.image = UIImage(named: "campsbay3")
            break
        case 9:
            cell?.titleLabel.text = "Penthouse"
            cell?.priceLabel.text = "R 1,350"
            cell?.cellImage.image = UIImage(named: "campsbay1")
            break
        case 10:
            cell?.titleLabel.text = "Adventure Pad"
            cell?.priceLabel.text = "R 1,350"
            cell?.cellImage.image = UIImage(named: "campsbay2")
            break
        default:
            return cell!
        }
        // Configure the cell
    
        return cell!
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
}

extension BayHotelViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 200)
    }
}