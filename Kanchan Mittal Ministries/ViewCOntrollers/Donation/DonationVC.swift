//
//  DonationVC.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 28/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit
class DonationVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerXib()
        // Do any additional setup after loading the view.
    }
    
    func registerXib() {
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "DonationTableViewCell", bundle: nil), forCellReuseIdentifier: "DonationTableViewCell")
        tableView.delegate  = self
        tableView.dataSource = self
        self.tableView.reloadData()
    }
  
}

extension DonationVC : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "DonationTableViewCell", for: indexPath) as! DonationTableViewCell
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 700
    }
    
}
