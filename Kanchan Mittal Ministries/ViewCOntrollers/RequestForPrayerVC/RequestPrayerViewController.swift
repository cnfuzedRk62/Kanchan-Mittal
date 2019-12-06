//
//  RequestPrayerViewController.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 17/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit
import MessageUI
class RequestPrayerViewController: UIViewController,ShowAlert,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate {
    
    @IBOutlet var segmentBtn: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var firstView: UIView!
    @IBOutlet var secondView: UIView!
    @IBOutlet var emailVIew1: UIView!
    @IBOutlet var nameView1: UIView!
    @IBOutlet var textView1: UIView!
    @IBOutlet var nameTextfld_View1: UITextField!
    @IBOutlet var emailTextfld_view1: UITextField!
    @IBOutlet var phoneTextfld_view1: UITextField!
    @IBOutlet var textVIew_view1: TextViewDesign!
    @IBOutlet var bookAppointment_View1: UIButton!
    @IBOutlet var NameView2: UIView!
    @IBOutlet var phoneView2: UIView!
    @IBOutlet var textview2: TextViewDesign!
    @IBOutlet var NameTextfld_view2: UITextField!
    @IBOutlet var phoneTextfld_view2: UITextField!
    @IBOutlet var requestBtnVew2: UIButton!
    var RequestMailDict = [String: String]()
    var RequestPhoneDict = [String: String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUi()
        self.title = "Book Appointment"
        self.navigationItem.backBarButtonItem?.title = ""
        // Do any additional setup after loading the view.
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentBtn.setTitleTextAttributes(titleTextAttributes, for: .normal)
            segmentBtn.setTitleTextAttributes(titleTextAttributes, for: .selected)
        self.initDict()
        self.nameTextfld_View1.delegate = self
        self.emailTextfld_view1.delegate = self
        self.phoneTextfld_view1.delegate = self
        self.NameTextfld_view2.delegate = self
        self.phoneTextfld_view2.delegate = self
        self.textVIew_view1.delegate = self
        self.NameTextfld_view2.delegate = self
        self.phoneTextfld_view2.delegate = self
        self.textview2.delegate = self
    }
    
    func initDict() {
        RequestMailDict["name"] = ""
        RequestMailDict["email"] = ""
        RequestMailDict["phone"] = ""
        RequestMailDict["prayer"] = ""
        RequestPhoneDict["name"] = ""
        RequestPhoneDict["phone"] = ""
        RequestPhoneDict["prayer"] = ""
    }
    
    func setupUi() {
        // for first VIew
        self.firstView.layer.cornerRadius = 10
        self.firstView.clipsToBounds = true
        self.secondView.layer.cornerRadius = 10
        self.secondView.clipsToBounds = true
        self.emailVIew1.layer.cornerRadius = 5
        self.emailVIew1.layer.borderColor = UIColor.lightGray.cgColor
        self.emailVIew1.layer.borderWidth = 0.5
        self.nameView1.layer.cornerRadius = 5
        self.nameView1.layer.borderColor = UIColor.lightGray.cgColor
        self.nameView1.layer.borderWidth = 0.5
        self.textView1.layer.cornerRadius = 5
        self.textView1.layer.borderColor = UIColor.lightGray.cgColor
        self.textView1.layer.borderWidth = 0.5
        self.textVIew_view1.layer.cornerRadius = 5
        self.textVIew_view1.layer.borderColor = UIColor.lightGray.cgColor
        self.textVIew_view1.layer.borderWidth = 0.5
        self.bookAppointment_View1.layer.cornerRadius = 25
        self.bookAppointment_View1.clipsToBounds = true
        // for Second VIew
        self.NameView2.layer.cornerRadius = 5
        self.NameView2.layer.borderColor = UIColor.lightGray.cgColor
        self.NameView2.layer.borderWidth = 0.5
        self.phoneView2.layer.cornerRadius = 5
        self.phoneView2.layer.borderColor = UIColor.lightGray.cgColor
        self.phoneView2.layer.borderWidth = 0.5
        self.textview2.layer.cornerRadius = 5
        self.textview2.layer.borderColor = UIColor.lightGray.cgColor
        self.textview2.layer.borderWidth = 0.5
        self.requestBtnVew2.layer.cornerRadius = 25
        self.requestBtnVew2.clipsToBounds = true
        // firstTIme
        self.firstView.isHidden = false
        self.secondView.isHidden = true
    
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        
        if segmentBtn.selectedSegmentIndex == 0 {
            self.firstView.isHidden = false
            self.secondView.isHidden = true
        }else{
            self.firstView.isHidden = true
            self.secondView.isHidden = false
        }
        
    }
    

