//
//  LatestNewsDetailViewController.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 27/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class LatestNewsDetailViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var myNewsListObj : MinistriesModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerXib()
        // Do any additional setup after loading the view.
    }
    
    func registerXib() {
        tableView.separatorStyle = .none
        self.tableView.estimatedRowHeight = 300
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        tableView.register(UINib(nibName: "NewsDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsDescriptionTableViewCell")
        
    }

}

extension LatestNewsDetailViewController : UITableViewDataSource, UITableViewDelegate {
    
    
      func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 2
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
                   cell.titleLbl.text = (myNewsListObj?.name ?? "").withoutHtmlTags
                   let ImageUrl = ((myNewsListObj?.image_path ?? "") + (myNewsListObj?.image ?? ""))
                   cell.newsImageView.sd_setImage(with: URL(string: ImageUrl), placeholderImage: #imageLiteral(resourceName: "place"))
                   return cell
        }else {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "NewsDescriptionTableViewCell", for: indexPath) as! NewsDescriptionTableViewCell
                cell.descriptionLbl.text = (myNewsListObj?.content ?? "").withoutHtmlTags
                   return cell
        }
   
      }
      
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 300 : UITableView.automaticDimension
      }
  
}
