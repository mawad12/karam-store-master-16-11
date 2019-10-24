//
//  SplashViewController.swift
//  WinkomProject
//
//  Created by musbah on 3/5/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSettingsRequest()
    }
    
    
    func getSettingsRequest()  {
        
        _ = WebRequests.setup(controller: nil).prepare(query: "settings", method: HTTPMethod.get).start(){ (response, error) in
            
            
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
                let Status =  try JSONDecoder().decode(SettingsObject.self, from: response.data!)
                
                CurrentSettings.settingsInfo = Status.items
                
                if !UserDefaults.standard.bool(forKey: "didSelectState") {
                    UserDefaults.standard.set(true, forKey: "didSelectState")
                    let vc:SelectStateVC = AppDelegate.sb_main.instanceVC()
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalPresentationStyle = .fullScreen

                    self.present(vc, animated: true, completion: nil)
                    
                }else{
                    
                    let vc:AdsVC = AppDelegate.sb_main.instanceVC()
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalPresentationStyle = .fullScreen

                    self.present(vc, animated: true, completion: nil)
                    
                }
                
                
                
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
            
        }
        
    }
    
}
