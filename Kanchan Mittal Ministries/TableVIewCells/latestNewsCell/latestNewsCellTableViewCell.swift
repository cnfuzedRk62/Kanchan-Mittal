//
//  latestNewsTableViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 24/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class latestNewsCellTableViewCell: UITableViewCell {
    
    @IBOutlet var newsimageView: UIImageView!
    @IBOutlet var newsDescriptionlbl: UILabel!
    @IBOutlet var readMoreBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
