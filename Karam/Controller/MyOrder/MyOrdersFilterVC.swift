//
//  RestaurantsProductsFilterVC.swift
//  Karam
//
//  Created by musbah on 7/1/19.
//  Copyright © 2019 musbah. All rights reserved.


import UIKit
import AAPickerView

protocol MyOrdersFilterDelgate : class {
    func SelectedDone(isDelivery: Int, status: String, selectedDate:String)
}



class MyOrdersFilterVC: UIViewController {
    
    
    @IBOutlet weak var orderStatusView: UIView!
    
    
    @IBOutlet weak var StatusPicker: AAPickerView!
    
    
    @IBOutlet weak var OrderDatePicker: AAPickerView!
    
    
    @IBOutlet weak var DeliveryImg: UIImageView!
    
    @IBOutlet weak var PickUpImg: UIImageView!
    
   
    var isCompleteVC = false
    
    var StatusArray = ["All".localized, "New".localized, "Preparing".localized, "Ready".localized, "onDelivery".localized]
    
    var slectedRestaurantID = 0
    var slectedRestaurant:String?
    
    var slectedStatus:String = ""
    
    var selectedDate = ""
    
    var isDelivery = -1
    
    var MyOrdersDelgate : MyOrdersFilterDelgate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isCompleteVC {
            orderStatusView.isHidden = true
        }else{
            orderStatusView.isHidden = false
        }
        
        config_StatusPicker()
        config_DatePicker()
        SelectDeliveryMethode()
    }
   
    
    
    
    
    // Status Picker
    func config_StatusPicker() {
        
        StatusPicker.pickerType = .string(data: self.StatusArray)
        
        StatusPicker.heightForRow = 40
        
        StatusPicker.toolbar.barTintColor = .darkGray
        StatusPicker.toolbar.tintColor = .black
        
        StatusPicker.valueDidSelected = { (index) in
            print("selected String ", self.StatusArray[index as! Int])
            
            //self.slectedStatus = self.StatusArray[index as! Int]
            
//            if self.StatusArray[index as! Int] == "New"{
//                self.slectedStatus = "0"
//            }else if self.StatusArray[index as! Int] == "Preparing"{
//                self.slectedStatus = "1"
//            }else if self.StatusArray[index as! Int] == "Ready"{
//                self.slectedStatus = "2"
//            }else if self.StatusArray[index as! Int] == "onDelivery"{
//                self.slectedStatus = "3"
//            }else if self.StatusArray[index as! Int] == "Completed"{
//                self.slectedStatus = "4"
//            }
//            else{
//                self.slectedStatus = ""
//            }
            
            
            if self.StatusArray[index as! Int] == "New" || self.StatusArray[index as! Int] == "جديد"{
                self.slectedStatus = "0"
            }else if self.StatusArray[index as! Int] == "Preparing" || self.StatusArray[index as! Int] == "تحضير" {
                self.slectedStatus = "1"
            }else if self.StatusArray[index as! Int] == "Ready" || self.StatusArray[index as! Int] == "جاهز"{
                self.slectedStatus = "2"
            }else if self.StatusArray[index as! Int] == "onDelivery" || self.StatusArray[index as! Int] == "في الطريق"{
                self.slectedStatus = "3"
            }else if self.StatusArray[index as! Int] == "Completed" || self.StatusArray[index as! Int] == "مكتمل"{
                self.slectedStatus = "4"
            }
            else{
                self.slectedStatus = ""
            }
            
           
        }
        
        StatusPicker.valueDidChange = { value in
            print("selected Value",value)
            print("selected String ",  self.StatusArray[value as! Int])
            
            //self.slectedStatus = self.StatusArray[value as! Int]
            
//            if self.StatusArray[value as! Int] == "New"{
//                self.slectedStatus = "0"
//            }else if self.StatusArray[value as! Int] == "Preparing"{
//                self.slectedStatus = "1"
//            }else if self.StatusArray[value as! Int] == "Ready"{
//                self.slectedStatus = "2"
//            }else if self.StatusArray[value as! Int] == "onDelivery"{
//                self.slectedStatus = "3"
//            }else if self.StatusArray[value as! Int] == "Completed"{
//                self.slectedStatus = "4"
//            }
//            else{
//                self.slectedStatus = ""
//            }
            
            if self.StatusArray[value as! Int] == "New" || self.StatusArray[value as! Int] == "جديد"{
                self.slectedStatus = "0"
            }else if self.StatusArray[value as! Int] == "Preparing" || self.StatusArray[value as! Int] == "تحضير" {
                self.slectedStatus = "1"
            }else if self.StatusArray[value as! Int] == "Ready" || self.StatusArray[value as! Int] == "جاهز"{
                self.slectedStatus = "2"
            }else if self.StatusArray[value as! Int] == "onDelivery" || self.StatusArray[value as! Int] == "في الطريق"{
                self.slectedStatus = "3"
            }else if self.StatusArray[value as! Int] == "Completed" || self.StatusArray[value as! Int] == "مكتمل"{
                self.slectedStatus = "4"
            }
            else{
                self.slectedStatus = ""
            }
            
        }
        
    }
    
    
    
    
    // MARK: - Select Date
    func config_DatePicker() {
        
        OrderDatePicker.pickerType = .date
        
        OrderDatePicker.datePicker?.datePickerMode = .date
        OrderDatePicker.dateFormatter.dateFormat = "yyyy-MM-dd"
        
        OrderDatePicker.valueDidSelected = { date in
            print("selected Date: ", date as! Date )
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.selectedDate = formatter.string(from: date as! Date)
            _=self.selectedDate.prefix(11) // split text
            
          
            
        }
    }
    
    
    // MARK: - Select Delivery Methode
    func SelectDeliveryMethode() {
        switch isDelivery {
        case 1:
            DeliveryImg.image = #imageLiteral(resourceName: "fillButton")
            PickUpImg.image = #imageLiteral(resourceName: "EmptyCheck")

        case 0:
            DeliveryImg.image = #imageLiteral(resourceName: "EmptyCheck")
            PickUpImg.image = #imageLiteral(resourceName: "fillButton")

        default: break
            
        }
    }
    
    
    
    
    @IBAction func DeliveryButton(_ sender: Any) {
        isDelivery = 1
        SelectDeliveryMethode()
        
    }
    
    @IBAction func PickUpButton(_ sender: Any) {
        isDelivery = 0
        SelectDeliveryMethode()
        
    }
    
    
    
    
   
    
    
    

    @IBAction func tapButton(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    
    
    @IBAction func ResetButton(_ sender: Any) {
            let vc:MainVC = AppDelegate.sb_main.instanceVC()
        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
    }
    
    @IBAction func FilterButton(_ sender: Any) {
        MyOrdersDelgate?.SelectedDone(
                                    isDelivery: isDelivery,
                                    status: slectedStatus,
                                    selectedDate: selectedDate
                                )
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}



