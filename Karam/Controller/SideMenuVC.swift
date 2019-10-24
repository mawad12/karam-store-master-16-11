//
//  LeftViewController.swift
//  WinkomProject
//
//  Created by musbah on 2/19/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {
    
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var FavoritView: UIView!
    
    @IBOutlet weak var MyOrdersView: UIView!
    
    @IBOutlet weak var DailyDealsView: UIView!
    
    @IBOutlet weak var ChatView: UIView!
        
    @IBOutlet weak var CartView: UIView!
    
    @IBOutlet weak var MapView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CurrentUser.userInfo?.type == "1"{
            
            FavoritView.isHidden = false
            MyOrdersView.isHidden = false
            DailyDealsView.isHidden = false
            ChatView.isHidden = false
            CartView.isHidden = false
            
        }else{

            FavoritView.isHidden = true
            MyOrdersView.isHidden = true
            DailyDealsView.isHidden = true
            ChatView.isHidden = true
            CartView.isHidden = true
            
        }
        
    }
    

    @IBAction func HomeButton(_ sender: Any) {
        let navigationController = sideMenuController!.rootViewController as! CustomNavigationBar
        
        let vc:HomePageVC = AppDelegate.sb_main.instanceVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
        navigationController.setViewControllers([vc], animated: false)
        sideMenuController!.hideLeftView(animated: true, delay: 0.0, completionHandler: nil)
        sideMenuController!.hideRightView(animated: true, delay: 0.0, completionHandler: nil)
    }
    
    
    @IBAction func MyFavroritButton(_ sender: Any) {
    }
    
    @IBAction func MyOrderButton(_ sender: Any) {
    }
    
    @IBAction func DailyDealsButton(_ sender: Any) {
    }
    
    @IBAction func ChatButton(_ sender: Any) {
    }
    
    @IBAction func OffersButton(_ sender: Any) {
    }
    
    @IBAction func MyCartButton(_ sender: Any) {
    }
    
    @IBAction func MapButton(_ sender: Any) {
    }
    
    @IBAction func ContactButton(_ sender: Any) {
    }
    
    @IBAction func SettingsButton(_ sender: Any) {
        
        let navigationController = sideMenuController!.rootViewController as! CustomNavigationBar
        
        let vc:SettingsVC = AppDelegate.sb_main.instanceVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
        navigationController.setViewControllers([vc], animated: false)
        sideMenuController!.hideLeftView(animated: true, delay: 0.0, completionHandler: nil)
        sideMenuController!.hideRightView(animated: true, delay: 0.0, completionHandler: nil)
        
    }
    
    
    
    
    
    
    
   
}
