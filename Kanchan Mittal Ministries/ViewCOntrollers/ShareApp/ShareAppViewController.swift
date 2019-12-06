//
//  ShareAppViewController.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 17/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class ShareAppViewController: UIViewController {

    @IBOutlet var shareAppBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Share App"
        self.navigationItem.backBarButtonItem?.title = ""
        self.shareAppBtn.layer.cornerRadius = 20
        self.shareAppBtn.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
  
    @IBAction func tapShareBtn(_ sender: Any) {
        
        // text to share
              let text = "Kanchan Mittal Ministry App."

              // set up activity view controller
              let textToShare = [ text ]
              let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
              activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

              // exclude some activity types from the list (optional)
             activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]

              // present the view controller
              self.present(activityViewController, animated: true, completion: nil)
    }
    

}
