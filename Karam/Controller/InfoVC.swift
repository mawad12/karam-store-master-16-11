//
//  InfoVC.swift
//  BASIT
//
//  Created by ahmed on 3/7/19.
//  Copyright © 2019 ahmed. All rights reserved.
//

import UIKit

class InfoVC: SuperViewController {
    var Info : AboutUs?
    
    var IsImage = true
    
    var IsNav = false
    
    @IBOutlet weak var uiweb_view: UIWebView!
    @IBOutlet weak var image_view: UIView!
    @IBOutlet weak var image_about: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigation = self.navigationController as! CustomNavigationBar
        navigation.setTitle(Info!.title!, sender: self)
        navigation.setTitle(Info!.title!, sender: self,Srtingcolor :"AECB1B")
        
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        if IsNav{
            navigation.setCustomBackButtonForViewController(sender: self)
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            sideMenuController?.isLeftViewSwipeGestureEnabled = false
            sideMenuController?.isRightViewSwipeGestureEnabled = false
        }else{
            navigation.setCustomBackButtonWithdismiss(sender: self)
            sideMenuController?.isLeftViewSwipeGestureEnabled = false
            sideMenuController?.isRightViewSwipeGestureEnabled = false
            
        }
        
        
        if !IsImage {
            image_view.isHidden = true
        }else{
            self.image_about.sd_custom(url: (self.Info?.image!)!)
            
        }
        
        
        
        self.uiweb_view.loadHTMLString((self.Info?.aboutUsDescription!)!, baseURL: Bundle.main.bundleURL)
        
        
        
    }
    
    
    
    
}
