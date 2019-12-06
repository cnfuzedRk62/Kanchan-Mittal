//
//  DonationTableViewCell.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 28/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import UIKit

class DonationTableViewCell: UITableViewCell {
    
    
    @IBOutlet var innerView: UIView!
    
    @IBOutlet var view1: UIView!
    
    @IBOutlet var nameTxtfld: UITextField!
    
    @IBOutlet var view2: UIView!
    
    @IBOutlet var emailTxtfld: UITextField!
    
    @IBOutlet var view3: UIView!
    
    @IBOutlet var phoneTxtfld: UITextField!
    
    @IBOutlet var otherAmountView: UIView!

    @IBOutlet var amountTxtfld: UITextField!
    
    @IBOutlet var rupeeBtn: UIButton!
    
    @IBOutlet var donateBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        self.innerView.layer.cornerRadius = 10
        self.innerView.clipsToBounds = true
        self.view1.layer.cornerRadius = 5
        self.view1.layer.borderColor = UIColor.lightGray.cgColor
        self.view1.layer.borderWidth = 0.5
        self.view1.clipsToBounds  = true
        self.view2.layer.cornerRadius = 5
        self.view2.layer.borderColor = UIColor.lightGray.cgColor
        self.view2.layer.borderWidth = 0.5
        self.view2.clipsToBounds  = true
        self.view3.layer.cornerRadius = 5
        self.view3.layer.borderColor = UIColor.lightGray.cgColor
        self.view3.layer.borderWidth = 0.5
        self.view3.clipsToBounds  = true
        self.otherAmountView.layer.cornerRadius = 5
        self.otherAmountView.layer.borderColor = UIColor.lightGray.cgColor
        self.otherAmountView.layer.borderWidth = 0.5
        self.otherAmountView.clipsToBounds  = true
        self.donateBtn.layer.cornerRadius = 20
        self.donateBtn.clipsToBounds = true
        self.rupeeBtn.layer.cornerRadius = 7
        self.rupeeBtn.clipsToBounds = true
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
