//
//  PlayerTableViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 26/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView
class PlayerTableViewCell: UITableViewCell {
    
    @IBOutlet var playerView: WKYTPlayerView!
    var youtubeLink = ""
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupData() {
            print("latest url\(youtubeLink)")
            playerView.load(withVideoId: youtubeLink)
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
