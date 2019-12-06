//
//  HomeViewController.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 12/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit
import ObjectMapper
class HomeViewController: UIViewController,UIGestureRecognizerDelegate,ShowAlert {

    var innerCellHeight:CGFloat = 0.0
    var innerCell:BottomListTableViewCell?
    
    @IBOutlet var tableView: UITableView!
    let transition = SlideTransition()
    var refreshControl: UIRefreshControl!
    var myBannerModel = [BannerImageBanners]()
    var myMinistryArray = [MinistriesModel]()
    var myNewsList = [MinistriesModel]()
    var mySpeechArray = [MinistriesModel]()
    var myDataDict = Dictionary<String,AnyObject>()
    var totalHeight :CGSize = CGSize(width: 10, height: 10)
    var height:CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "onBoardingKey")
        registerXib()
        if Reachability.isConnectedToNetwork() == true {
             self.refreshControlAPI()
             self.nextWorship()
             self.getMinistries()
             self.latestNews()
             self.getSpeech()
            } else {
             self.showAlert(Constant.Messages.internetError)
        }
    }
 
    override func viewDidLayoutSubviews() {
         self.tableView.layoutIfNeeded()
    }
    
  func registerXib() {
    
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ImagesTableViewCell", bundle: nil), forCellReuseIdentifier: "ImagesTableViewCell")
        tableView.register(UINib(nibName: "LatestNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "LatestNewsTableViewCell")
        tableView.register(UINib(nibName: "SpeechBannerTableViewCell", bundle: nil), forCellReuseIdentifier: "SpeechBannerTableViewCell")
        tableView.register(UINib(nibName: "NewWorshipTableViewCell", bundle: nil), forCellReuseIdentifier: "NewWorshipTableViewCell")
         tableView.register(UINib(nibName: "BottomListTableViewCell", bundle: nil), forCellReuseIdentifier: "BottomListTableViewCell")
         tableView.register(UINib(nibName: "RuleTableViewCell", bundle: nil), forCellReuseIdentifier: "RuleTableViewCell")
         tableView.register(UINib(nibName: "KanchanMitallCellTableViewCell", bundle: nil), forCellReuseIdentifier: "KanchanMitallCellTableViewCell")
    
        tableView.tableFooterView = UIView()
    
    }
    
    
    @IBAction func tapMenuAction(_ sender: Any) {
        let object = self.storyboard?.instantiateViewController(withIdentifier: "menuController") as! menuController
            object.modalPresentationStyle = .overFullScreen
            object.transitioningDelegate = self
            object.navVc = self.navigationController
        self.navigationController?.present(object, animated: true, completion: nil)
    }
}

extension HomeViewController : UITableViewDelegate,UITableViewDataSource {
    
    var constantRows : Int {
        return 6
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.constantRows + myMinistryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
             let cell = self.tableView.dequeueReusableCell(withIdentifier: "ImagesTableViewCell", for: indexPath) as! ImagesTableViewCell
                cell.BannerImagesModel = myBannerModel
                return cell
        case 1:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "LatestNewsTableViewCell", for: indexPath) as! LatestNewsTableViewCell
                cell.viewAllBtn.addTarget(self, action: #selector(self.tapViewAll(sender:)), for: .touchUpInside)
                cell.myNewsList_ = myNewsList
                cell.navObj = self
                cell.tableView.reloadData()
                return cell
            
        case 2:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "SpeechBannerTableViewCell", for: indexPath) as! SpeechBannerTableViewCell
                cell.mySpeechArray_ = mySpeechArray
                cell.reloadCollection()
                return cell
        case 3:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "KanchanMitallCellTableViewCell", for: indexPath) as! KanchanMitallCellTableViewCell
                cell.ViewControllerObj = self
               return cell
        case 4:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "NewWorshipTableViewCell", for: indexPath) as! NewWorshipTableViewCell
                cell.addressLBl.text = (myDataDict["address"] as? String ?? "").withoutHtmlTags
                cell.daysMentionedLbl.text = myDataDict["wdate"] as? String ?? ""
                cell.topHeadingLbl.text =  myDataDict["title"] as? String ?? ""
                cell.joinOurLbl.text =  myDataDict["subtitle"] as? String ?? ""
                return cell
        case 5:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "BottomListTableViewCell", for: indexPath) as! BottomListTableViewCell
            cell.outerView.clipsToBounds = true
            cell.outerView.layer.cornerRadius = 10
            cell.outerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            return cell

        default:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "RuleTableViewCell", for: indexPath) as! RuleTableViewCell
            let model = myMinistryArray[indexPath.row - self.constantRows]
            cell.headingLbl.text = model.name
            cell.headingDescriptionLbl.text = model.content?.withoutHtmlTags
            let ImageUrl = ((model.image_path ?? "") + (model.image ?? ""))
            cell.sideImageView.sd_setImage(with: URL(string: ImageUrl), placeholderImage: #imageLiteral(resourceName: "place"))
            cell.outerView.clipsToBounds = true
            cell.outerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

            if indexPath.row - self.constantRows == myMinistryArray.count - 1 {
                cell.outerView.layer.cornerRadius = 10
                cell.bottomCon.constant = 10
            } else {
                cell.outerView.layer.cornerRadius = 0
                cell.bottomCon.constant = 0
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 250
        case 1:
            switch myNewsList.count {
            case 0:
                return 70
            case 1:
                return 170
            case 2:
                return 270
            case 3:
                return 370
            default:
                return 370
            }
        case 2:
            return 300
        case 3:
            return 330
        case 4:
            return UITableView.automaticDimension
        case 5:
            return 90
        default:
            return UITableView.automaticDimension
           // return 1000
            
        }
    }
    
    @objc func tapViewAll(sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LatestnewsViewController") as! LatestnewsViewController
            self.navigationController?.show(vc, sender: self)
       }
 
}

