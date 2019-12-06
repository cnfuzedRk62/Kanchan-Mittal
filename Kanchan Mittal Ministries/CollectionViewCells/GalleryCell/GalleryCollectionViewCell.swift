//
//  GalleryCollectionViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 16/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageIVew_: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageIVew_.layer.cornerRadius = 25
        imageIVew_.clipsToBounds = true
    }

}
