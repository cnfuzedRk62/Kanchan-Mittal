//
//  ImageCollectionViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 13/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var bannerImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bannerImageView.layer.cornerRadius = 5
        bannerImageView.clipsToBounds = true
    }

}
