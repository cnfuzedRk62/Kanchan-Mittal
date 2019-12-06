//
//  QuetesTableViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 16/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class QuetesTableViewCell: UITableViewCell {
    
    @IBOutlet var quetesLbl: UILabel!
    @IBOutlet var innerVIew: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        innerVIew.layer.cornerRadius = 10
        innerVIew.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
