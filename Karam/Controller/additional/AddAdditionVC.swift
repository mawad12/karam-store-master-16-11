//  AddAdditionVC.swift
//  Karam
//
//  Created by ramez adnan on 22/07/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class AddAdditionVC: SuperViewController {

   var namear = ""
   var nameen = ""
   var price = ""

    var isFrom = false
    var addId = 0
    var myID = 0

    @IBOutlet weak var txtprice: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtname: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtnameEn: SkyFloatingLabelTextFieldWithIcon!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtprice.keyboardType = .numberPad
        
        let navigation = self.navigationController as! CustomNavigationBar
        navigation.setTitle("Add Addition", sender: self,Srtingcolor :"AECB1B")
        navigation.setCustomBackButtonForViewController(sender: self)
        
        
        sideMenuController!.isLeftViewSwipeGestureEnabled = false
        sideMenuController!.isRightViewSwipeGestureEnabled = false
        
        
        if isFrom == false{

        }else{
            txtnameEn.text = nameen
            txtname.text = namear
            txtprice.text = price

        }
        
    }
    
    
    

    @IBAction func btnAdd(_ sender: Any) {
//        self.navigationController?.pop(animated: true)
////        AddAdditionVC
//        let vc:AddAdditionVC = AppDelegate.sb_main.instanceVC()
//        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = vc
        
        if isFrom == false{
            var parameters: [String: Any] = [:]
            
            parameters["name_ar"] = txtname.text
            parameters["name_en"] = txtnameEn.text
            parameters["price"] = txtprice.text
            parameters["product_id"] = addId.description


            _ = WebRequests.setup(controller: self).prepare(query: "addAdditionToProduct", method: HTTPMethod.post, parameters: parameters).start(){ (response, error) in
                
                do {
                    let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                    if !Status.status! {
//

//                        self.showAlert(title: "Error".localized, message:Status.message!)
                        return
                    }else{
                        self.navigationController?.pop(animated: true)

                    }
                    
                }catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }}
        }else{
            var parameters: [String: Any] = [:]
            
           
            parameters["name_ar"] = txtname.text
            parameters["name_en"] = txtnameEn.text
            parameters["price"] = txtprice.text
            parameters["product_id"] = addId.description

            _ = WebRequests.setup(controller: self).prepare(query: "editAdditionToProduct/\(myID)", method: HTTPMethod.post, parameters: parameters).start(){ (response, error) in
                
//                self.navigationController?.popViewController(animated: true)
                do {
                    let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                    if !Status.status! {
                        
                        return
                    }else{
                        self.navigationController?.pop(animated: true)

                    }
                    
                }catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }}

        }
        

        
    }


}
