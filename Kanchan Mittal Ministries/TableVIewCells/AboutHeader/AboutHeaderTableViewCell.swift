//
//  AboutHeaderTableViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 17/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class AboutHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet var imageView_: UIImageView!
    
    @IBOutlet var pastorLBl: UILabel!
    @IBOutlet var aboutLbl: UILabel!
    @IBOutlet var underLineView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
