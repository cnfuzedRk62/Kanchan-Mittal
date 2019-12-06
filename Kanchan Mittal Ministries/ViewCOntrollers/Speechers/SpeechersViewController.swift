//
//  SpeechersViewController.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 16/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit
import ObjectMapper
class SpeechersViewController: UIViewController,ShowAlert {
    @IBOutlet var tableView2: UITableView!
    var refreshControl: UIRefreshControl!
    var mySpeechArray = [MinistriesModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "Speeches of The Church of Peace"
         self.navigationItem.backBarButtonItem?.title = ""
        self.tableView2.separatorStyle  = .none
        self.registerXib()
        if Reachability.isConnectedToNetwork() == true {
                self.refreshControlAPI()
          } else {
              self.showAlert(Constant.Messages.internetError)
        }
    }
    
    func registerXib() {

       tableView2.register(UINib(nibName: "Cell1TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell1TableViewCell")
    }

}

extension SpeechersViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySpeechArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell = self.tableView2.dequeueReusableCell(withIdentifier: "Cell1TableViewCell", for: indexPath) as! Cell1TableViewCell
            let ImageUrl = ((mySpeechArray[indexPath.item].image_path ?? "") + (mySpeechArray[indexPath.item].image ?? ""))
            cell.imageVIew_.sd_setImage(with: URL(string: ImageUrl), placeholderImage: #imageLiteral(resourceName: "place"))
        return cell
  
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  165
    }
}


extension SpeechersViewController {
    
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
                                         
                                self.tableView2.reloadData()
                                                 
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