    @IBAction func bookAppoitAction_view1(_ sender: Any) {
        self.validationMail()
    }
    
    
    @IBAction func requestBtnVIew2Action(_ sender: Any) {
        self.validationPhone()
    }
    
    
    func validationPhone() {
        
        if let name = RequestPhoneDict["name"] , name.count == 0 {
                   self.showAlert("Please enter your Name.")
          }else if let phoneNumber = RequestPhoneDict["phone"]  , phoneNumber.count == 0 {
                   self.showAlert("Please enter your phone number.")
          }else if let phoneNumber = RequestPhoneDict["phone"]  , phoneNumber.count < 10 {
                   self.showAlert("Please enter valid phone number.")
          }else if let prayer = RequestPhoneDict["prayer"] , prayer.count == 0 {
                   self.showAlert("Please enter prayer")
          }else{
                   self.showMszView()
         }
        
    }
  
    
    func validationMail(){
        
        if let name = RequestMailDict["name"] , name.count == 0 {
            self.showAlert("Please enter your Name.")
        }else if let email =  RequestMailDict["email"] , email.count == 0 {
            self.showAlert("please enter your email address.")
        }else if let emailValue = RequestMailDict["email"] , !emailValue.isValidEmail() {
            self.showAlert("Please enter valid email address.")
        }else if let phoneNumber = RequestMailDict["phone"]  , phoneNumber.count == 0 {
            self.showAlert("Please enter your phone number.")
        }else if let phoneNumber = RequestMailDict["phone"]  , phoneNumber.count < 10 {
            self.showAlert("Please enter valid phone number.")
        }else if let prayer = RequestMailDict["prayer"] , prayer.count == 0 {
            self.showAlert("Please enter prayer")
        }else{
            self.showMailView()
        }
    }
    
    func showMszView(){
        let messageVC = MFMessageComposeViewController()
        messageVC.body = "Appointment details \n Name is \( RequestPhoneDict["name"] ?? "") \n Contact number is \n \(RequestPhoneDict["phone"] ?? "") \n And your Prayer is \n \(RequestPhoneDict["prayer"] ?? "")";
        messageVC.recipients = ["+917710353800"]
        messageVC.messageComposeDelegate = self
        self.present(messageVC, animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
            dismiss(animated: true, completion: nil)
        case .failed:
            print("Message failed")
            dismiss(animated: true, completion: nil)
        case .sent:
            print("Message was sent")
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
    
    func showMailView() {
      if MFMailComposeViewController.canSendMail() {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients(["churchofpeace777@gmail.com"])
        let msz = "Request for prayer details \n Name is \( RequestMailDict["name"] ?? "") \n Email id is \n \( RequestMailDict["email"] ?? "") \n Contact number is \n \(RequestMailDict["phone"] ?? "") \n And your prayer is \n \(RequestMailDict["prayer"] ?? "" )"
        
        mail.setMessageBody(msz, isHTML: false)

        present(mail, animated: true)
      } else {
        // show failure alert
      }
    }
    
}
extension RequestPrayerViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
 
}

extension RequestPrayerViewController : UITextFieldDelegate,UITextViewDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
          
          if textField == nameTextfld_View1 {
              RequestMailDict["name"] = textField.text
          }else if textField == emailTextfld_view1 {
              RequestMailDict["email"] = textField.text
          }else if textField == phoneTextfld_view1 {
              RequestMailDict["phone"] = textField.text
          }else if textField == NameTextfld_view2 {
              RequestPhoneDict["name"] = textField.text
          }else if textField == phoneTextfld_view2 {
             RequestPhoneDict["phone"] = textField.text
         }
      }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneTextfld_view1  || textField == phoneTextfld_view2{
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView == textVIew_view1 {
             RequestMailDict["prayer"] = textView.text
        }else if textView == textview2 {
            RequestPhoneDict["prayer"] = textView.text
        }
        
    }
    
}


