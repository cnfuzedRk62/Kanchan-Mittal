//
//  SendFeedBackViewController.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 17/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit
import MessageUI
class SendFeedBackViewController: UIViewController,ShowAlert,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate {
  
   
    @IBOutlet var viewofTextView: UIView!
    @IBOutlet var textView: TextViewDesign!
    @IBOutlet var characterLimit: UILabel!
    @IBOutlet var submitBtn: UIButton!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Feedback"
        self.navigationItem.backBarButtonItem?.title = ""
        self.textView.delegate = self
        self.submitBtn.layer.cornerRadius = 10
        self.submitBtn.clipsToBounds = true
        // Do any additional setup after loading the view.
    }


    @IBAction func tapSubmitBtn(_ sender: Any) {
        if let text = textView.text , text.count == 0 {
               self.showAlert("Please enter your feedback")
        }else{
            self.showMail()
        }
    }
    
    func showMail() {
        if MFMailComposeViewController.canSendMail() {
             let mail = MFMailComposeViewController()
             mail.mailComposeDelegate = self
             mail.setToRecipients(["churchofpeace777@gmail.com"])
            let msz = textView.text ?? ""
             mail.setMessageBody(msz, isHTML: false)

             present(mail, animated: true)
           } else {
             // show failure alert
           }
        
    }
    
   func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
         controller.dismiss(animated: true)
     }
     
   
}
extension SendFeedBackViewController : UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
          return textView.text.count + (text.count - range.length) <= 200
    }
    
    func textViewDidChange(_ textView: UITextView) {
        characterLimit.text = "\(200 - textView.text.count) Characters"
    }
    
    
    
}
