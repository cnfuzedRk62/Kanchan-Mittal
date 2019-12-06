//
//  GetinTouchViewController.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 17/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit
import MessageUI
class GetinTouchViewController: UIViewController,ShowAlert,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate {
    
    @IBOutlet var tableView: UITableView!
    var collectedData = [String:String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Get in Touch"
        self.navigationItem.backBarButtonItem?.title = ""
        self.registerXib()
        self.initDict()
        // Do any additional setup after loading the view.
    }
    
    func registerXib() {
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "GetTouchTableViewCell", bundle: nil), forCellReuseIdentifier: "GetTouchTableViewCell")
        tableView.register(UINib(nibName: "GetFieldsTableViewCell", bundle: nil), forCellReuseIdentifier: "GetFieldsTableViewCell")
        tableView.register(UINib(nibName: "ContactTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactTableViewCell")
    }
    
    func initDict() {
         self.collectedData["name"] = ""
         self.collectedData["email"] = ""
         self.collectedData["subject"] = ""
         self.collectedData["message"] = ""
     }

}
extension GetinTouchViewController : UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "GetTouchTableViewCell", for: indexPath) as! GetTouchTableViewCell
            return cell
        case 1:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "GetFieldsTableViewCell", for: indexPath) as! GetFieldsTableViewCell
                cell.sendBtn.addTarget(self, action: #selector(sendBtn(sender:)), for: .touchUpInside)
                cell.userNameTxtfld.delegate = self
                cell.emailTextfld.delegate = self
                cell.subjectTxtfld.delegate = self
                cell.textView.delegate = self
            return cell
            
        default:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 250
        case 1:
            return 430
        default:
            return 100
        }
    }
    
    @objc func sendBtn(sender: UIButton){
        
        if let name = collectedData["name"] , name.count == 0 {
            self.showAlert("Please enter your name.")
        }else if let email =  collectedData["email"] , email.count == 0 {
             self.showAlert("Please enter your email address.")
        }else if let emailValue = collectedData["email"] , !emailValue.isValidEmail() {
            self.showAlert("Please enter valid email address.")
        }else if let subject = collectedData["subject"] , subject.count == 0 {
            self.showAlert("Please enter Subject.")
        }else if let message = collectedData["message"] , message.count == 0 {
            self.showAlert("Please enter message.")
        }else  {
            self.sendMail()
        }
    }
    
    func sendMail() {
        if MFMailComposeViewController.canSendMail() {
          let mail = MFMailComposeViewController()
          mail.mailComposeDelegate = self
          mail.setToRecipients(["churchofpeace777@gmail.com"])
          let msz = " details are follow \n Name is \( collectedData["name"]  ?? "") \n Email id is \n \( collectedData["email"]  ?? "") \n Subject is \n \(collectedData["subject"] ?? "") \n And message is \n \(collectedData["message"]  ?? "")"
          
          mail.setMessageBody(msz, isHTML: false)

          present(mail, animated: true)
        } else {
          // show failure alert
        }
        
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true)
       }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        let cell = self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! GetFieldsTableViewCell
        if textView == cell.textView {
            collectedData["message"] = textView.text
        }
      
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let cell = self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! GetFieldsTableViewCell
        
        if textField == cell.userNameTxtfld {
            collectedData["name"] = textField.text
        }else if textField == cell.emailTextfld {
             collectedData["email"] = textField.text
        }else if textField == cell.subjectTxtfld {
            collectedData["subject"] = textField.text
        }
        
        
    }

}

