//
//  SideMenuTableViewCell.swift
//  VNL App
//
//  Created by David Wallach on 8/4/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        print("\(selected), & \(AppState.sharedInstance.screen))")
//        
//        if AppState.sharedInstance.screen == AppState.sharedInstance.selectedCell {
//            self.backgroundColor = UIColor.VNLBlue()
//        } else {
//            self.backgroundColor = UIColor.VNLDarkBlue()
//        }
        
        
    }
    

    
}
