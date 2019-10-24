//
//  ChangeImageToArabic.swift
//  Karam
//
//  Created by Khlaed on 8/18/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class ChangeImageToArabic: UIImageView {

    func lang() -> String {
        let prefferedLanguage = Locale.preferredLanguages[0] as String
        print (prefferedLanguage) //en-US
        
        let arr = prefferedLanguage.components(separatedBy: "-")
        let deviceLanguage = arr.first
        return deviceLanguage!
    }
    
    override func awakeFromNib() {
        
        if lang() == "ar" {
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }


}
