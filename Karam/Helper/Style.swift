//
//  Style.swift
//  Karam
//
//  Created by Khlaed on 8/18/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import Foundation
import UIKit
import TweeTextField

var putStyle = Style()


class Style  {
    
    
    func TextFelidHideAppear(Style:TweeActiveTextField,string:String)  {
        
        
        if Style.isEditing == false {
            if Style.text == "" {
                
                Style.tweePlaceholder = "\(string)"
                
            }else{
                
                Style.tweePlaceholder = ""
                
            }}
        
}
    
}


