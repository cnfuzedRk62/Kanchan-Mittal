//
//  Cell1TableViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 16/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class Cell1TableViewCell: UITableViewCell {
    
    @IBOutlet var imageVIew_: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageVIew_.layer.cornerRadius = 10
        imageView?.clipsToBounds = true
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
