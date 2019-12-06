//  OnboardingViewController.swift
//  ProjectXP
//  Created by Mandeep Singh on 07/12/18.
//  Copyright © 2018 Mandeep Singh. All rights reserved.

import UIKit

class OnboardingInroViewController: UIViewController {
    
    let imageArray = [#imageLiteral(resourceName: "onboard1"),#imageLiteral(resourceName: "onboard2"),#imageLiteral(resourceName: "onboard3")]
  //  let titleInfoArray = ["Find events near you!","Raise charity!","Make your business featured!"]
 //   let detailInfoArray = ["You can easily find or create any public/private events near you","You can make donation or raise charity through MAD events","You can promote or make business using XP"]
    
    @IBOutlet weak var onBoardingCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var skipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.isHidden = true
        self.pageControl.hidesForSinglePage = true
        self.pageControl.numberOfPages = imageArray.count
        
        self.pageControl.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        //Register Nibs.
        self.onBoardingCollectionView.register(UINib(nibName: "OnBoardingViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "OnBoardingViewCell")
    }
    
    @IBAction func skipAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionOnGetStarted(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension OnboardingInroViewController: UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "OnBoardingViewCell", for: indexPath) as! OnBoardingViewCell
        cell.getstartedBtn.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
        
        switch indexPath.item {
        case 0:
            print("zero index")
            cell.view1.isHidden = false
            cell.view2.isHidden = true
            cell.view3.isHidden = true
        case 1:
            print("1st index")
            cell.view1.isHidden = true
            cell.view2.isHidden = false
            cell.view3.isHidden = true
        default:
            print("2st index")
            cell.view1.isHidden = true
            cell.view2.isHidden = true
            cell.view3.isHidden = false
        }
        cell.postImage.image = imageArray[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    
    @objc func connected(sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyTabViewController") as! MyTabViewController
        self.navigationController?.show(vc, sender: self)
    }
    
    //ScrollView delegate method
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        self.pageControl.currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
      //  self.skipButton.isHidden = self.pageControl.currentPage == 2 ? true  : false
        
    }
    
    
}
