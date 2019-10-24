//
//  sideMenu.swift
//  Karam
//
//  Created by musbah on 2/19/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class SideMenuVC: UIViewController {
    
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var ProductView: UIView!
    
    @IBOutlet weak var MyOrdersView: UIView!
    
    @IBOutlet weak var DailyDealsView: UIView!
    
    @IBOutlet weak var ChatView: UIView!
    
    @IBOutlet weak var CartView: UIView!
    
    @IBOutlet weak var circleHome: UIImageView!
    @IBOutlet weak var iconHome: UIImageView!
    @IBOutlet weak var lblhome: UILabel!
    
    @IBOutlet weak var circleDaily: UIImageView!
    @IBOutlet weak var iconDaily: UIImageView!
    @IBOutlet weak var lblDaily: UILabel!
    
    @IBOutlet weak var circleOffer: UIImageView!
    @IBOutlet weak var iconOffer: UIImageView!
    @IBOutlet weak var lblOffer: UILabel!
    
    @IBOutlet weak var circleProd: UIImageView!
    @IBOutlet weak var iconProd: UIImageView!
    @IBOutlet weak var lblProd: UILabel!
    
    @IBOutlet weak var circleChat: UIImageView!
    @IBOutlet weak var iconChat: UIImageView!
    @IBOutlet weak var lblChat: UILabel!
    
    @IBOutlet weak var circleNotif: UIImageView!
    @IBOutlet weak var iconNotif: UIImageView!
    @IBOutlet weak var lblNotif: UILabel!
    
    @IBOutlet weak var circleLogis: UIImageView!
    @IBOutlet weak var iconLogis: UIImageView!
    @IBOutlet weak var lblLogis: UILabel!
    
    @IBOutlet weak var circleContact: UIImageView!
    @IBOutlet weak var iconContact: UIImageView!
    @IBOutlet weak var lblContact: UILabel!
    
    @IBOutlet weak var circleSettings: UIImageView!
    @IBOutlet weak var iconSettings: UIImageView!
    @IBOutlet weak var lblSettings: UILabel!
    
    @IBOutlet weak var offerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showController), name: NSNotification.Name(rawValue: "showController"), object: nil)
        
        if CurrentUser.userInfo?.typeUser == "4"{
            DailyDealsView.isHidden = true
            offerView.isHidden = true
            ProductView.isHidden = true
            ChatView.isHidden = true
            MyOrdersView.isHidden = true
            CartView.isHidden = true

        }else{
            
        }
        
        circleHome.isHidden = false
        iconHome.image = UIImage(named: "homeGreen")
        lblhome.textColor = "AECB1B".color
        
        circleDaily.isHidden = true
        iconDaily.image = UIImage(named: "dealsico")
        lblDaily.textColor = UIColor.white
        
        circleOffer.isHidden = true
        iconOffer.image = UIImage(named: "offersico")
        lblOffer.textColor = UIColor.white
        
        circleProd.isHidden = true
        iconProd.image = UIImage(named: "box")
        lblProd.textColor = UIColor.white
        
        circleChat.isHidden = true
        iconChat.image = UIImage(named: "chatico")
        lblChat.textColor = UIColor.white
        
        circleNotif.isHidden = true
        iconNotif.image = UIImage(named: "notifWihte")
        lblNotif.textColor = UIColor.white
        
        circleLogis.isHidden = true
        iconLogis.image = UIImage(named: "delivery-truck (1)")
        lblLogis.textColor = UIColor.white
        
        circleContact.isHidden = true
        iconContact.image = UIImage(named: "contactico")
        lblContact.textColor = UIColor.white
        
        circleSettings.isHidden = true
        iconSettings.image = UIImage(named: "settingsico")
        lblSettings.textColor = UIColor.white
        
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if CurrentUser.userInfo != nil{
            imgUser.sd_custom(url: CurrentUser.userInfo?.profileImage ?? "")
            lblUserName.text = CurrentUser.userInfo?.name_en
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(getRequest(notification:)), name: Notification.Name("UpdateProfile"), object: nil)
    }
    
    // MARK: - Get Request Notification Center
    @objc func getRequest(notification: NSNotification)  {
        imgUser.sd_custom(url: CurrentUser.userInfo?.profileImage ?? "")
        lblUserName.text = CurrentUser.userInfo?.name_en
    }
    
    
    @objc func showController() {
        print("mmnb")
    
        let navigationController = sideMenuController!.rootViewController as! CustomNavigationBar
        
        let vc:ChatVC = AppDelegate.sb_main.instanceVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
        navigationController.setViewControllers([vc], animated: false)
    }
    
    
    
    
    
    @IBAction func HomeButton(_ sender: Any) {
        let navigationController = sideMenuController!.rootViewController as! CustomNavigationBar
        
        let vc:MyOrderMainList = AppDelegate.sb_main.instanceVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
        navigationController.setViewControllers([vc], animated: false)
        sideMenuController!.hideLeftView(animated: true, delay: 0.0, completionHandler: nil)
        sideMenuController!.hideRightView(animated: true, delay: 0.0, completionHandler: nil)
        
        circleHome.isHidden = false
        iconHome.image = UIImage(named: "homeGreen")
        lblhome.textColor = "AECB1B".color
        
        circleDaily.isHidden = true
        iconDaily.image = UIImage(named: "dealsico")
        lblDaily.textColor = UIColor.white
        
        circleOffer.isHidden = true
        iconOffer.image = UIImage(named: "offersico")
        lblOffer.textColor = UIColor.white
        
        circleProd.isHidden = true
        iconProd.image = UIImage(named: "box")
        lblProd.textColor = UIColor.white
        
        circleChat.isHidden = true
        iconChat.image = UIImage(named: "chatico")
        lblChat.textColor = UIColor.white
        
        circleNotif.isHidden = true
        iconNotif.image = UIImage(named: "notifWihte")
        lblNotif.textColor = UIColor.white
        
        circleLogis.isHidden = true
        iconLogis.image = UIImage(named: "delivery-truck (1)")
        lblLogis.textColor = UIColor.white
        
        circleContact.isHidden = true
        iconContact.image = UIImage(named: "contactico")
        lblContact.textColor = UIColor.white
        
        circleSettings.isHidden = true
        iconSettings.image = UIImage(named: "settingsico")
        lblSettings.textColor = UIColor.white
        
        
    }
    
    
    @IBAction func ProductButton(_ sender: Any) {
        //prodect
        let navigationController = sideMenuController!.rootViewController as! CustomNavigationBar
        
        let vc:ProductVC = AppDelegate.sb_main.instanceVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
        navigationController.setViewControllers([vc], animated: false)
        sideMenuController!.hideLeftView(animated: true, delay: 0.0, completionHandler: nil)
        sideMenuController!.hideRightView(animated: true, delay: 0.0, completionHandler: nil)
        
        circleHome.isHidden = true
        iconHome.image = UIImage(named: "homeico")
        lblhome.textColor = UIColor.white
        
        circleDaily.isHidden = true
        iconDaily.image = UIImage(named: "dealsico")
        lblDaily.textColor = UIColor.white
        
        circleOffer.isHidden = true
        iconOffer.image = UIImage(named: "offersico")
        lblOffer.textColor = UIColor.white
        
        circleProd.isHidden = false
        iconProd.image = UIImage(named: "prodectGreen")
        lblProd.textColor = "AECB1B".color
        
        circleChat.isHidden = true
        iconChat.image = UIImage(named: "chatico")
        lblChat.textColor = UIColor.white
        
        circleNotif.isHidden = true
        iconNotif.image = UIImage(named: "notifWihte")
        lblNotif.textColor = UIColor.white
        
        circleLogis.isHidden = true
        iconLogis.image = UIImage(named: "delivery-truck (1)")
        lblLogis.textColor = UIColor.white
        
        circleContact.isHidden = true
        iconContact.image = UIImage(named: "contactico")
        lblContact.textColor = UIColor.white
        
        circleSettings.isHidden = true
        iconSettings.image = UIImage(named: "settingsico")
        lblSettings.textColor = UIColor.white
        
        
    }
    
    @IBAction func MyOrderButton(_ sender: Any) {
        //notifcation
        
        let navigationController = sideMenuController!.rootViewController as! CustomNavigationBar
        
        let vc:NotifcationVC = AppDelegate.sb_main.instanceVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
        navigationController.setViewControllers([vc], animated: false)
        sideMenuController!.hideLeftView(animated: true, delay: 0.0, completionHandler: nil)
        sideMenuController!.hideRightView(animated: true, delay: 0.0, completionHandler: nil)
        
        
        circleHome.isHidden = true
        iconHome.image = UIImage(named: "homeico")
        lblhome.textColor = UIColor.white
        
        circleDaily.isHidden = true
        iconDaily.image = UIImage(named: "dealsico")
        lblDaily.textColor = UIColor.white
        
        circleOffer.isHidden = true
        iconOffer.image = UIImage(named: "offersico")
        lblOffer.textColor = UIColor.white
        
        circleProd.isHidden = true
        iconProd.image = UIImage(named: "box")
        lblProd.textColor = UIColor.white
        
        circleChat.isHidden = true
        iconChat.image = UIImage(named: "chatico")
        lblChat.textColor = UIColor.white
        
        circleNotif.isHidden = false
        iconNotif.image = UIImage(named: "bellGreen")
        lblNotif.textColor = "AECB1B".color
        
        circleLogis.isHidden = true
        iconLogis.image = UIImage(named: "delivery-truck (1)")
        lblLogis.textColor = UIColor.white
        
        circleContact.isHidden = true
        iconContact.image = UIImage(named: "contactico")
        lblContact.textColor = UIColor.white
        
        circleSettings.isHidden = true
        iconSettings.image = UIImage(named: "settingsico")
        lblSettings.textColor = UIColor.white
        
        
        
        
    }
    
    @IBAction func DailyDealsButton(_ sender: Any) {
        
        let navigationController = sideMenuController!.rootViewController as! CustomNavigationBar
        
        let vc:DayDealsVC = AppDelegate.sb_main.instanceVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
        navigationController.setViewControllers([vc], animated: false)
        sideMenuController!.hideLeftView(animated: true, delay: 0.0, completionHandler: nil)
        sideMenuController!.hideRightView(animated: true, delay: 0.0, completionHandler: nil)
        
        
        circleHome.isHidden = true
        iconHome.image = UIImage(named: "homeico")
        lblhome.textColor = UIColor.white
        
        circleDaily.isHidden = false
        iconDaily.image = UIImage(named: "DayGreen")
        lblDaily.textColor = "AECB1B".color
        
        circleOffer.isHidden = true
        iconOffer.image = UIImage(named: "offersico")
        lblOffer.textColor = UIColor.white
        
        circleProd.isHidden = true
        iconProd.image = UIImage(named: "box")
        lblProd.textColor = UIColor.white
        
        circleChat.isHidden = true
        iconChat.image = UIImage(named: "chatico")
        lblChat.textColor = UIColor.white
        
        circleNotif.isHidden = true
        iconNotif.image = UIImage(named: "notifWihte")
        lblNotif.textColor = UIColor.white
        
        circleLogis.isHidden = true
        iconLogis.image = UIImage(named: "delivery-truck (1)")
        lblLogis.textColor = UIColor.white
        
        circleContact.isHidden = true
        iconContact.image = UIImage(named: "contactico")
        lblContact.textColor = UIColor.white
        
        circleSettings.isHidden = true
        iconSettings.image = UIImage(named: "settingsico")
        lblSettings.textColor = UIColor.white
        
    }
    @IBAction func btnRestorant(_ sender: Any) {
        if CurrentUser.userInfo != nil{
            let navigationController = sideMenuController!.rootViewController as! CustomNavigationBar
            let vc:RestaurantDetailsVC = AppDelegate.sb_main.instanceVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
            navigationController.setViewControllers([vc], animated: false)
            sideMenuController!.hideLeftView(animated: true, delay: 0.0, completionHandler: nil)
            sideMenuController!.hideRightView(animated: true, delay: 0.0, completionHandler: nil)
            
        }else{
            let vc:SignInVC = AppDelegate.sb_main.instanceVC()
            present(vc, animated: true, completion: nil)
        }
        
        
        
    }
    
    @IBAction func ChatButton(_ sender: Any) {
        
        let navigationController = sideMenuController!.rootViewController as! CustomNavigationBar
        
        let vc:ChatVC = AppDelegate.sb_main.instanceVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
        navigationController.setViewControllers([vc], animated: false)
        sideMenuController!.hideLeftView(animated: true, delay: 0.0, completionHandler: nil)
        sideMenuController!.hideRightView(animated: true, delay: 0.0, completionHandler: nil)
        
        
        
        circleHome.isHidden = true
        iconHome.image = UIImage(named: "homeico")
        lblhome.textColor = UIColor.white
        
        circleDaily.isHidden = true
        iconDaily.image = UIImage(named: "dealsico")
        lblDaily.textColor = UIColor.white
        
        circleOffer.isHidden = true
        iconOffer.image = UIImage(named: "offersico")
        lblOffer.textColor = UIColor.white
        
        circleProd.isHidden = true
        iconProd.image = UIImage(named: "box")
        lblProd.textColor = UIColor.white
        
        circleChat.isHidden = false
        iconChat.image = UIImage(named: "chat")
        lblChat.textColor = "AECB1B".color
        
        circleNotif.isHidden = true
        iconNotif.image = UIImage(named: "notifWihte")
        lblNotif.textColor = UIColor.white
        
        circleLogis.isHidden = true
        iconLogis.image = UIImage(named: "delivery-truck (1)")
        lblLogis.textColor = UIColor.white
        
        circleContact.isHidden = true
        iconContact.image = UIImage(named: "contactico")
        lblContact.textColor = UIColor.white
        
        circleSettings.isHidden = true
        iconSettings.image = UIImage(named: "settingsico")
        lblSettings.textColor = UIColor.white
        
        
    }
    
    @IBAction func OffersButton(_ sender: Any) {
        let navigationController = sideMenuController!.rootViewController as! CustomNavigationBar
        let vc:OffersVC = AppDelegate.sb_main.instanceVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
        navigationController.setViewControllers([vc], animated: false)
        sideMenuController!.hideLeftView(animated: true, delay: 0.0, completionHandler: nil)
        sideMenuController!.hideRightView(animated: true, delay: 0.0, completionHandler: nil)
        circleHome.isHidden = true
        iconHome.image = UIImage(named: "homeico")
        lblhome.textColor = UIColor.white
        
        circleDaily.isHidden = true
        iconDaily.image = UIImage(named: "dealsico")
        lblDaily.textColor = UIColor.white
        
        
        circleOffer.isHidden = false
        iconOffer.image = UIImage(named: "OfferGreen")
        lblOffer.textColor = "AECB1B".color
        
        circleProd.isHidden = true
        iconProd.image = UIImage(named: "box")
        lblProd.textColor = UIColor.white
        
        circleChat.isHidden = true
        iconChat.image = UIImage(named: "chatico")
        lblChat.textColor = UIColor.white
        
        circleNotif.isHidden = true
        iconNotif.image = UIImage(named: "notifWihte")
        lblNotif.textColor = UIColor.white
        
        circleLogis.isHidden = true
        iconLogis.image = UIImage(named: "delivery-truck (1)")
        lblLogis.textColor = UIColor.white
        
        circleContact.isHidden = true
        iconContact.image = UIImage(named: "contactico")
        lblContact.textColor = UIColor.white
        
        circleSettings.isHidden = true
        iconSettings.image = UIImage(named: "settingsico")
        lblSettings.textColor = UIColor.white
        
        
    }
    
    @IBAction func MyCartButton(_ sender: Any) {
        //logistic
        let navigationController = sideMenuController!.rootViewController as! CustomNavigationBar
        
        let vc:LogicticVC = AppDelegate.sb_main.instanceVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
        navigationController.setViewControllers([vc], animated: false)
        sideMenuController!.hideLeftView(animated: true, delay: 0.0, completionHandler: nil)
        sideMenuController!.hideRightView(animated: true, delay: 0.0, completionHandler: nil)
        
        circleHome.isHidden = true
        iconHome.image = UIImage(named: "homeico")
        lblhome.textColor = UIColor.white
        
        circleDaily.isHidden = true
        iconDaily.image = UIImage(named: "dealsico")
        lblDaily.textColor = UIColor.white
        
        circleOffer.isHidden = true
        iconOffer.image = UIImage(named: "offersico")
        lblOffer.textColor = UIColor.white
        
        circleProd.isHidden = true
        iconProd.image = UIImage(named: "box")
        lblProd.textColor = UIColor.white
        
        circleChat.isHidden = true
        iconChat.image = UIImage(named: "chatico")
        lblChat.textColor = UIColor.white
        
        circleNotif.isHidden = true
        iconNotif.image = UIImage(named: "notifWihte")
        lblNotif.textColor = UIColor.white
        
        circleLogis.isHidden = false
        iconLogis.image = UIImage(named: "carGreen")
        lblLogis.textColor = "AECB1B".color
        
        circleContact.isHidden = true
        iconContact.image = UIImage(named: "contactico")
        lblContact.textColor = UIColor.white
        
        circleSettings.isHidden = true
        iconSettings.image = UIImage(named: "settingsico")
        lblSettings.textColor = UIColor.white
    }
    
    
    
    @IBAction func ContactButton(_ sender: Any) {
        
        let navigationController = sideMenuController!.rootViewController as! CustomNavigationBar
        
        let vc:ContactUsVC = AppDelegate.sb_main.instanceVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
        navigationController.setViewControllers([vc], animated: false)
        sideMenuController!.hideLeftView(animated: true, delay: 0.0, completionHandler: nil)
        sideMenuController!.hideRightView(animated: true, delay: 0.0, completionHandler: nil)
        
        
        circleHome.isHidden = true
        iconHome.image = UIImage(named: "homeico")
        lblhome.textColor = UIColor.white
        
        circleDaily.isHidden = true
        iconDaily.image = UIImage(named: "dealsico")
        lblDaily.textColor = UIColor.white
        
        circleOffer.isHidden = true
        iconOffer.image = UIImage(named: "offersico")
        lblOffer.textColor = UIColor.white
        
        
        circleProd.isHidden = true
        iconProd.image = UIImage(named: "box")
        lblProd.textColor = UIColor.white
        
        circleChat.isHidden = true
        iconChat.image = UIImage(named: "chatico")
        lblChat.textColor = UIColor.white
        
        circleNotif.isHidden = true
        iconNotif.image = UIImage(named: "notifWihte")
        lblNotif.textColor = UIColor.white
        
        
        circleLogis.isHidden = true
        iconLogis.image = UIImage(named: "delivery-truck (1)")
        lblLogis.textColor = UIColor.white
        
        circleContact.isHidden = false
        iconContact.image = UIImage(named: "contactGreen")
        lblContact.textColor = "AECB1B".color
        
        circleSettings.isHidden = true
        iconSettings.image = UIImage(named: "settingsico")
        lblSettings.textColor = UIColor.white
    }
    
    @IBAction func SettingsButton(_ sender: Any) {
        
        let navigationController = sideMenuController!.rootViewController as! CustomNavigationBar
        
        let vc:SettingsVC = AppDelegate.sb_main.instanceVC()
        self.navigationController?.pushViewController(vc, animated: true)
        
        navigationController.setViewControllers([vc], animated: false)
        sideMenuController!.hideLeftView(animated: true, delay: 0.0, completionHandler: nil)
        sideMenuController!.hideRightView(animated: true, delay: 0.0, completionHandler: nil)
        
        
        circleHome.isHidden = true
        iconHome.image = UIImage(named: "homeico")
        lblhome.textColor = UIColor.white
        
        circleDaily.isHidden = true
        iconDaily.image = UIImage(named: "dealsico")
        lblDaily.textColor = UIColor.white
        
        circleOffer.isHidden = true
        iconOffer.image = UIImage(named: "offersico")
        lblOffer.textColor = UIColor.white
        
        
        circleProd.isHidden = true
        iconProd.image = UIImage(named: "box")
        lblProd.textColor = UIColor.white
        
        circleChat.isHidden = true
        iconChat.image = UIImage(named: "chatico")
        lblChat.textColor = UIColor.white
        
        circleNotif.isHidden = true
        iconNotif.image = UIImage(named: "notifWihte")
        lblNotif.textColor = UIColor.white
        
        
        circleLogis.isHidden = true
        iconLogis.image = UIImage(named: "delivery-truck (1)")
        lblLogis.textColor = UIColor.white
        
        circleContact.isHidden = true
        iconContact.image = UIImage(named: "contactico")
        lblContact.textColor = UIColor.white
        
        circleSettings.isHidden = false
        iconSettings.image = UIImage(named: "controlsGreen")
        lblSettings.textColor = "AECB1B".color
    }
    
    
    
    
    
    
    
    
}

