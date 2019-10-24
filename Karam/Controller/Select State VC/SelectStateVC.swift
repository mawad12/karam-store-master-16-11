//
//  SelectStateVC.swift
//  Karam
//
//  Created by musbah on 5/13/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import DropDown



class SelectStateVC: SuperViewController {
    
    
//    @IBOutlet weak var lblState: UILabel!
//
//    @IBOutlet weak var imgState: UIImageView!
//
//
//    @IBOutlet weak var imgArrow: UIImageView!
//
//
//    @IBOutlet weak var selectButton: UIButton!
//
//    let selectCountryDropDown = DropDown()
//
//    @IBAction func selectActionButton(_ sender: Any) {
//        selectCountryDropDown.show()
//    }
    
    
//    var countryArray = [CountryStruct]()
    
//    var slectedCounrty:String?
//    var slectedCounrtyID:String?
    
    var isNav = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        getCountry()
        //setupSelectCountryDropDown()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if isNav{
            let navigation = self.navigationController as! CustomNavigationBar
            navigation.setCustomBackButtonForViewController(sender: self)
            navigation.navigationBar.isTranslucent = true
            navigation.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigation.navigationBar.shadowImage = UIImage()
            
            sideMenuController!.isLeftViewSwipeGestureEnabled = false
            sideMenuController!.isRightViewSwipeGestureEnabled = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if isNav{
            let navigation = self.navigationController as! CustomNavigationBar
            navigation.navigationBar.isTranslucent = false
            navigation.navigationBar.setBackgroundImage(UIImage(named: "whiteBar"), for: .default)
            
            sideMenuController!.isLeftViewSwipeGestureEnabled = false
            sideMenuController!.isRightViewSwipeGestureEnabled = false
        }
    }
    
    
//    func getCountry() {
//        _ = WebRequests.setup(controller: self).prepare(query: "country", method: HTTPMethod.get).start(){ (response, error) in
//            do {
//
//                let object =  try JSONDecoder().decode(CountryObject.self, from: response.data!)
//                self.countryArray = object.items!
//                self.setupSelectCountryDropDown()
//
//            } catch let jsonErr {
//                print("Error serializing  respone json", jsonErr)
//            }
//        }
//    }
    
    
    
//    func setupSelectCountryDropDown() {
//
//        selectCountryDropDown.anchorView = selectButton
//        selectCountryDropDown.dataSource = countryArray.map{$0.name!}
//        selectCountryDropDown.direction = .bottom
//        selectCountryDropDown.bottomOffset = CGPoint(x: 0, y: selectButton.bounds.height)
//
//
//        selectCountryDropDown.cellNib = UINib(nibName: "MyCell", bundle: nil)
//        selectCountryDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
//            guard let cell = cell as? MyCell else { return }
//
//            // Setup your custom UI components
//            //cell.logoImageView.image = UIImage(named: "logo_\(index)")
//            cell.logoImageView.sd_custom(url:  self.countryArray[index].flag!)
//
//
//            self.selectCountryDropDown.selectionAction = { [weak self] (index, item) in
//                //self?.CityButton.setTitle(item, for: .normal)
//                self?.lblState.text = (item)
//                self?.imgState.sd_custom(url:  self!.countryArray[index].flag!)
//                self?.slectedCounrtyID = "\(self!.countryArray[index].id!)"
//
//            }
//
//        }
//
//    }
    
    
    
    
    
    @IBAction func ArabicLang(_ sender: Any) {
        
//        guard let value = self.lblState.text, !value.isEmpty, self.slectedCounrtyID != nil  else{
//            self.showAlert(title: "Erorr".localized, message: "Please Selcet Country".localized)
//            return
//        }
        
//        self.slectedCounrty = value
//        UserDefaults.standard.set(true, forKey:"didSelectState")
//
//        let vc:AdsVC = AppDelegate.sb_main.instanceVC()
//        self.present(vc, animated: true, completion: nil)
//
//        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "ar" ? "en" : "ar")
//        MOLH.reset()
        
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        MOLH.reset()
        //        guard let value = self.lblState.text, !value.isEmpty, self.slectedCounrtyID != nil  else{
        //            self.showAlert(title: "Erorr".localized, message: "Please Selcet Country".localized)
        //            return
        //        }
        
        //        self.slectedCounrty = value
        UserDefaults.standard.set(true, forKey:"didSelectState")
        
        let vc:AdsVC = AppDelegate.sb_main.instanceVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func EnglishLang(_ sender: Any) {
        
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "en" : "en")
        MOLH.reset()
        //        guard let value = self.lblState.text, !value.isEmpty, self.slectedCounrtyID != nil  else{
        //            self.showAlert(title: "Erorr".localized, message: "Please Selcet Country".localized)
        //            return
        //        }
        
        //        self.slectedCounrty = value
        UserDefaults.standard.set(true, forKey:"didSelectState")
        
        let vc:AdsVC = AppDelegate.sb_main.instanceVC()
        vc.modalPresentationStyle = .fullScreen

        self.present(vc, animated: true, completion: nil)
        
        
        
    }
    
}
