//
//  linkTableViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 26/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class linkTableViewCell: UITableViewCell,ShowAlert {
    
    @IBOutlet var topLbl: UILabel!
    
    @IBOutlet var subscribeLbl: UILabel!
    
    @IBOutlet var tableVIew: UITableView!
    
    var mainTitle = ["YouTube Channel","Facebook","Website","Instagram","Twitter"]
    var subLinks = ["https://www.youtube.com/channel/UCkktZ2f5_RIPFvlYwWkentA/featured","https://www.facebook.com/kanchanmittalministries","http://www.kanchanmittal.com","https://www.instagram.com/ps_kanchan_mittal/","https://twitter.com/pastorkanchan"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.registerXib()
        self.tableVIew.delegate = self
        self.tableVIew.dataSource = self
    }
    
    func registerXib() {
        tableVIew.register(UINib(nibName: "HyperLinkTableViewCell", bundle: nil), forCellReuseIdentifier: "HyperLinkTableViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension linkTableViewCell : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableVIew.dequeueReusableCell(withIdentifier: "HyperLinkTableViewCell") as! HyperLinkTableViewCell
        cell.titleLink.text = mainTitle[indexPath.row]
        cell.linkLbl.text = subLinks[indexPath.row]
        cell.linkLbl.handleURLTap {
            self.alert("URL", message: $0.absoluteString)
        }
        return cell
    }
    
    func alert(_ title: String, message: String) {
           if title == "URL" {
               print(message)
            guard let url = URL(string: message) else { return }
            UIApplication.shared.open(url)
           }
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
