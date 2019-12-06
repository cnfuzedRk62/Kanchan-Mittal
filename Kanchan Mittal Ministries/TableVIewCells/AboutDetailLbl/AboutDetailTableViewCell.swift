//
//  AboutDetailTableViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 17/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class AboutDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var innerVIew: UIView!
    
    @IBOutlet var headingLbl: UILabel!
    
    @IBOutlet var lableDetail: UILabel!
    
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
