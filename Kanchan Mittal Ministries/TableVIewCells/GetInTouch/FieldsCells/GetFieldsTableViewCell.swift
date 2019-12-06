//
//  GetFieldsTableViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 17/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class GetFieldsTableViewCell: UITableViewCell,ShowAlert {
    
    @IBOutlet var outerView: UIView!
    
    @IBOutlet var userNameView: UIView!
    
    @IBOutlet var emailView: UIView!
    
    @IBOutlet var subjectVIew: UIView!
    
    @IBOutlet var textView: TextViewDesign!
    
    @IBOutlet var userNameTxtfld: UITextField!
    
    @IBOutlet var emailTextfld: UITextField!
    
    @IBOutlet var subjectTxtfld: UITextField!
    
    @IBOutlet var sendBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupUi()
    }
    
    func setupUi() {
        
        outerView.layer.cornerRadius = 10
        outerView.clipsToBounds = true
        self.userNameView.layer.borderColor = UIColor.lightGray.cgColor
        self.userNameView.layer.borderWidth = 0.5
        self.userNameView.layer.cornerRadius = 5
        self.userNameView.clipsToBounds  = true
        self.emailView.layer.borderColor = UIColor.lightGray.cgColor
        self.emailView.layer.borderWidth = 0.5
        self.emailView.clipsToBounds  = true
        self.emailView.layer.cornerRadius = 5
        self.subjectVIew.layer.borderColor = UIColor.lightGray.cgColor
        self.subjectVIew.layer.borderWidth = 0.5
        self.subjectVIew.clipsToBounds  = true
        self.subjectVIew.layer.cornerRadius = 5
        self.sendBtn.layer.cornerRadius = 20
        self.sendBtn.clipsToBounds = true
        self.textView.layer.cornerRadius = 10
        self.textView.layer.borderWidth = 0.5
        self.textView.layer.borderColor = UIColor.lightGray.cgColor
        self.textView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
