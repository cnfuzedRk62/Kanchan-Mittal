//
//  SpeechBannerTableViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 13/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class SpeechBannerTableViewCell: UITableViewCell {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var outerView: UIView!
    var mySpeechArray_ = [MinistriesModel]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.registerXib()
        outerView.layer.cornerRadius = 10
        outerView.clipsToBounds = true
    }

    func registerXib(){
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "ImageCollectionViewCell")
         self.collectionView.delegate = self
         self.collectionView.dataSource = self
      }
    
    func reloadCollection() {
        self.collectionView.reloadData()
    }
    
}
extension SpeechBannerTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
}

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return mySpeechArray_.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        let ImageUrl = ((mySpeechArray_[indexPath.item].image_path ?? "") + (mySpeechArray_[indexPath.item].image ?? ""))
        cell.bannerImageView.sd_setImage(with: URL(string: ImageUrl), placeholderImage: #imageLiteral(resourceName: "place"))
        return cell
    }
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2 + 40, height: collectionView.frame.size.height - 10)
    }
    
}
