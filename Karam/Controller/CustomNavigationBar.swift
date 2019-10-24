//
//  CustomNavigationBar.swift
//  dabberly
//
//  Created by ahmed on 6/7/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationController {
    
    
    var EditBtn:          UIBarButtonItem?
    var MoreBtn:          UIBarButtonItem?
    var FilterBtn:        UIBarButtonItem?
    var SearchBtn:        UIBarButtonItem?
    var notficationBtn:   UIBarButtonItem?
    var CartBtn:          UIBarButtonItem?
    var MenuBtn:          UIBarButtonItem?
    var addBtn:           UIBarButtonItem?

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
  
        
        //self.navigationBar.barTintColor = self.UIColorFromRGB(rgbValue: 0x463F5F)
        
        ////Hide bottom border bar
        self.navigationBar.barTintColor = UIColor.white
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.isTranslucent = false
        self.navigationBar.shadowImage = UIImage()
        
        
        self.navigationBar.setBackgroundImage(UIImage(named:"appbarbg"),for: .default)
        let ic_filter: UIImage? = UIImage(named:"ic_filter")?.withRenderingMode(.alwaysOriginal)
        
        FilterBtn = UIBarButtonItem(image: ic_filter, style: UIBarButtonItem.Style.plain, target: self, action: #selector(didClickRightButton))
        
        EditBtn = UIBarButtonItem(image: UIImage(named:"ic_edit")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didClickRightButton))
        
        MoreBtn = UIBarButtonItem(image: UIImage(named:"ic_More")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didClickRightButton))
        
        SearchBtn = UIBarButtonItem(image: UIImage(named:"ic_search")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didClickRightButton))
        
        notficationBtn = UIBarButtonItem(image: UIImage(named:"Notification")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(didClickRightButton))
        
        CartBtn = UIBarButtonItem(image: UIImage(named:"shopping-cart")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didClickRightButton))

        
        MenuBtn = UIBarButtonItem(image: UIImage(named:"Hmbrgr_Menu")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(ShowMenuAction))
        
        addBtn = UIBarButtonItem(image: UIImage(named:"add")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(didClickRightButton))


        MenuBtn?.tag          = 22
        CartBtn?.tag          = 20
        SearchBtn?.tag        = 33
        FilterBtn?.tag        = 44
        EditBtn?.tag          = 55
        EditBtn?.tag          = 88
        notficationBtn?.tag   = 66
        addBtn?.tag           = 77

        /*
         When you are refering controller level navigation bar below method will work
         */
        //        setNavigationBar(withType: .withCustomBackButton)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func HideBottomBorder()  {
        self.navigationBar.barTintColor = "ffffff".color
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        //self.navigationBar.isTranslucent = false
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.layer.masksToBounds = false
        self.navigationBar.layer.shadowColor = UIColor.clear.cgColor
        
        
    }
    
    
    func setShadowNavBar() {
        self.navigationBar.layer.masksToBounds = false
        self.navigationBar.layer.shadowColor = "E8E8E8".color.cgColor
        self.navigationBar.layer.shadowOpacity = 0.8
        self.navigationBar.layer.shadowRadius = 2
        self.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
    }
    
    func setBtnTitle(title :String) -> UIBarButtonItem {
        let BarButton: UIBarButtonItem = UIBarButtonItem.init(title: title, style: .plain, target: self, action: #selector(didClickRightButton))
        BarButton.tintColor = .black
        return BarButton
    }
    
    func setLogotitle(sender :UIViewController){
        let logo = UIImage(named: "logoHeader")
        let imageView = UIImageView(image:logo)
        sender.navigationItem.titleView = imageView
    }
    
    
    func setCustomBackButtonWithdismiss(sender :UIViewController){
        if MOLHLanguage.isRTLLanguage() {
            let back: UIImage? = UIImage(named:"right_back")?.withRenderingMode(.alwaysOriginal)
            
            sender.navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonActionWithdismiss))
            
        } else{
            let back: UIImage? = UIImage(named:"left_back")?.withRenderingMode(.alwaysOriginal)
            
            sender.navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonActionWithdismiss))
            
        }
    }
    
    
    func setCustomBackButtonForViewController(sender :UIViewController){
        if MOLHLanguage.isRTLLanguage() {
            let back: UIImage? = UIImage(named:"right_back")?.withRenderingMode(.alwaysOriginal)
            
            sender.navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonAction))
            
        } else{
            let back: UIImage? = UIImage(named:"left_back")?.withRenderingMode(.alwaysOriginal)
            
            sender.navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonAction))
        }
        
        
    }
    
    func setMeunButton(sender :UIViewController){
        
        sender.navigationItem.leftBarButtonItem = MenuBtn
        
    }
    
    
    @objc func ShowMenuAction (_sender: UIBarButtonItem){
        if MOLHLanguage.isRTLLanguage(){
            sideMenuController?.showRightView(animated: true, completionHandler: nil)
        }else{
            sideMenuController?.showLeftView(animated: true, completionHandler: nil)
        }
        
        
    }
    
    func setRightButtons (_ buttons: NSArray,sender : UIViewController){
        sender.navigationItem.rightBarButtonItems = buttons as? [UIBarButtonItem]
    }
    
    @objc func didClickRightButton(_sender: UIBarButtonItem) {
        let ViewController = self.viewControllers.last as! SuperViewController
        ViewController.didClickRightButton(_sender: _sender)
        
    }
    
    @objc func backButtonAction(_sender: UIBarButtonItem) {
        let ViewController = self.viewControllers.last as! SuperViewController
        ViewController.backButtonAction(_sender: _sender)
        
    }
    
    @objc func backButtonActionWithdismiss(_sender: UIBarButtonItem) {
        let ViewController = self.viewControllers.last as! SuperViewController
        ViewController.backButtonActionWithdismiss(_sender: _sender)
        
    }
    
    func setTitle (_ title: String, sender : UIViewController, Srtingcolor:String = "ffffff"){
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Roboto", size: 17)!
        ]
        sender.navigationController?.navigationBar.titleTextAttributes = attrs
        //sender.navigationController?.navigationBar.topItem?.title = title as String
        sender.navigationItem.title = title as String
        
        sender.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : Srtingcolor.color]
        
        sender.navigationItem.titleView = nil
        ////        let items = self.tabBarController?.tabBar.items
        ////        let tabItem = items![1]
        //        tabItem.title = ""
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    
}
extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}
