//
//  PaymentWebViewController.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 04/12/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit
import WebKit
class PaymentWebViewController: UIViewController,WKNavigationDelegate {
    
    @IBOutlet var menuBtn: UIBarButtonItem!
    @IBOutlet var webView: WKWebView!
    let transition = SlideTransition()
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        let Url = URL(string:"http://kanchanmittal.com/donation")!
        webView.load(URLRequest(url: Url))
        // Do any additional setup after loading the view.
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
extension PaymentWebViewController : UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transition.isPresenting = false
        return transition
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transition.isPresenting = true
        return transition
    }
}
