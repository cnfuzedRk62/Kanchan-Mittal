//
//  LiveTableViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 26/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class LiveTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLb: UILabel!
    
    @IBOutlet var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
