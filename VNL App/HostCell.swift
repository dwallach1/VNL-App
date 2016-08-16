//
//  HostCell.swift
//  VNL App
//
//  Created by David Wallach on 8/16/16.
//  Copyright © 2016 TCA. All rights reserved.
//

import UIKit

class HostCell: UITableViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(colorLiteralRed: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)

        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