//MARK:- UIViewControllerTransitioningDelegate
extension HomeViewController : UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transition.isPresenting = false
        return transition
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transition.isPresenting = true
        return transition
    }
}

extension HomeViewController {
    
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
        
        WebServiceClass.dataTask(urlName: Constant.Apis.baseUrl + Constant.Apis.getSliderImages, method: "GET", params: "") { (isSucess, response, error) in
        
            if isSucess == true {
                 print(response)
                self.refreshControl.endRefreshing()
                    if let jsonResult = response as? Dictionary<String, AnyObject> {
                        print(response)
                        if let mainObject = jsonResult["response"] as? [Dictionary<String, AnyObject>] {
                            
                            if let _ = mainObject[0]["success"] as? Bool , isSucess == true {
                                
                                if let innerObject = mainObject[0]["data"] as? [Dictionary<String, AnyObject>]{
                                    for bannerImagesObj in innerObject {
                                           if let bannerImageObj = Mapper<BannerImageBanners>().map(JSONObject: bannerImagesObj) {
                                           self.myBannerModel.append(bannerImageObj)
                                    }
                                }
                            }
                                DispatchQueue.main.async {
                                    self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
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
        }else {
                self.showAlert(Constant.Messages.internalServerError)
        }
    }
  }
    
 // Mark:- Get Live worship
    
    func nextWorship(){
          
          WebServiceClass.dataTask(urlName: Constant.Apis.baseUrl + Constant.Apis.getLiveWorship, method: "GET", params: "") { (isSucess, response, error) in
          
              if isSucess == true {
                  self.refreshControl.endRefreshing()
                      if let jsonResult = response as? Dictionary<String, AnyObject> {
                          print(response)
                          if let mainObject = jsonResult["response"] as? [Dictionary<String, AnyObject>] {
                              
                              if let _ = mainObject[0]["success"] as? Bool , isSucess == true {
                                
                                if let innerObject = mainObject[0]["data"] as? [Dictionary<String, AnyObject>]{
                                    
                                    self.myDataDict["address"] = innerObject[0]["address"] as? String as AnyObject?
                                    self.myDataDict["id"] = innerObject[0]["id"] as? Int as AnyObject?
                                    self.myDataDict["subtitle"] = innerObject[0]["subtitle"] as? String as AnyObject?
                                    self.myDataDict["title"] = innerObject[0]["title"] as? String as AnyObject?
                                    self.myDataDict["wdate"] = innerObject[0]["wdate"] as? String as AnyObject?
                                    self.myDataDict["wtime"] = innerObject[0]["wtime"] as? String as AnyObject?
                                    let Date_ = (self.myDataDict["wdate"] as? String)?.toDate()
                                    let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "EEEE"
                                    let weekDay = dateFormatter.string(from: Date_ ?? Date())
                                        
                                    print(weekDay)
                                    self.myDataDict["wdate"] = weekDay as String as AnyObject ?? "" as AnyObject
                                  
                                    print("CompleteDict\(self.myDataDict)")
                                    self.tableView.reloadRows(at: [IndexPath(row: 4, section: 0)], with: .none)
                                    
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
          }else {
                  self.showAlert(Constant.Messages.internalServerError)
          }
      }
        
    }
 
    
  // Get Ministries
  func getMinistries() {
        
    WebServiceClass.dataTask(urlName: Constant.Apis.baseUrl + Constant.Apis.getMinistry, method: "GET", params: "") { (isSucess, response, error) in
    
        if isSucess == true {
             print(response)
            self.refreshControl.endRefreshing()
           if let mainObject = response["response"] as? [Dictionary<String, AnyObject>] {
            
            if let _ = mainObject[0]["success"] as? Bool , isSucess == true {
              
              if let innerObject = mainObject[0]["data"] as? [Dictionary<String, AnyObject>]{
                
                    for mainObj in innerObject {
                          if let MinistryObj = Mapper<MinistriesModel>().map(JSONObject: mainObj) {
                          self.myMinistryArray.append(MinistryObj)
                   }
                     
                        self.tableView.reloadData()
                 }
                
               }
            }else{
                self.showAlert(Constant.Messages.internalServerError)
            }
        }else {
            self.showAlert(Constant.Messages.internalServerError)
        }
    }
   }
  }
    
  // latest News
    
    func latestNews() {
          
      WebServiceClass.dataTask(urlName: Constant.Apis.baseUrl + Constant.Apis.getLatestNews, method: "GET", params: "") { (isSucess, response, error) in
      print(Constant.Apis.baseUrl + Constant.Apis.getLatestNews)
          if isSucess == true {
             print(response)
              self.refreshControl.endRefreshing()
             if let mainObject = response["response"] as? [Dictionary<String, AnyObject>] {
              
              if let _ = mainObject[0]["success"] as? Bool , isSucess == true {
                
                if let innerObject = mainObject[0]["data"] as? [Dictionary<String, AnyObject>]{
                  
                      for mainObj in innerObject {
                            if let MinistryObj = Mapper<MinistriesModel>().map(JSONObject: mainObj) {
                            self.myNewsList.append(MinistryObj)
                     }
                      self.tableView.reloadData()
                   }
                  
                 }
              }else{
                  self.showAlert(Constant.Messages.internalServerError)
              }
          }else {
              self.showAlert(Constant.Messages.internalServerError)
          }
      }
     }
    }
    
    // get speech
    
    func getSpeech(){
        
        WebServiceClass.dataTask(urlName: Constant.Apis.baseUrl + Constant.Apis.getSpeech, method: "GET", params: "") { (isSucess, response, error) in
        
            if isSucess == true {
                self.refreshControl.endRefreshing()
                    if let jsonResult = response as? Dictionary<String, AnyObject> {
                        print(response)
                        if let mainObject = jsonResult["response"] as? [Dictionary<String, AnyObject>] {
                            
                             if let innerObject = mainObject[0]["data"] as? [Dictionary<String, AnyObject>]{
                                         
                                 for mainObj in innerObject {
                                       if let MinistryObj = Mapper<MinistriesModel>().map(JSONObject: mainObj) {
                                       self.mySpeechArray.append(MinistryObj)
                                }
                                         
                               self.tableView.reloadData()
                                                 
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

extension String {
    var withoutHtmlTags: String {
      return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    func toDate(withFormat format: String = "yyyy-MM-dd")-> Date?{
           let dateFormatter = DateFormatter()
           dateFormatter.timeZone = TimeZone(identifier: "UTC")
           dateFormatter.locale = Locale(identifier: "fa-IR")
           dateFormatter.calendar = Calendar(identifier: .gregorian)
           dateFormatter.dateFormat = format
           let date = dateFormatter.date(from: self)
           return date
       }
}
