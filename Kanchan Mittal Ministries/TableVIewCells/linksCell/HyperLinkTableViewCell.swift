//
//  HyperLinkTableViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 26/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit
class HyperLinkTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLink: UILabel!
    
    @IBOutlet var linkLbl: ActiveLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
