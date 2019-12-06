//
//  QuetesViewController.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 14/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit
import ObjectMapper
class QuetesViewController: UIViewController,ShowAlert {

    @IBOutlet var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    var mySpeechArray = [MinistriesModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Motivational Quetes"
        self.navigationItem.backBarButtonItem?.title = ""
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "QuetesTableViewCell", bundle: nil), forCellReuseIdentifier: "QuetesTableViewCell")
        if Reachability.isConnectedToNetwork() == true {
                self.refreshControlAPI()
          } else {
              self.showAlert(Constant.Messages.internetError)
        }
        // Do any additional setup after loading the view.
    }
   
}

extension QuetesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySpeechArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "QuetesTableViewCell", for: indexPath) as! QuetesTableViewCell
            cell.quetesLbl.text = mySpeechArray[indexPath.row].content?.withoutHtmlTags
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension QuetesViewController {
  
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
      
      WebServiceClass.dataTask(urlName: Constant.Apis.baseUrl + Constant.Apis.getQuetes, method: "GET", params: "") { (isSucess, response, error) in
      
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

