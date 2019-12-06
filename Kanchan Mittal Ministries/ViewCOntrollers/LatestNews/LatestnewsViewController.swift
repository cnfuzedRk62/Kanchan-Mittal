//
//  LatestnewsViewController.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 27/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit
import ObjectMapper
class LatestnewsViewController: UIViewController,ShowAlert {
    
    @IBOutlet var tableView: UITableView!
     var myNewsList_ = [MinistriesModel]()
     var refreshControl: UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Latest News"
        self.navigationItem.backBarButtonItem?.title = ""
        self.tableView.separatorStyle = .none
        self.registerXib()
        self.latestNews()
        // Do any additional setup after loading the view.
    }
    
    func registerXib() {
        
        tableView.register(UINib(nibName: "latestNewsCellTableViewCell", bundle: nil), forCellReuseIdentifier: "latestNewsCellTableViewCell")
    }
}
extension LatestnewsViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myNewsList_.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "latestNewsCellTableViewCell", for: indexPath) as! latestNewsCellTableViewCell
        cell.newsDescriptionlbl.text = (myNewsList_[indexPath.row].name ?? "").withoutHtmlTags
        let ImageUrl = ((myNewsList_[indexPath.row].image_path ?? "") + (myNewsList_[indexPath.row].image ?? ""))
        cell.newsimageView.sd_setImage(with: URL(string: ImageUrl), placeholderImage: #imageLiteral(resourceName: "place"))
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "LatestNewsDetailViewController") as! LatestNewsDetailViewController
               vc.myNewsListObj = myNewsList_[indexPath.row]
           self.navigationController?.show(vc, sender: self)
    }
    
    // latest News
          
          func latestNews() {
                
            WebServiceClass.dataTask(urlName: Constant.Apis.baseUrl + Constant.Apis.getLatestNews, method: "GET", params: "") { (isSucess, response, error) in
            print(Constant.Apis.baseUrl + Constant.Apis.getLatestNews)
                if isSucess == true {
                   print(response)
                   if let mainObject = response["response"] as? [Dictionary<String, AnyObject>] {
                    
                    if let _ = mainObject[0]["success"] as? Bool , isSucess == true {
                      
                      if let innerObject = mainObject[0]["data"] as? [Dictionary<String, AnyObject>]{
                        
                            for mainObj in innerObject {
                                  if let MinistryObj = Mapper<MinistriesModel>().map(JSONObject: mainObj) {
                                  self.myNewsList_.append(MinistryObj)
                           }
                           self.tableView.separatorStyle = .singleLine
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
    
    
}
