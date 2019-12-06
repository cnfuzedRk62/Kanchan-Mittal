//
//  LatestNewsTableViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 13/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit
import ObjectMapper
class LatestNewsTableViewCell: UITableViewCell,ShowAlert {
    
    @IBOutlet var viewAllBtn: UIButton!
    @IBOutlet var bgView: UIView!
    @IBOutlet var latestTextlbl: UILabel!
    @IBOutlet var tableView: UITableView!
    var myNewsList_ = [MinistriesModel]()
    var navObj : UIViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = 10
        bgView.clipsToBounds = true
        self.registerXib()
    }
    
    func registerXib() {
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "latestNewsCellTableViewCell", bundle: nil), forCellReuseIdentifier: "latestNewsCellTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension LatestNewsTableViewCell : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myNewsList_.count > 3 {
             return 3
        }else if myNewsList_.count < 3 {
            return myNewsList_.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "latestNewsCellTableViewCell", for: indexPath) as! latestNewsCellTableViewCell
            cell.newsDescriptionlbl.text = (myNewsList_[indexPath.row].name ?? "").withoutHtmlTags
            let ImageUrl = ((myNewsList_[indexPath.row].image_path ?? "") + (myNewsList_[indexPath.row].image ?? ""))
            cell.newsimageView.sd_setImage(with: URL(string: ImageUrl), placeholderImage: #imageLiteral(resourceName: "place"))
            cell.readMoreBtn.addTarget(self, action: #selector(self.tapReadMore(sender:)), for: .touchUpInside)
            cell.readMoreBtn.tag = indexPath.row
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = self.navObj?.storyboard?.instantiateViewController(withIdentifier: "LatestnewsViewController") as! LatestnewsViewController
           self.navObj?.navigationController?.show(VC, sender: self)
    }
    
     @objc func tapReadMore(sender: UIButton){
        let vc = navObj?.storyboard?.instantiateViewController(withIdentifier: "LatestNewsDetailViewController") as! LatestNewsDetailViewController
             vc.myNewsListObj = myNewsList_[sender.tag]
            navObj?.navigationController?.show(vc, sender: self)
    }
  
}
