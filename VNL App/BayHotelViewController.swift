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
        
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .Plain, target: self, action: #selector(backButtonTapped))
        leftBarButton.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        collectionView?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.95)
        collectionView?.alwaysBounceVertical = true

        // Register cell classes
        self.collectionView?.registerNib(UINib(nibName: "BayHotelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

    }

    func backButtonTapped() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
        view.window!.layer.addAnimation(transition, forKey: kCATransition)
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
            cell?.currRoomType = "mountain"
            cell?.priceLabel.text = "R 1,100"
            cell?.cellImage.image = UIImage(named: "campsbay1")
            break
        case 1:
            cell?.titleLabel.text = "Classic Room"
            cell?.currRoomType = "classic"
            cell?.priceLabel.text = "R 1,100"
            cell?.cellImage.image = UIImage(named: "campsbay2")
            break
        case 2:
            cell?.titleLabel.text = "Club Classic Room"
            cell?.currRoomType = "clubClassic"
            cell?.priceLabel.text = "R 1,100"
            cell?.cellImage.image = UIImage(named: "campsbay3")
            break
        case 3:
            cell?.titleLabel.text = "Premier Mountain Room"
            cell?.currRoomType = "premierMountain"
            cell?.priceLabel.text = "R 1,200"
            cell?.cellImage.image = UIImage(named: "campsbay1")
            break
        case 4:
            cell?.titleLabel.text = "Premier Pool Room"
            cell?.currRoomType = "premierPool"
            cell?.priceLabel.text = "R 1,200"
            cell?.cellImage.image = UIImage(named: "campsbay2")
            break
        case 5:
            cell?.titleLabel.text = "Premier Sea Room"
            cell?.currRoomType = "premierSea"
            cell?.priceLabel.text = "R 1,350"
            cell?.cellImage.image = UIImage(named: "campsbay3")
            break
        case 6:
            cell?.titleLabel.text = "Cabana Room"
            cell?.currRoomType = "cabana"
            cell?.priceLabel.text = "R 1,350"
            cell?.cellImage.image = UIImage(named: "campsbay1")
            break
        case 7:
            cell?.titleLabel.text = "Luxury Room"
            cell?.currRoomType = "luxury"
            cell?.priceLabel.text = "R 1,200"
            cell?.cellImage.image = UIImage(named: "campsbay2")
            break
        case 8:
            cell?.titleLabel.text = "Suite"
            cell?.currRoomType = "suite"
            cell?.priceLabel.text = "R 1,200"
            cell?.cellImage.image = UIImage(named: "campsbay3")
            break
        case 9:
            cell?.titleLabel.text = "Penthouse"
            cell?.currRoomType = "penthouse"
            cell?.priceLabel.text = "R 1,350"
            cell?.cellImage.image = UIImage(named: "campsbay1")
            break
        case 10:
            cell?.titleLabel.text = "Adventure Pad"
            cell?.currRoomType = "adventurePad"
            cell?.priceLabel.text = "R 1,350"
            cell?.cellImage.image = UIImage(named: "campsbay2")
            break
        default:
            break
        }

        
        cell?.bookButton.addTarget(self, action: #selector(bookNowButtonTapped), forControlEvents: .TouchUpInside)
        
        return cell!
    }
    

    func bookNowButtonTapped() {
        let bookingVC = CalendarViewController(nibName: "CalendarViewController", bundle: nil)
//        let bookingVC = BookingViewController(nibName: "BookingViewController", bundle: nil)
        presentViewController(bookingVC, animated: true, completion: nil)
    }
    
}

extension BayHotelViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 200)
    }
}