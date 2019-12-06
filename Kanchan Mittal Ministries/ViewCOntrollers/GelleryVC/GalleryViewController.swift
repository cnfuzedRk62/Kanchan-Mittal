//
//  GalleryViewController.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 16/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit
import ObjectMapper
class GalleryViewController: UIViewController,ShowAlert {
    @IBOutlet var collectionView: UICollectionView!
    var refreshControl: UIRefreshControl!
    var myGellryArray = [GalleryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Gallery"
        self.navigationItem.backBarButtonItem?.title = ""
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.registerXib()
        if Reachability.isConnectedToNetwork() == true {
                self.refreshControlAPI()
          } else {
             self.showAlert(Constant.Messages.internetError)
        }
        // Do any additional setup after loading the view.
    }
    
    func registerXib(){
        collectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "GalleryCollectionViewCell")
    }

}
extension GalleryViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return myGellryArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
          cell.contentView.layer.cornerRadius = 10
          cell.contentView.clipsToBounds = true
          let ImageUrl = ((myGellryArray[indexPath.item].image_path ?? "") + (myGellryArray[indexPath.item].image_name ?? ""))
          cell.imageIVew_.sd_setImage(with: URL(string: ImageUrl), placeholderImage: #imageLiteral(resourceName: "place"))
          cell.imageIVew_.clipsToBounds = true
          return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

      let noOfCellsInRow = 3
      let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
      let totalSpace = flowLayout.sectionInset.left
          + flowLayout.sectionInset.right
          + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
      let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
      return CGSize(width: size, height: size)
  }
    
}
  
extension GalleryViewController {
        
        func refreshControlAPI() {
           self.refreshControl = UIRefreshControl()
           self.manuallyRefreshTableView()
        }
        
        func manuallyRefreshTableView() {
              //First time automatically refreshing.
              self.refreshControl.beginRefreshingManually()
              self.perform(#selector(self.reloadAPI), with: nil, afterDelay: 0)
           }
        
        //MARK:- Service Functions
        @objc func reloadAPI() {
            
            WebServiceClass.dataTask(urlName: Constant.Apis.baseUrl + Constant.Apis.getGalery, method: "GET", params: "") { (isSucess, response, error) in
            
                if isSucess == true {
                    self.refreshControl.endRefreshing()
                        if let jsonResult = response as? Dictionary<String, AnyObject> {
                            print(response)
                            if let mainObject = jsonResult["response"] as? [Dictionary<String, AnyObject>] {
                                
                                 if let innerObject = mainObject[0]["data"] as? [Dictionary<String, AnyObject>]{
                                             
                                     for mainObj in innerObject {
                                           if let MinistryObj = Mapper<GalleryModel>().map(JSONObject: mainObj) {
                                           self.myGellryArray.append(MinistryObj)
                                    }
                                             
                                    self.collectionView.reloadData()
                                     
                                }
                        }
                    }else{
                        self.showAlert(Constant.Messages.errorMessage)
                   }
                }else{
                         self.showAlert(Constant.Messages.errorMessage)
                    }
                }else{
                    self.showAlert(Constant.Messages.internalServerError)
                }
            }
        }
  
}
