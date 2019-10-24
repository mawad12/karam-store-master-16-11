//
//  SelectTypeRegisterVc.swift
//  Karam
//
//  Created by ramez adnan on 17/07/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class SelectTypeRegisterVc: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnType(_ sender: UIButton) {
        
        if sender.tag == 0{
            
            let vc:SignUpVC = AppDelegate.sb_main.instanceVC()
            vc.type = "1"
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        }else if sender.tag == 1{
            
            let vc:SignUpVC = AppDelegate.sb_main.instanceVC()
            vc.type = "3"
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
            
        }else{
            
            let vc:SignUpVC = AppDelegate.sb_main.instanceVC()
            vc.type = "2"
            vc.modalPresentationStyle = .fullScreen

            self.present(vc, animated: true, completion: nil)
            
            
        }
        
        
    }
    
    
    
    
    
    
}
