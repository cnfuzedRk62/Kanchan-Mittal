//
//  PaosterVC.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 17/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class PaosterVC: UIViewController {
    @IBOutlet var tableVIew: UITableView!
    var checkAbout = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = checkAbout == false ? "Pastor Kanchan Mittal" : "About Ministry"
        self.navigationItem.backBarButtonItem?.title = ""
        self.registerXib()
        self.tableVIew.estimatedRowHeight = 300
        // Do any additional setup after loading the view.
    }
    
    func registerXib() {
        tableVIew.separatorStyle = .none
        tableVIew.register(UINib(nibName: "AboutHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutHeaderTableViewCell")
        tableVIew.register(UINib(nibName: "AboutDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "AboutDetailTableViewCell")
    }

}

extension PaosterVC : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        switch indexPath.row {
        case 0:
              let cell = self.tableVIew.dequeueReusableCell(withIdentifier: "AboutHeaderTableViewCell", for: indexPath) as! AboutHeaderTableViewCell
              if checkAbout == true {
                cell.pastorLBl.isHidden = true
                cell.aboutLbl.isHidden = true
                cell.underLineView.isHidden = true
                cell.imageView_.contentMode = .scaleAspectFit
              }
                  cell.imageView_.image = checkAbout == false ?  #imageLiteral(resourceName: "paosterHead") :  #imageLiteral(resourceName: "collection")
              return cell
        default:
              let cell = self.tableVIew.dequeueReusableCell(withIdentifier: "AboutDetailTableViewCell", for: indexPath) as! AboutDetailTableViewCell
              if checkAbout == false {
                cell.lableDetail.text = Constant.longText.aboutText
                cell.headingLbl.text = "About me"
              }else{
                 cell.lableDetail.text = Constant.longText.paosterText
                 cell.headingLbl.text = "About the Church of Peace"
              }
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 270
        default:
            return UITableView.automaticDimension
        }
    }
    
    
}
