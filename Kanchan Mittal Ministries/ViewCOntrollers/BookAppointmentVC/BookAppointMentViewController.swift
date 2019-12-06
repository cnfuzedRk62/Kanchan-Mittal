//
//  BookAppointMentViewController.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 16/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit
import MessageUI
class BookAppointMentViewController: UIViewController,ShowAlert, MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate {
    
    @IBOutlet var outerView: UIView!
    @IBOutlet var innerView: UIView!
    @IBOutlet var NameView: UIView!
    @IBOutlet var EmailView: UIView!
    @IBOutlet var PhoneView: UIView!
    @IBOutlet var DateView: UIView!
    @IBOutlet var bookAppointmentBtn: UIButton!
    @IBOutlet var calenderBtn: UIButton!
    @IBOutlet var nameTxtfld: UITextField!
    @IBOutlet var emailTxtfld: UITextField!
    @IBOutlet var phoneTxtfld: UITextField!
    @IBOutlet var dateLbl: UILabel!
    var MyDict = Dictionary<String,AnyObject>()
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Book Appointmnet"
        self.navigationItem.backBarButtonItem?.title = ""
        self.uiSetup()
        self.setypDict()
        // Do any additional setup after loading the view.
    }
    
    func setypDict() {
        nameTxtfld.delegate = self
        emailTxtfld.delegate = self
        phoneTxtfld.delegate = self
        MyDict["name"] = "" as AnyObject
        MyDict["email"] = "" as AnyObject
        MyDict["phone"] = "" as AnyObject
        MyDict["date"] = "" as AnyObject
    }
    
    func uiSetup() {
        self.innerView.layer.cornerRadius = 10
        self.innerView.clipsToBounds = true
        self.NameView.layer.cornerRadius = 5
        self.NameView.layer.borderColor = UIColor.lightGray.cgColor
        self.NameView.layer.borderWidth = 0.5
        self.NameView.clipsToBounds  = true
        self.PhoneView.layer.cornerRadius = 5
        self.PhoneView.layer.borderColor = UIColor.lightGray.cgColor
        self.PhoneView.layer.borderWidth = 0.5
        self.PhoneView.clipsToBounds  = true
        self.EmailView.layer.cornerRadius = 5
        self.EmailView.layer.borderColor = UIColor.lightGray.cgColor
        self.EmailView.layer.borderWidth = 0.5
        self.EmailView.clipsToBounds  = true
        self.DateView.layer.cornerRadius = 10
        self.DateView.layer.borderColor = UIColor.lightGray.cgColor
        self.DateView.layer.borderWidth = 0.3
        self.DateView.clipsToBounds  = true
        self.bookAppointmentBtn.layer.cornerRadius = 25
        self.bookAppointmentBtn.clipsToBounds = true
        
    }
    
    @IBAction func tapBookAppointMent(_ sender: Any) {
        self.validation()
    }
    
    @IBAction func calenderBtnAction(_ sender: Any) {
        self.view.endEditing(true)
        self.showDatePicker()
    }
    
    func showDatePicker() {
       datePicker = UIDatePicker.init()
       datePicker.backgroundColor = UIColor.white
       datePicker.autoresizingMask = .flexibleWidth
       datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
       datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
       datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 170, width: UIScreen.main.bounds.size.width, height: 200)
       self.view.addSubview(datePicker)
       toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 210, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
       toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
          toolBar.sizeToFit()
       self.view.addSubview(toolBar)
    }
    
   @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        if let date = sender?.date {
            print("Picked the date \(dateFormatter.string(from: date))")
            dateLbl.text = (dateFormatter.string(from: date))
            MyDict["date"] = dateLbl.text as AnyObject
        }
    }

    @objc func onDoneButtonClick() {
        DispatchQueue.main.async {
            self.toolBar.removeFromSuperview()
            self.datePicker.removeFromSuperview()
        }
    }
    func validation() {
        if let name = MyDict["name"] as? String , name.count == 0 {
            self.showAlert("Please enter your Name.")
        }else if let email = MyDict["email"] as? String , email.count == 0 {
             self.showAlert("Please enter your email address.")
        }else if let emailValue = MyDict["email"] as? String , !emailValue.isValidEmail() {
            self.showAlert("Please enter valid email address.")
        }else if let phoneNumber = MyDict["phone"] as? String , phoneNumber.count == 0 {
            self.showAlert("Please enter your phone number.")
        }else if let phoneNumber = MyDict["phone"] as? String , phoneNumber.count < 10 {
            self.showAlert("Please enter valid phone number.")
        }else if dateLbl.text == "Date" {
            self.showAlert("Please choose appointment date.")
        }else{
            //self.sendMsz()
            self.sendEmail()
        }
    }
    
    func sendEmail() {
      if MFMailComposeViewController.canSendMail() {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients(["churchofpeace777@gmail.com"])
        let msz = "Appointment details \n Name is \( MyDict["name"] as? String ?? "") \n Email id is \n \( MyDict["email"] as? String ?? "") \n Contact number is \n \(MyDict["phone"] as? String ?? "") \n Appointment on \(MyDict["date"] as? String ?? "")"
        
        mail.setMessageBody(msz, isHTML: false)

        present(mail, animated: true)
      } else {
        // show failure alert
      }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
      controller.dismiss(animated: true)
    }
    
    
    func sendMsz(){
        if (MFMessageComposeViewController.canSendText()) {
                   let controller = MFMessageComposeViewController()
                   controller.body = "Appointment details \n Name is :-> \( MyDict["name"] as? String ?? "") \n Email id is :-> \n \( MyDict["email"] as? String ?? "") \n Contact number is :-> \n \(MyDict["phone"] as? String ?? "") \n Appointment on :-> \(MyDict["date"] as? String ?? "")"
                   controller.recipients = ["+918629830566"]
                   controller.messageComposeDelegate = self
                    self.present(controller, animated: true, completion: nil)
               }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
 
}
extension BookAppointMentViewController : UITableViewDataSource {
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

extension BookAppointMentViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == nameTxtfld {
            MyDict["name"] = textField.text  as AnyObject
        }else if textField == emailTxtfld {
            MyDict["email"] = textField.text  as AnyObject
        }else if textField == phoneTxtfld {
            MyDict["phone"] = textField.text  as AnyObject
        }
      
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneTxtfld {
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        
        return true
    }
}


extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
