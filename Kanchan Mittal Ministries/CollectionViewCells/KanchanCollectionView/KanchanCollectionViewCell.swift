//
//  KanchanCollectionViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 25/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class KanchanCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var sideImgView: UIImageView!
    @IBOutlet var titleLBl: UILabel!
    @IBOutlet var descriptionLbl: UILabel!
    @IBOutlet var expolreMoreBtn: UIButton!
    @IBOutlet var outerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        outerView.layer.cornerRadius = 10
        outerView.layer.borderWidth = 1.0
        outerView.layer.borderColor = UIColor.lightGray.cgColor
        outerView.clipsToBounds = true
        expolreMoreBtn.layer.cornerRadius = 5
        expolreMoreBtn.clipsToBounds = true
    }

}
