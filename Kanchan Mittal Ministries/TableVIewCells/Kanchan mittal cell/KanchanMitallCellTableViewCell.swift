//
//  KanchanMitallCellTableViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 25/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class KanchanMitallCellTableViewCell: UITableViewCell {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var outerView: UIView!
    var ViewControllerObj : UIViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.registerXib()
     //   outerView.layer.borderColor = UIColor.lightGray.cgColor
//        outerView.layer.borderWidth = 1.0
        outerView.layer.cornerRadius = 10
        outerView.clipsToBounds = true
    }
    
    func registerXib(){
            collectionView.register(UINib(nibName: "KanchanCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "KanchanCollectionViewCell")
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
         }

    func reloadCollection() {
           self.collectionView.reloadData()
       }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension KanchanMitallCellTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
}

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "KanchanCollectionViewCell", for: indexPath) as! KanchanCollectionViewCell
       cell.expolreMoreBtn.addTarget(self, action: #selector(self.tapExplore(sender:)), for: .touchUpInside)
     //   let ImageUrl = ((mySpeechArray_[indexPath.item].image_path ?? "") + (mySpeechArray_[indexPath.item].image ?? ""))
     //   cell.bannerImageView.sd_setImage(with: URL(string: ImageUrl), placeholderImage: #imageLiteral(resourceName: "gallery"))
        return cell
    }
    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    @objc func tapExplore(sender: UIButton){
        
        let vc = self.ViewControllerObj?.storyboard?.instantiateViewController(withIdentifier: "DetailVcViewController") as! DetailVcViewController
           self.ViewControllerObj?.navigationController?.show(vc, sender: self)
    }
}
