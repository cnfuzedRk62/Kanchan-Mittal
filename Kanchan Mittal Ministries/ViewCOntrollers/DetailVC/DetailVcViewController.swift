//
//  DetailVcViewController.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 27/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class DetailVcViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
         self.title = "Kanchan Mittal"
        self.navigationItem.backBarButtonItem?.title = ""
        // Do any additional setup after loading the view.
    }
    
    func registerXib() {
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        tableView.register(UINib(nibName: "DetailCellTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailCellTableViewCell")
    }

}
extension DetailVcViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = self.tableView.dequeueReusableCell(withIdentifier: "DetailCellTableViewCell") as! DetailCellTableViewCell
            cell.titleLbl.text = "We are a Community who firmly believes in Gods word. Come journey with us."
            cell.descriptionLbl.text = Constant.longText.aboutText
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
