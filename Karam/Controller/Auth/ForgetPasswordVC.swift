//
//  ViewController.swift
//  PT
//
//  Created by musbah on 3/24/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ForgetPasswordVC: UIViewController {
    
    
    @IBOutlet weak var Email_TF: SkyFloatingLabelTextFieldWithIcon!


    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
  


    @IBAction func ForgetPasswordButton(_ sender: Any) {
        
        guard let email = self.Email_TF.text, !email.isEmpty else{
            self.showAlert(title: "Error".localized, message: "Email Can't be Empty".localized)
            return
        }
        
        if !email.isValidEamil{
            self.showAlert(title: "Error".localized, message: "Email Not Valid".localized)
            return
        }
        
        
        _ = WebRequests.setup(controller: self).prepare(query: "forgetpassword", method: HTTPMethod.post, parameters: ["email":email]).start(){ (response, error) in
            
            
            do {
                let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                if !Status.status! {
                    
                    self.showAlert(title: "Error".localized, message:Status.message!)
                    return
                }
                print(Status.message!)
                self.showAlert(title: "Reset Password".localized, message:Status.message!)
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
            
        }

    }

    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

