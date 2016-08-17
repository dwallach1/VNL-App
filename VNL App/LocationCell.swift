//
//  CampsBayTableViewCell.swift
//  VNL App
//
//  Created by David Wallach on 8/10/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.VNLBlue()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
