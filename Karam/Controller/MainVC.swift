//
//  MainViewController.swift
//  LGSideMenuControllerDemo
//

import UIKit
import LGSideMenuController


class MainVC: LGSideMenuController {
    
    private var type: UInt?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if MOLHLanguage.isRTLLanguage() {
            
            let vc:SideMenuVC = AppDelegate.sb_main.instanceVC()
            rightViewController = vc
            leftViewController = nil
            
            rightViewBackgroundImage = UIImage(named: "RightSideMenu")
            //rightViewWidth = 250.0
            //isRootViewStatusBarHidden = false
            //isRightViewStatusBarHidden = true
            //rightViewPresentationStyle = .scaleFromBig

        } else {
            
            let vc:SideMenuVC = AppDelegate.sb_main.instanceVC()
            leftViewController = vc

            //leftViewController = SideMenuVC()
            rightViewController = nil
            
            leftViewBackgroundImage = UIImage(named: "LeftSideMenu")
            //leftViewWidth = 300
            //isRootViewStatusBarHidden = false
            //isLeftViewStatusBarHidden = true
            //leftViewPresentationStyle = .scaleFromLittle
            
        }
    }
    
}
