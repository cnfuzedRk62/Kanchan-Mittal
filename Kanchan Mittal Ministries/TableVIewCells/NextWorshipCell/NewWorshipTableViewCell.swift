//
//  NewWorshipTableViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 13/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class NewWorshipTableViewCell: UITableViewCell {
    
    @IBOutlet var outerView: UIView!
    
    @IBOutlet var topHeadingLbl: UILabel!
    
    @IBOutlet var daysMentionedLbl: UILabel!
    
    @IBOutlet var joinOurLbl: UILabel!
    
    @IBOutlet var addressLBl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        outerView.layer.cornerRadius = 10
        outerView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
