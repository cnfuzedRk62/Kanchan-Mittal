//
//  BottomListTableViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 13/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit
class BottomListTableViewCell: UITableViewCell {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var outerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
