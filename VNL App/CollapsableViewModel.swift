////
////  CollapsableViewModel.swift
////  VNL App
////
////  Created by David Wallach on 8/5/16.
////  Copyright © 2016 TCA. All rights reserved.
////

import Foundation
import UIKit

class CollapsibleViewModel {
    let label: String
    let image: UIImage?
    let childTag: Int
    let children: [CollapsibleViewModel]
    var isCollapsed: Bool
    var needsSeparator: Bool = false
    
    init(label: String, image: UIImage? = nil, children: [CollapsibleViewModel] = [], isCollapsed: Bool = true, childTag: Int = 10) {
        self.label = label
        self.image = image
        self.children = children
        self.isCollapsed = isCollapsed
        self.childTag = childTag
        
        for child in self.children {
            child.needsSeparator = false
        }
        self.children.last?.needsSeparator = false
    }
}

class CollapsibleTableViewCell: UITableViewCell {
    let separator = UIView(frame: CGRectZero)
    
    func configure(viewModel: CollapsibleViewModel) {
        self.textLabel?.text = viewModel.label
        self.tag = viewModel.childTag
        if(viewModel.needsSeparator) {
            separator.backgroundColor = UIColor.grayColor()
            contentView.addSubview(separator)
        } else {
            separator.removeFromSuperview()
        }
    }
    
    let dropdownButton = UIButton()
    
    func addButton() {
        dropdownButton.tag = -1
        dropdownButton.frame = self.frame
        let contentrect = dropdownButton.contentRectForBounds(CGRect(x: self.frame.width - 20, y: self.frame.height / 2, width: 60, height: 60))
        
//            (frame: CGRect(x: self.frame.width - 20, y: self.frame.height / 2, width: 60, height: 60))
//        dropdownButton.setImage(UIImage(named: "dropDownIcon"), forState: .Normal)
//        dropdownButton.imageView?.frame = (frame: CGRect(x: self.frame.width - 20, y: self.frame.height / 2, width: 60, height: 60))
//        dropdownButton.imageView?.image = UIImage(named: "dropDownIcon")
        dropdownButton.tintColor = UIColor.whiteColor()
        dropdownButton.addTarget(self, action: #selector(addButtonTapped), forControlEvents: .TouchUpInside)
        self.addSubview(dropdownButton)
        self.bringSubviewToFront(dropdownButton)
    }
    
    func addButtonTapped(){
        if dropdownButton.tag == -1 {
            dropdownButton.setImage(UIImage(named: "upIcon"), forState: .Normal)
            dropdownButton.tag = 1
            
            return
        }
        dropdownButton.tag = -1
        dropdownButton.setImage(UIImage(named: "dropDownIcon"), forState: .Normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let separatorHeight = 1 / UIScreen.mainScreen().scale
        separator.frame = CGRectMake(separatorInset.left, contentView.bounds.height - separatorHeight, contentView.bounds.width-separatorInset.left-separatorInset.right, separatorHeight)
    }

}


