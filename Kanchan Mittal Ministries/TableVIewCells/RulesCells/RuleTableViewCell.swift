//
//  RuleTableViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 13/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class RuleTableViewCell: UITableViewCell {
    
    @IBOutlet var headingLbl: UILabel!
    @IBOutlet var headingDescriptionLbl: UILabel!
    @IBOutlet var sideImageView: UIImageView!
    
    @IBOutlet var outerView: UIView!
    @IBOutlet var bottomCon: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
