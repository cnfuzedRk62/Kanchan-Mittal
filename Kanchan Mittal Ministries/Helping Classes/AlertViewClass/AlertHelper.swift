//
//  AlertHelper.swift
//
//  Created by osvinuser on 29/06/16.
//  Copyright © 2016 Swati. All rights reserved.
//

import Foundation
import UIKit

// MARK :
// MARK : Alert
protocol ShowAlert {}

extension ShowAlert where Self: UIViewController
{
    func showAlert(_ message: String)
    {
        let alertController = UIAlertController(title: Constant.Messages.AppTital, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion:nil)
    }
    
    func showAlertWithActions(_ message:String) {
        
        let alertController = UIAlertController(title: Constant.Messages.AppTital, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        { action -> Void in
            
            _ = self.navigationController?.popViewController(animated: true)

        })
        present(alertController, animated: true, completion:nil)
    }
    
  
    func showAlertWithDismissActions(_ message:String) {
        
        let alertController = UIAlertController(title: Constant.Messages.AppTital, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        { action -> Void in
            
            self.dismiss(animated: true, completion: nil)

        })
        present(alertController, animated: true, completion:nil)
    }
    
    
    func showAlertWithTwoActions(_message:String) {
        
        
        let alertController = UIAlertController(title: Constant.Messages.AppTital, message: _message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default)
        { action -> Void in
            
            _ = self.navigationController?.popViewController(animated: true)
            
        })
        present(alertController, animated: true, completion:nil)
        
    }
    
    
}
