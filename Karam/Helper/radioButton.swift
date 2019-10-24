//
//  radioButton.swift
//  PT
//
//  Created by musbah on 2/21/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class RadioButton: UIButton {
    var alternateButton:Array<RadioButton>?
    
    override func awakeFromNib() {
//        self.layer.cornerRadius = 14
//        self.layer.borderWidth = 1
        self.layer.masksToBounds = true
    }
    
    func unselectAlternateButtons(){
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        }else{
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton(){
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                
                if self.tag == 55{
                    self.imageView?.image = UIImage(named: "SelectedFemaleButton")
                }
                if self.tag == 66{
                    self.imageView?.image = UIImage(named: "SelectedMaleButton")
                }
                
            } else {
                if self.tag == 55{
                    self.imageView?.image = UIImage(named: "FemaleButton")
                }else{
                    self.imageView?.image = UIImage(named: "MaleButton")
                }
            }
        }
    }
}

