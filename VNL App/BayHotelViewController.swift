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
            cell?.descriptionTextView.text = "Expansive views of Table Mountain and the Twelve Apostles mountain range."
            break
        case 1:
            cell?.titleLabel.text = "Classic Room"
            cell?.currRoomType = "classic"
            cell?.priceLabel.text = "R 1,100"
            cell?.cellImage.image = UIImage(named: "campsbay2")
            cell?.descriptionTextView.text = "Located around the main pool deck, these rooms offer direct access to the pool from a private patio."
            break
        case 2:
            cell?.titleLabel.text = "Club Classic Room"
            cell?.currRoomType = "clubClassic"
            cell?.priceLabel.text = "R 1,100"
            cell?.cellImage.image = UIImage(named: "campsbay3")
            cell?.descriptionTextView.text = "North-facing with views of Lion’s Head and partial sea views. Features two accessibility rooms with wheelchair access."
            break
        case 3:
            cell?.titleLabel.text = "Premier Mountain Room"
            cell?.currRoomType = "premierMountain"
            cell?.priceLabel.text = "R 1,200"
            cell?.cellImage.image = UIImage(named: "campsbay1")
            cell?.descriptionTextView.text = "These double-sized rooms feature private spa baths and magni cent views of the Twelve Apostles mountain range."
            break
        case 4:
            cell?.titleLabel.text = "Premier Pool Room"
            cell?.currRoomType = "premierPool"
            cell?.priceLabel.text = "R 1,200"
            cell?.cellImage.image = UIImage(named: "campsbay2")
            cell?.descriptionTextView.text = "North-facing rooms with spacious balconies, views of Lion’s Head and partial sea views overlooking the pool area."
            break
        case 5:
            cell?.titleLabel.text = "Premier Sea Room"
            cell?.currRoomType = "premierSea"
            cell?.priceLabel.text = "R 1,350"
            cell?.cellImage.image = UIImage(named: "campsbay3")
            cell?.descriptionTextView.text = "Direct sea views overlooking the Atlantic Ocean which can be enjoyed from a private balcony."
            break
        case 6:
            cell?.titleLabel.text = "Cabana Room"
            cell?.currRoomType = "cabana"
            cell?.priceLabel.text = "R 1,350"
            cell?.cellImage.image = UIImage(named: "campsbay1")
            cell?.descriptionTextView.text = "Located on the ground  oor with a spacious patio, sea views and direct access to two cabana pools."
            break
        case 7:
            cell?.titleLabel.text = "Luxury Room"
            cell?.currRoomType = "luxury"
            cell?.priceLabel.text = "R 1,200"
            cell?.cellImage.image = UIImage(named: "campsbay2")
            cell?.descriptionTextView.text = "Spacious sea-facing rooms with a comfortable private balcony and outdoor spa bath."
            break
        case 8:
            cell?.titleLabel.text = "Suite"
            cell?.currRoomType = "suite"
            cell?.priceLabel.text = "R 1,200"
            cell?.cellImage.image = UIImage(named: "campsbay3")
            cell?.descriptionTextView.text = "Each individually styled Suite offers spacious interiors, an outdoor spa bath and two balconies with delightful sea views."
            break
        case 9:
            cell?.titleLabel.text = "Penthouse"
            cell?.currRoomType = "penthouse"
            cell?.priceLabel.text = "R 1,350"
            cell?.cellImage.image = UIImage(named: "campsbay1")
            cell?.descriptionTextView.text = "With expansive and luxurious interiors, the Penthouse is 160 m2 of sheer sea-facing splendour."
            break
        case 10:
            cell?.titleLabel.text = "Adventure Pad"
            cell?.currRoomType = "adventurePad"
            cell?.priceLabel.text = "R 1,350"
            cell?.cellImage.image = UIImage(named: "campsbay2")
            cell?.descriptionTextView.text = "With expansive and luxurious interiors, the Penthouse is 160 m2 of sheer sea-facing splendour."
            break
        default:
            break
        }

        
        cell?.bookButton.addTarget(self, action: #selector(bookNowButtonTapped), forControlEvents: .TouchUpInside)
        
        return cell!
    }
    

    func bookNowButtonTapped() {
        let bookingVC = CalendarViewController(nibName: "CalendarViewController", bundle: nil)
        presentViewController(bookingVC, animated: true, completion: nil)
    }
    
}

extension BayHotelViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 200)
    }
}