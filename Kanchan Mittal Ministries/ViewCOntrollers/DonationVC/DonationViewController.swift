//
//  DonationViewController.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 12/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class DonationViewController: UIViewController {
    private var popGesture: UIGestureRecognizer?
    let transition = SlideTransition()
     @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerXib()
        // Do any additional setup after loading the view.
    }
    
    func registerXib() {
          tableView.separatorStyle = .none
          tableView.register(UINib(nibName: "DonationTableViewCell", bundle: nil), forCellReuseIdentifier: "DonationTableViewCell")
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
extension DonationViewController : UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transition.isPresenting = false
        return transition
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transition.isPresenting = true
        return transition
    }
}
extension DonationViewController : UITableViewDataSource,UITableViewDelegate {
    
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
        return 550
    }
    
}
