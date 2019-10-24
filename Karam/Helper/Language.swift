//
//  Language.swift
//  localizeExample
//
//  Created by Ahmad on 4/28/17.
//  Copyright © 2017 Mostafa. All rights reserved.
//

import Foundation
import UIKit

class Language{
    static let systemTextDirectionKey = "AppleTextDirection"
    static let systemRightToLeftWritingDirectionKey = "NSForceRightToLeftWritingDirection"
    static let systemLeftToRightWritingDirectionKey = "NSForceLeftToRightWritingDirection"

    class func currentLanguage() -> String{
        
        let ns = UserDefaults.standard
        let langs = ns.value(forKey: "AppleLanguages") as! NSArray
        let firstLang = langs.firstObject as! String
        if firstLang.lowercased().contains("en") {
            let firstLang = "en"
            return firstLang
        }
        return firstLang
    }
    
    class func isRtl() -> Bool{
       
        if Language.currentLanguage().contains("ar") {
            return true
        }
        
        return false
    }
    
    class func setAppLanguage(lang:String){
        let flipOption : UIView.AnimationOptions = .transitionFlipFromLeft
        let ns = UserDefaults.standard
        ns.setValue([lang, currentLanguage()], forKey: "AppleLanguages")
        if !self.isRtl() {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
//            UserDefaults.standard.set(true, forKey: Language.systemTextDirectionKey)
//            UserDefaults.standard.set(true, forKey: Language.systemLeftToRightWritingDirectionKey)
            
            
            UserDefaults.standard.synchronize()
        } else {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
//            UserDefaults.standard.set(false, forKey: Language.systemTextDirectionKey)
//            UserDefaults.standard.set(false, forKey: Language.systemRightToLeftWritingDirectionKey)
            
            
            UserDefaults.standard.synchronize()
        }
        ns.synchronize()
        _ = WebRequests.setup(controller: nil).prepare(query: "settings", method: HTTPMethod.get).start(){ (response, error) in
            do {
                let Status =  try JSONDecoder().decode(SettingsObject.self, from: response.data!)
                CurrentSettings.settingsInfo = Status.items!
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
        
        guard let window = UIApplication.shared.keyWindow else { return }
        let vc : SplashVC = AppDelegate.sb_main.instanceVC()
        window.rootViewController = vc
        
        UIView.transition(with: window, duration: 0.3, options:  flipOption, animations: nil, completion: nil)
    }
    

}
