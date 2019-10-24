//
//  AddDealDayCV.swift
//  Karam
//
//  Created by ramez adnan on 09/07/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import AAPickerView
class AddDealDayCV: SuperViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var txtNamear: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtNameen: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtdis: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtDesar: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtDesen: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var txtCatagory: AAPickerView!
    @IBOutlet weak var txtProductname: AAPickerView!
    var prodect_id = ""
    var prodect_Name = ""
    var Namear = ""
    var Nameen = ""
    var dis = ""
    var Desar = ""
    var Desen = ""
    var imgs = ""
    var arrayProdect : [ProductnameData] = []
    var isSelected = false
    var isFrom = false
    var isFromEdit = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let navigation = self.navigationController as! CustomNavigationBar
        navigation.setTitle("Add Deal Day".localized, sender: self,Srtingcolor :"AECB1B")
        navigation.setCustomBackButtonForViewController(sender: self)
        
        
        sideMenuController!.isLeftViewSwipeGestureEnabled = false
        sideMenuController!.isRightViewSwipeGestureEnabled = false
        if isFrom == false {
            
        }else{
            
            txtNamear.text = Namear
            txtNameen.text = Nameen
            txtdis.text = dis
            txtDesar.text = Desar
            txtDesen.text = Desen
            txtProductname.text = prodect_Name
            img.sd_custom(url: imgs)
        }
        
        
    }
    
    
    
    func getDealDay() {
        
        
        _ = WebRequests.setup(controller: self).prepare(query: "getProductIDs", method: HTTPMethod.get).start(){ (response, error) in
            
            do {
                let Status =  try JSONDecoder().decode(StructGetProductname.self, from: response.data!)
                self.arrayProdect = Status.items!
                self.pickersSlotSetup()
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }}
        
    }
    
    func pickersDateSetup(){
        
        
        txtCatagory.pickerType = .date
        let datePicker = txtCatagory.datePicker
        datePicker?.datePickerMode = .date
        
        let dateFormatter = txtCatagory.dateFormatter
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        dateFormatter.locale =  NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        
        txtCatagory.valueDidSelected = { (index) in
            
        }
        txtCatagory.valueDidChange = { value in
            print(value)
        }
    }
    
    
    
    func pickersSlotSetup(){
        let resal = self.arrayProdect.map {$0.categoryName!}
        txtProductname.pickerType = .string(data: resal)
        txtProductname.heightForRow = 40
        txtProductname.toolbar.barTintColor = .darkGray
        txtProductname.toolbar.tintColor = .black
        
        
        txtProductname.valueDidSelected = { (index) in
            self.prodect_id = self.arrayProdect[index as! Int].categoryID!
        }
        txtProductname.valueDidChange = { value in
            print(value)
            
        }
    }
    
    
    
    
    @IBAction func btnAddimg(_ sender: Any) {
        let vc = UIImagePickerController()
        //  vc.sourceType = .photoLibrary
        vc.sourceType = .photoLibrary
        
        vc.allowsEditing = true
        vc.delegate = self
        self.present(vc, animated: true)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        isSelected = true
        
        self.img.image = image
        let imgData = (image.jpegData(compressionQuality: 0.1))!
        UserDefaults.standard.set(imgData, forKey: "imgData")
    }
    
    
    @IBAction func btnSave(_ sender: Any) {
        if isFrom == false{
            guard let Namear = self.txtNamear.text, !Namear.isEmpty else{
                self.showAlert(title: "Erorr".localized, message: "Name (Ar) is required".localized)
                return
            }
            guard let nameen = self.txtNameen.text, !nameen.isEmpty else{
                self.showAlert(title: "Erorr".localized, message: "Name (En) is required".localized)
                return
            }
            guard let discont = self.txtdis.text, !discont.isEmpty else{
                self.showAlert(title: "Erorr".localized, message: "Discount (%) is required".localized)
                return
            }
            guard let Desar = self.txtDesar.text, !Desar.isEmpty else{
                self.showAlert(title: "Erorr".localized, message: "Description (Ar) is required".localized)
                return
            }
            
            guard let Desen = self.txtDesen.text, !Desen.isEmpty else{
                self.showAlert(title: "Erorr".localized, message: "Description (En) is required".localized)
                return
            }
            
            guard let datedeal = self.txtCatagory.text, !datedeal.isEmpty else{
                self.showAlert(title: "Erorr".localized, message: "Date is required".localized)
                return
            }
            
            guard let imgProfile = self.img.image else{
                self.showAlert(title: "Erorr".localized, message: "image is required".localized)
                return
            }
            
            self.showIndicator()
            let parameters: [String: Any] = ["product_id": prodect_id, "discount":discont, "name_ar":Namear, "name_en":nameen,"description_ar":Desar,"description_en":Desen,"date":datedeal]
            WebRequests.sendPostMultipartRequestWithImgParam1(url: TAConstant.APIBaseURL + "addDealDay", parameters: parameters as! [String : String], img:imgProfile ,withName:"image") {(response, error) in
                self.hideIndicator()
                
                do {
                    let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                    if !Status.status! {
                        
                        self.showAlert(title: "Error".localized, message:Status.message!)
                        return
                    }
                    
                }catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
            }
            
        }else{
            guard let Namear = self.txtNamear.text, !Namear.isEmpty else{
                self.showAlert(title: "Erorr".localized, message: "Name (Ar) is required".localized)
                return
            }
            guard let nameen = self.txtNameen.text, !nameen.isEmpty else{
                self.showAlert(title: "Erorr".localized, message: "Name (En) is required".localized)
                return
            }
            guard let discont = self.txtdis.text, !discont.isEmpty else{
                self.showAlert(title: "Erorr".localized, message: "Discount (%) is required".localized)
                return
            }
            guard let Desar = self.txtDesar.text, !Desar.isEmpty else{
                self.showAlert(title: "Erorr".localized, message: "Description (Ar) is required".localized)
                return
            }
            
            guard let Desen = self.txtDesen.text, !Desen.isEmpty else{
                self.showAlert(title: "Erorr".localized, message: "Description (En) is required".localized)
                return
            }
            
            guard let datedeal = self.txtCatagory.text, !datedeal.isEmpty else{
                self.showAlert(title: "Erorr".localized, message: "Date is required".localized)
                return
            }
            
            guard let imgProfile = self.img.image else{
                self.showAlert(title: "Erorr".localized, message: "image is required".localized)
                return
            }
            
            self.showIndicator()
            let parameters: [String: Any] = ["product_id": prodect_id, "discount":discont, "name_ar":Namear, "name_en":nameen,"description_ar":Desar,"description_en":Desen,"date":datedeal]
            WebRequests.sendPostMultipartRequestWithImgParam1(url: TAConstant.APIBaseURL + "editDealDay/\(1)", parameters: parameters as! [String : String], img:imgProfile ,withName:"image") {(response, error) in
                self.hideIndicator()
                
                do {
                    let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                    if !Status.status! {
                        
                        self.showAlert(title: "Error".localized, message:Status.message!)
                        return
                    }
                    
                }catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
            }
            
        }
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
