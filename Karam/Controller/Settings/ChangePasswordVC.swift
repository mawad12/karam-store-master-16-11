//
//  SettingsVC.swift
//  Karam
//
//  Created by musbah on 6/18/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField


class ChangePasswordVC: SuperViewController {

    @IBOutlet weak var OldPassword_TF: SkyFloatingLabelTextField!
    @IBOutlet weak var NewPassword_TF: SkyFloatingLabelTextField!
    @IBOutlet weak var ConfirmPassword_TF: SkyFloatingLabelTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigation = self.navigationController as! CustomNavigationBar
        navigation.setCustomBackButtonForViewController(sender: self)
        
        
        sideMenuController!.isLeftViewSwipeGestureEnabled = false
        sideMenuController!.isRightViewSwipeGestureEnabled = false
    
    }
    
    

    
    @IBAction func ChangePasswordButton(_ sender: Any) {
        guard let OldPassword = self.OldPassword_TF.text, !OldPassword.isEmpty else{
            self.showAlert(title: "Erorr".localized, message: "Old Password Can't be Empty".localized)
            return
        }
        
        if OldPassword.count < 6 {
            showAlert(title: "Erorr".localized, message: "Old Password must be at least 6 characters".localized)
            return
        }
        
        
        guard let NewPassword = self.NewPassword_TF.text, !NewPassword.isEmpty else{
            self.showAlert(title: "Erorr".localized, message: "New Password Can't be Empty".localized)
            return
        }
        
        if NewPassword.count < 6 {
            showAlert(title: "Erorr".localized, message: "New Password must be at least 6 characters".localized)
            return
        }
    
        
        guard let ConfirmPassword = self.ConfirmPassword_TF.text, !ConfirmPassword.isEmpty else{
            self.showAlert(title: "Erorr".localized, message: "Confirm Password Can't be Empty".localized)
            return
        }
        
        if ConfirmPassword.count < 6 {
            showAlert(title: "Erorr".localized, message: "Old Password must be at least 6 characters".localized)
            return
        }
        
        guard ConfirmPassword == NewPassword  else {
            self.showAlert(title: "Error".localized, message: "Password dont match confirm password".localized)
            return
        }
        
        
        var parameters: [String: Any] = [:]
        
        parameters["old_password"] = OldPassword
        parameters["password"] = ConfirmPassword

        _ = WebRequests.setup(controller: self).prepare(query: "changePassword", method: HTTPMethod.post, parameters: parameters).start(){ (response, error) in
            
            do {
                let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                if !Status.status! {
                    
                    self.showAlert(title: "Error".localized, message:Status.message!)
                    return
                }else{
                    self.navigationController?.popViewController(animated: true)
                    self.showAlert(title: "Success".localized, message:Status.message!)
                }
                
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
          
        }
        
    }
            
        
}



