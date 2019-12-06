//
//  LiveClassViewController.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 12/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

import Firebase
import FirebaseFirestore
import FirebaseDatabase
class LiveClassViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    let transition = SlideTransition()
    let db = Firestore.firestore()
    var  myDict = [String :String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchDataBase()
         self.registerXib()
        self.tableView.estimatedRowHeight = 300
    }
    
    func registerXib() {
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerTableViewCell")
        tableView.register(UINib(nibName: "LiveTableViewCell", bundle: nil), forCellReuseIdentifier: "LiveTableViewCell")
        tableView.register(UINib(nibName: "linkTableViewCell", bundle: nil), forCellReuseIdentifier: "linkTableViewCell")
        
    }

    func fetchDataBase() {
        
        let ref = Database.database().reference(withPath: "myData")
            ref.observeSingleEvent(of: .value, with: { snapshot in

            if !snapshot.exists() { return }
            print(snapshot) // Its print all values including Snap (User)
            print(snapshot.value!)
            let description = snapshot.childSnapshot(forPath: "description").value
            let youtubeLink = snapshot.childSnapshot(forPath: "YoutubeLink").value
            let title = snapshot.childSnapshot(forPath: "title").value
            self.myDict["description"] = description as? String ?? ""
            self.myDict["YoutubeLink"] = youtubeLink as? String ?? ""
            self.myDict["title"] = title as? String ?? ""
            self.tableView.reloadData()
        })
    
    }
    
   
   
    @IBAction func tapMenuBtnAction(_ sender: Any) {
        let object = self.storyboard?.instantiateViewController(withIdentifier: "menuController") as! menuController
            object.modalPresentationStyle = .overFullScreen
            object.transitioningDelegate = self
            object.navVc = self.navigationController
       self.navigationController?.present(object, animated: true, completion: nil)
    }
    
}

//MARK:- UIViewControllerTransitioningDelegate
extension LiveClassViewController : UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transition.isPresenting = false
        return transition
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transition.isPresenting = true
        return transition
    }
}
extension LiveClassViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
             let cell = self.tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell") as! PlayerTableViewCell
                cell.youtubeLink = self.myDict["YoutubeLink"] ?? ""
                cell.setupData()
                return cell
        case 1 :
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "LiveTableViewCell") as! LiveTableViewCell
                cell.descriptionLbl.text = self.myDict["description"] ?? ""
                cell.titleLb.text = self.myDict["title"] ?? ""
            return cell
            
        default:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "linkTableViewCell") as! linkTableViewCell
            return cell
             
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
          return  300
        case 1:
            return UITableView.automaticDimension
        default:
           return 550
        }
    }
    
    
    
    
}
