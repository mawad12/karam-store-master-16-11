//
//  SettingsVC.swift
//  Karam
//
//  Created by musbah on 6/18/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var ChangePassword: UIView!
    
    @IBOutlet weak var logoutView: UIView!
    
    @IBOutlet weak var lblLanguage: UILabel!
    
    @IBOutlet weak var viewEnforce: UIView!
    
    @IBOutlet weak var viewDelivary: UIView!
    
    @IBOutlet weak var switchClose: UISwitch!

    
    
    
    var flipOption : UIView.AnimationOptions = .transitionFlipFromLeft
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.bool(forKey: "value") == true {
            switchClose.setOn(true, animated: false)
        }else {
            switchClose.setOn(false, animated: false)
        }
        
        
        if CurrentUser.userInfo == nil{
            logoutView.isHidden = true
            ChangePassword.isHidden = true
        }
        if CurrentUser.userInfo?.typeUser == "4"{
            viewEnforce.isHidden = true
            viewDelivary.isHidden = true
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let navigation = self.navigationController as! CustomNavigationBar
        
        navigation.setTitle("Settings".localized, sender: self,Srtingcolor :"AECB1B")
        navigation.setMeunButton(sender: self)
        navigation.setShadowNavBar()
        
        
        sideMenuController!.isLeftViewSwipeGestureEnabled = true
        sideMenuController!.isRightViewSwipeGestureEnabled = true
        
        
    }
    
    func EnforceClosing(value:Int) {
        _ = WebRequests.setup(controller: self).prepare(query: "forsClose/\(value)", method: HTTPMethod.get).start(){ (response, error) in
            
            do {
                let Status =  try JSONDecoder().decode(UserObject.self, from: response.data!)
                if !Status.status! {
                    self.showAlert(title: "Error".localized, message:Status.message!)
                    return
                }else{
                    CurrentUser.userInfo = Status.items
                    self.showAlert(title: "Success".localized, message:Status.message!)
                }
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
            
        }

    }
    
    
    
    @IBAction func notificationSwitch(_ sender: UISwitch) {
    }
    
    
    @IBAction func EnforceClosingSwitch(_ sender: UISwitch) {
        
        if sender.isOn{
            EnforceClosing(value:1)
            UserDefaults.standard.set(true, forKey: "value")
        }else{
            EnforceClosing(value:0)
            UserDefaults.standard.set(false, forKey: "value")

        }
       


        
        
        
    }
    
    
    @IBAction func changeLanguageButton(_ sender: Any) {
        
      
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let en_action = UIAlertAction.init(title: "English", style: .default) { (_) in
            MOLH.setLanguageTo("en")
//            AdsVC
//            let vc:AdsVC = AppDelegate.sb_main.instanceVC()
//            let appDelegate =  UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController = vc
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

            MOLH.reset(transition: .transitionCrossDissolve)
            
            self.didLanguageChanged(key: "en", flip: .transitionFlipFromLeft, sem: .forceLeftToRight)
        }
        
        let ar_action = UIAlertAction.init(title: "العربية", style: .default) { (_) in
            MOLH.setLanguageTo("ar")
            MOLH.reset(transition: .transitionCrossDissolve)
//            let vc:AdsVC = AppDelegate.sb_main.instanceVC()
//            let appDelegate =  UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController = vc
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

            
        }
        let cancel = UIAlertAction.init(title: "Cancel".localized, style: .cancel, handler: nil)
        
        alert.addAction(ar_action)
        alert.addAction(en_action)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    private func didLanguageChanged(key: String, flip: UIView.AnimationOptions, sem: UISemanticContentAttribute){
        MOLHLanguage.setAppleLAnguageTo(key)
        UIView.appearance().semanticContentAttribute = sem
        self.flipOption = flip
        
        //        goHome()
        
        //guard let window = UIApplication.shared.keyWindow else { return }
        //let vc: RootViewController = AppDelegate.sb_main.instanceVC()
        //window.rootViewController = vc
        //window.makeKeyAndVisible()
        //UIView.transition(with: window, duration: 0.5, options: self.flipOption, animations: nil, completion: nil)
    }
    
    
    @IBAction func ChangePasswordButton(_ sender: Any) {
        let vc:ChangePasswordVC = AppDelegate.sb_main.instanceVC()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func changeCountry(_ sender: Any) {
        let vc:SelectStateVC = AppDelegate.sb_main.instanceVC()
        vc.isNav = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func DekiveryDistanceButton(_ sender: Any) {
        
         self.showAlertWithTextField(title: "Delivery Distance".localized, message: "Please Enter Delivery Distance in Restaurants".localized, cancelAction: "Cancel".localized, placeholderText: "Kg".localized)
    }
    
    
    // with TextField
    func showAlertWithTextField (title: String, message:String, okAction:String = "Ok".localized, cancelAction:String, placeholderText:String, completion: ((UIAlertAction) -> Void)? = nil ){
        
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.keyboardType = .numberPad
            textField.placeholder = placeholderText
        }
        
        let saveAction = UIAlertAction(title: okAction, style: .default, handler: { alert -> Void in
            if let textField = alertController.textFields?[0] {
                if textField.text!.count > 0 {
                    
                    
                    print("Text :: \(textField.text ?? "")")
                    
                    
                    
                    let value = textField.text!
                    
                    _ = WebRequests.setup(controller: self).prepare(query: "distance/\(value)", method: HTTPMethod.get).start(){ (response, error) in
                    
                        do {
                           
                            let Status =  try JSONDecoder().decode(UserObject.self, from: response.data!)
                            
                            if !Status.status! {
                                self.showAlert(title: "Error".localized, message:Status.message!)
                                return
                            }else{
                                CurrentUser.userInfo = Status.items
                                self.showAlert(title: "Success".localized, message:Status.message!)
                            }
                    
                        }catch let jsonErr {
                            print("Error serializing  respone json", jsonErr)
                        }
                    
                    }
                    
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: cancelAction, style: .default, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        alertController.preferredAction = saveAction
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func FQAButton(_ sender: Any) {
        let vc:FQAVC = AppDelegate.sb_main.instanceVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func AboutUsButton(_ sender: Any) {
        let vc:InfoVC = AppDelegate.sb_main.instanceVC()
        vc.Info = CurrentSettings.settingsInfo?.aboutUs
        vc.IsImage = true
        vc.IsNav = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func TermsOfUseButton(_ sender: Any) {
        let vc:InfoVC = AppDelegate.sb_main.instanceVC()
        vc.Info = CurrentSettings.settingsInfo?.terms
        vc.IsImage = false
        vc.IsNav = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func PrivacyPolicyButton(_ sender: Any) {
        let vc:InfoVC = AppDelegate.sb_main.instanceVC()
        vc.Info = CurrentSettings.settingsInfo?.privacy
        vc.IsImage = false
        vc.IsNav = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func shareAppButton(_ sender: Any) {
    }
    
    
    @IBAction func SignOutButton(_ sender: Any) {
        if CurrentUser.userInfo != nil{
            
            let alert = UIAlertController(title: "Sign Out".localized, message: "Are you sure you want to sign out".localized, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok".localized, style: .default, handler: { (UIAlertAction) in
                CurrentUser.userInfo = nil
                
                let vc:SignInVC = AppDelegate.sb_main.instanceVC()
                let NavigationController :CustomNavigationBar = AppDelegate.sb_main.instanceVC()
                NavigationController.pushViewController(vc, animated: true)
                vc.modalPresentationStyle = .fullScreen

                self.present(vc, animated: true, completion: nil)
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel))
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    
}
