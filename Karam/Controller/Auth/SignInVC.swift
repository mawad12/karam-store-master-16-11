//
//  ViewController.swift
//  PT
//
//  Created by musbah on 3/24/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import TweeTextField

class SignInVC: UIViewController,UITextFieldDelegate {
    

    @IBOutlet weak var Email_TF: TweeAttributedTextField!
    @IBOutlet weak var Password_TF: TweeAttributedTextField!
    
    @IBOutlet weak var passwordButton: UIButton!
    
    var isShowPassword = true

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Email_TF.delegate = self
        Password_TF.delegate = self

        self.Email_TF.addTarget(self, action: #selector(updateError), for: .editingChanged)

        self.Password_TF
            .addTarget(self, action: #selector(updateError), for: .editingChanged)

    }
    
    @objc func updateError(textField: TweeAttributedTextField) {
        
        Email_TF.hideInfo()  // to remove the error message
        Email_TF.lineColor = UIColor(red: 174/255, green: 203/255, blue: 27/255, alpha: 1)
        Email_TF.lineWidth = 0.5


    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        putStyle.TextFelidHideAppear(Style: Email_TF, string: "Email".localized)
        putStyle.TextFelidHideAppear(Style: Password_TF, string: "Password".localized)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
         self.Email_TF.tweePlaceholder = "Email".localized
         self.Password_TF.tweePlaceholder = "Password".localized

    }
    
    
    
    
    
  
    @IBAction func showPasswordButton(_ sender: Any) {
        
        if(isShowPassword == true) {
            Password_TF.isSecureTextEntry = false
            passwordButton.setImage(#imageLiteral(resourceName: "HidePass"), for: .normal)
        } else {
            Password_TF.isSecureTextEntry = true
            passwordButton.setImage(#imageLiteral(resourceName: "viewPassword"), for: .normal)
        }
        
        isShowPassword = !isShowPassword
        
        
    }
    
    @IBAction func skipButton(_ sender: Any) {
        let vc:MainVC = AppDelegate.sb_main.instanceVC()
        let NavigationController :CustomNavigationBar = AppDelegate.sb_main.instanceVC()
        NavigationController.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen

        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let vc:SelectTypeRegisterVc = AppDelegate.sb_main.instanceVC()
        vc.modalPresentationStyle = .fullScreen

        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func signInButton(_ sender: Any) {
        
        guard let email = self.Email_TF.text, !email.isEmpty else{
            
            Email_TF.showInfo("Can't be Empty".localized, animated: true)
            Email_TF.lineColor = .red
            Email_TF.lineWidth = 2
            
//            Email_TF.error = ""
            return
        }
        
        if !email.isValidEamil{
//            Email_TF.error = "Email Not Valid"
            Email_TF.showInfo("Email Not Valid".localized, animated: true)
            Email_TF.lineColor = .red
            Email_TF.lineWidth = 2
            
            return
        }
        
        guard let password = self.Password_TF.text, !password.isEmpty else{
            Password_TF.showInfo("Can't be Empty".localized, animated: true)
            Password_TF.lineColor = .red
            Password_TF.lineWidth = 2
            
//             Password_TF.error = "Can't be Empty"
            return
        }
        
        if password.count < 6 {
            Password_TF.showInfo("at least 6 characters".localized, animated: true)
            Password_TF.lineColor = .red
            Password_TF.lineWidth = 2
            
//            Password_TF.error = "at least 6 characters"

            return
        }
        
        
        var parameters: [String: Any] = [:]
        
        parameters["email"] = email
        parameters["password"] = password
        parameters["type"] = "1"

        
        parameters["device_type"] = "ios"
        parameters["fcm_token"] = Helper.device_token
        
        _ = WebRequests.setup(controller: self).prepare(query: "login", method: HTTPMethod.post, parameters: parameters).start(){ (response, error) in
            
            do {
                let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                if !Status.status! {
                    
                    self.showAlert(title: "Error".localized, message:Status.message!)
                    return
                }
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
            do {
                let Status =  try JSONDecoder().decode(UserObject.self, from: response.data!)
                CurrentUser.userInfo = Status.items
                
                if CurrentUser.userInfo != nil,  CurrentUser.userInfo?.typeUser == "1" || CurrentUser.userInfo?.typeUser == "3" || CurrentUser.userInfo?.typeUser == "4" {
                    let vc:MainVC = AppDelegate.sb_main.instanceVC()
                    let NavigationController :CustomNavigationBar = AppDelegate.sb_main.instanceVC()
                    NavigationController.pushViewController(vc, animated: true)
                    vc.modalPresentationStyle = .fullScreen

                    self.present(vc, animated: true, completion: nil)
                    
                }
                
                
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
        
    }
    
    
}

