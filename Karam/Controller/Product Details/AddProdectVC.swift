//
//  AddProdectVC.swift
//  Karam
//
//  Created by ramez adnan on 16/07/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import AAPickerView
import Gallery
import MobileCoreServices


class AddProdectVC: SuperViewController, GalleryControllerDelegate {

    @IBOutlet weak var txtdescAr: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var txtcatogory: AAPickerView!
    @IBOutlet weak var txtDescriEn: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtTo: AAPickerView!
    @IBOutlet weak var txtfrom: AAPickerView!
    @IBOutlet weak var txtnameen: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtnamear: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtdiscont: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtPrepTime: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtprice: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var swiyshFeatured: UISwitch!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var switshPublish: UISwitch!
    @IBOutlet weak var swHasOffer: UISwitch!

    @IBOutlet weak var txtnamecaver: SkyFloatingLabelTextField!
    @IBOutlet weak var mainView: UIView!

    
    var imgesAt : [ProductImage] = []

    var selected_image: UIImage? = nil
    var selectedImages: [UIImage] = []
    var values: [String: Any] = [:]
    var statuss = "active"
    var Featured = "1"
     var ProId = 0
    var isFromEdit = false
    var videoData : Data?
    var isVideo = false
    var CategoryArray = [AllCategoryStruct]()
    var slectedCategoryID = 0
    var slectedCategory:String?

    var name_en = ""
    var name_ar = ""
    var description_ar = ""
    var description_en = ""
    var price = ""
    var discount = ""
    var offer_from = ""
    var offer_to = ""
    var is_start = ""
    var status = ""
    var category_id = ""
    var categoryString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if isFromEdit == false {
            
        }else{
            txtnamear.text = name_ar
            txtnameen.text = name_en
            txtTo.text = offer_to
            txtfrom.text = offer_from
            txtprice.text = price
            txtdiscont.text = discount
            txtDescriEn.text = description_en
            txtdescAr.text = description_ar
            txtcatogory.text = categoryString


        }
        let navigation = self.navigationController as! CustomNavigationBar
        navigation.setTitle("Add Prodect".localized, sender: self,Srtingcolor :"AECB1B")
        navigation.setCustomBackButtonForViewController(sender: self)
        
        
        sideMenuController!.isLeftViewSwipeGestureEnabled = false
        sideMenuController!.isRightViewSwipeGestureEnabled = false
        
        
        
        collection.registerCell(id: "ImagesCell")
        
        pickersSetup()
        pickersSetupto()
        getAllCategory()
        
        
      
        
     }
    
    @IBAction func HassOffer(_ sender: UISwitch) {
        if sender.isOn == true{
            mainView.isHidden = false
        }else{
            mainView.isHidden = true
            
        }
    }
    
    func getAllCategory(){
        
        _ = WebRequests.setup(controller: self).prepare(query: "allCategory", method: HTTPMethod.get).start(){ (response, error) in
            do {
                
                let object =  try JSONDecoder().decode(AllCategoryObject.self, from: response.data!)
                
                self.CategoryArray = object.items!
                
                self.config_CategoryPicker()
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }

    @IBAction func statussSwitch(_ sender: UISwitch) {
        if sender.isOn == true{
            statuss = "active"
        }else{
            statuss = "not_active"

        }
    }
    
    @IBAction func FeaturedSwitch(_ sender: UISwitch) {
        if sender.isOn == true{
            Featured = "1"

        }else{
            Featured = "0"

        }
    }

    func config_CategoryPicker() {
        
        txtcatogory.pickerType = .string(data: CategoryArray.map{$0.title!})
        
        txtcatogory.heightForRow = 40
        
        txtcatogory.toolbar.barTintColor = .darkGray
        txtcatogory.toolbar.tintColor = .black
        
        txtcatogory.valueDidSelected = { (index) in
            print("selected String ", self.CategoryArray[index as! Int].id!)
            self.slectedCategoryID = self.CategoryArray[index as! Int].id!
            self.slectedCategory = self.CategoryArray[index as! Int].title!
            
        }
        
        txtcatogory.valueDidChange = { value in
            print("selected Value",value)
            print("selected String ",  self.CategoryArray[value as! Int].id!)
            self.slectedCategoryID = self.CategoryArray[value as! Int].id!
            self.slectedCategory = self.CategoryArray[value as! Int].title!
            
        }
        
    }
    func pickersSetup(){
        txtfrom.pickerType = .date
        let datePicker = txtfrom.datePicker
        datePicker?.datePickerMode = .date
        
        
        let dateFormatter = txtfrom.dateFormatter
        dateFormatter.dateFormat = "yyyy/mm/dd"
        
        
        txtfrom.valueDidSelected = { (index) in
        }
        txtfrom.valueDidChange = { value in
            print(value)
        }
    }
    
    
    func pickersSetupto(){
        txtTo.pickerType = .date
        let datePicker = txtTo.datePicker
        datePicker?.datePickerMode = .date
        
        
        let dateFormatter = txtTo.dateFormatter
        dateFormatter.dateFormat = "yyyy/mm/dd"
        
        
        txtTo.valueDidSelected = { (index) in
        }
        txtTo.valueDidChange = { value in
            print(value)
        }
    }
    @IBAction func didAddPhotosButtonPressed(_ sender: UIButton){
        let gallery = GalleryController()
        gallery.delegate = self
        Config.Camera.imageLimit = 3
        present(gallery, animated: true)
    }
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        
        if images.count <= 3 {
            
            for i in images {
                i.resolve { (_i) in
                    self.selectedImages.append(_i!)
                    if self.selectedImages.count == images.count {
                        self.collection.reloadData()
                    }
                    self.collection.reloadData()
                }
            }
            self.collection.reloadData()
            controller.dismiss(animated: true)
        }else{
            controller.showAlert(title: "Error".localized, message: "chose one photo at lest".localized)
        }
    }
    
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        
        
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {}
    
    func galleryControllerDidCancel(_ controller: GalleryController) { dismiss(animated: true, completion: nil) }
    

    
    @IBAction func btn(_ sender: UIButton) {
        openPhotoLibraryButtonPressed(sender)

        
    }
    @IBAction func btnUploadVedio(_ sender: UIButton) {
        showImagePicker(sender)

    }
    
    
     @IBAction func btnSave(_ sender: Any) {
        if isFromEdit == false {
            guard Helper.isConnectedToNetwork() else {
                self.showAlert(title: "Error".localized, message: "Network Connection Error".localized)
                return }
            guard let namear = self.txtnamear.text, !namear.isEmpty else {
                self.showAlert(title: "Error".localized, message: "Please enter  name Ar".localized)
                return }
            
            guard let nameen = self.txtnameen.text, !nameen.isEmpty else {
                self.showAlert(title: "Error".localized, message: "Please enter  name En".localized)
                return }
            
            guard let price = self.txtprice.text, !price.isEmpty else {
                self.showAlert(title: "Error".localized, message: "Please enter your price".localized)
                return }
            if swHasOffer.isOn {
                            guard let discont = self.txtdiscont.text, !discont.isEmpty else {
                                self.showAlert(title: "Error".localized, message: "Please enter your discount".localized)
                                return }
                
                            guard let fromdate = self.txtfrom.text, !fromdate.isEmpty else {
                                self.showAlert(title: "Error".localized, message: "Please enter your date from".localized)
                                return }
                
                            guard let todata = self.txtTo.text, !todata.isEmpty else {
                                self.showAlert(title: "Error".localized, message: "Please enter your date to".localized)
                                return }
            }
            

            guard let categoryLbl = self.txtcatogory.text, !categoryLbl.isEmpty else {
                self.showAlert(title: "Error".localized, message: "Please enter your category".localized)
                return }
            
            guard let descriptionar = self.txtdescAr.text, !descriptionar.isEmpty else {
                self.showAlert(title: "Error".localized, message: "Please enter your description Ar".localized)
                return }
            
            guard let descriptionen = self.txtDescriEn.text, !descriptionen.isEmpty else {
                self.showAlert(title: "Error".localized, message: "Please enter your description En".localized)
                return }
            
            guard let nameCover = self.txtnamecaver.text, !nameCover.isEmpty else {
                self.showAlert(title: "Error".localized, message: "Please enter your image cover".localized)
                return }
            
            //        if selected_image?.images == nil {
            //            self.showAlert(title: "Error".localized, message: "Please enter  Image is Required".localized)
            //            return
            //        }
            
            
            values["name_en"] = nameen
            values["name_ar"] = namear
            values["description_ar"] = descriptionar
            values["description_en"] = descriptionen
            values["price"] = price
            values["discount"] = self.txtdiscont.text  ?? ""
            values["prepareTime"] = self.txtPrepTime.text  ?? ""

            values["offer_from"] = self.txtfrom.text ?? ""
            values["offer_to"] = self.txtTo.text ?? ""
            values["is_start"] = Featured
            values["status"] = statuss
            values["category_id"] = slectedCategoryID.description
            
            
            Helper.showIndicator(view: self.view)
            WebRequests.sendPostMultipartWithImages(url: TAConstant.APIBaseURL + "addProduct", parameters: values as! [String : String], imgs: selectedImages, withName: "images", img: selected_image ?? UIImage(), logoName: "cover_image", video: videoData ?? Data()) { (response, error) in
                Helper.hideIndicator(view: self.view)
//                if error != nil {
//                    self.showAlert(title: "خطأ", message: error?.localizedDescription ?? ""); return }
                do {
                    
                    let Status =  try JSONDecoder().decode(StatusStruct.self, from: (response).data!)
                    print(Status)
                    if Status.status!  {
                        self.navigationController?.pop(animated: true)
                        
                    }else{
                        self.showAlert(title: "Error".localized, message: Status.message!)
                        
                    }
                } catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
                
                guard let response = response as? NSDictionary else {return}

                let status = StatusJoin.init(dict: response)
                print(response)

                if status.status {
                    self.navigationController?.pop(animated: true)


                }else {
                    self.showAlert(title: "Error".localized, message: status.message)
                }
                
            }
        }else{
            
        
        guard Helper.isConnectedToNetwork() else {
            self.showAlert(title: "Error".localized, message: "Network Connection Error".localized)
            return }
        guard let namear = self.txtnamear.text, !namear.isEmpty else {
            self.showAlert(title: "Error".localized, message: "Please enter your name Ar".localized)
            return }

        guard let nameen = self.txtnameen.text, !nameen.isEmpty else {
            self.showAlert(title: "Error".localized, message: "Please enter your name En".localized)
            return }

        guard let price = self.txtprice.text, !price.isEmpty else {
            self.showAlert(title: "Error".localized, message: "Please enter your price".localized)
            return }
            
            let discontt = self.txtdiscont.text
            let fromdate = self.txtfrom.text
            let todata = self.txtTo.text
//            if swHasOffer.isOn{
//                guard (discontt != nil) , !(discontt != nil) ?? "".isEmpty else {
//                    self.showAlert(title: "Error".localized, message: "Please enter your discount".localized)
//                    return }
//
//                guard (fromdate != nil) , !(fromdate != nil) ?? "".isEmpty else {
//                    self.showAlert(title: "Error".localized, message: "Please enter your date from".localized)
//                    return }
//
//                guard (todata != nil)  , !(todata != nil) ?? "".isEmpty else {
//                    self.showAlert(title: "Error".localized, message: "Please enter your date to".localized)
//                    return }
//            }
            
            if swHasOffer.isOn {
                guard let discont = self.txtdiscont.text, !discont.isEmpty else {
                    self.showAlert(title: "Error".localized, message: "Please enter your discount".localized)
                    return }
                
                guard let fromdate = self.txtfrom.text, !fromdate.isEmpty else {
                    self.showAlert(title: "Error".localized, message: "Please enter your date from".localized)
                    return }
                
                guard let todata = self.txtTo.text, !todata.isEmpty else {
                    self.showAlert(title: "Error".localized, message: "Please enter your date to".localized)
                    return }
            }

     

            guard let categoryLbl = self.txtcatogory.text, !categoryLbl.isEmpty else {
                self.showAlert(title: "Error".localized, message: "Please enter your category".localized)
                return }
            
        guard let descriptionar = self.txtdescAr.text, !descriptionar.isEmpty else {
            self.showAlert(title: "Error".localized, message: "Please enter your description Ar".localized)
            return }

        guard let descriptionen = self.txtDescriEn.text, !descriptionen.isEmpty else {
            self.showAlert(title: "Error".localized, message: "Please enter your description En".localized)
            return }
            
            guard let nameCover = self.txtnamecaver.text, !nameCover.isEmpty else {
                self.showAlert(title: "Error".localized, message: "Please enter your image cover".localized)
                return }
        
//        if selected_image?.images == nil {
//            self.showAlert(title: "Error".localized, message: "Please enter  Image is Required".localized)
//            return
//        }

        
        values["name_en"] = nameen
        values["name_ar"] = namear
        values["description_ar"] = descriptionar
        values["description_en"] = descriptionen
        values["price"] = price
        values["discount"] = discontt ?? ""
        values["offer_from"] = fromdate ?? ""
        values["offer_to"] = todata ?? ""
        values["is_start"] = Featured
        values["status"] = statuss
        values["category_id"] = slectedCategoryID.description


        Helper.showIndicator(view: self.view)
            WebRequests.sendPostMultipartWithImages(url: TAConstant.APIBaseURL + "editProduct/\(ProId)", parameters: values as! [String : String], imgs: selectedImages, withName: "images", img: selected_image ?? UIImage(), logoName: "cover_image", video: videoData ?? Data()) { (response, error) in
            Helper.hideIndicator(view: self.view)
                do {
                    
                    let Status =  try JSONDecoder().decode(StatusStruct.self, from: (response).data!)
                    if Status.status!  {
                        self.navigationController?.pop(animated: true)
                        
                        
                        
                    }else{
                        self.showAlert(title: "Error".localized, message: Status.message!)
                        
                    }
                } catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
                
            if error != nil {
                self.showAlert(title: "خطأ", message: error?.localizedDescription ?? ""); return }
            
            guard let response = response as? NSDictionary else {return}
            
            let status = StatusJoin.init(dict: response)
            print(response)
            
            if status.status {
                self.navigationController?.pop(animated: true)
                
                
            }else {
                self.showAlert(title: "Error".localized, message: status.message)
            }}}
        
    }
        
     }
  


extension AddProdectVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        if isVideo == true{
            guard let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL else {
                return
            }
            do {
                let data = try Data(contentsOf: videoUrl, options: .mappedIfSafe)
                print(data)
                
                self.videoData = data
                if videoData != nil{
                 //   txtnamecaver.text = "Succsessfully added video"
                    
                }else{
                    
                }
                
            } catch  {
            }
            
        }else{
            
            
            var image = UIImage()
            
            if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                image = img
            }else if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                image = img
            }
         //   self.imgProfile.image = image
            self.selected_image = image
            if selected_image != nil{
                txtnamecaver.text = "Succsessfully added caver"

            }else{
                
            }
            
            isVideo = true
        }}
    
    @objc func showImagePicker(_ sender: UIButton){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.mediaTypes = [kUTTypeMovie as NSString as String]
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc private func openPhotoLibraryButtonPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            let pickerController = UIImagePickerController()
            
            pickerController.delegate = self
            pickerController.allowsEditing = true
            
            let alert = UIAlertController(title: "Add Photo".localized, message: nil, preferredStyle: .actionSheet)
            
            let camera = UIAlertAction(title: "camera".localized, style: .default) { (action) in
                #if TARGET_IPHONE_SIMULATOR
                print("sim")
                #else
                pickerController.sourceType = .camera
                self.present(pickerController, animated: true, completion: nil)
                #endif
            }
            let photoLibrary = UIAlertAction(title: "photo library".localized, style: .default) { (action) in
                pickerController.sourceType = .photoLibrary
                self.present(pickerController, animated: true, completion: nil)
            }
            
            let savedAlbum = UIAlertAction(title: "saved album".localized, style: .default) { (action) in
                
                pickerController.sourceType = .savedPhotosAlbum
                self.present(pickerController, animated: true, completion: nil)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel".localized, style: .destructive, handler: nil)
            
            alert.addAction(camera)
            alert.addAction(photoLibrary)
            alert.addAction(savedAlbum)
            alert.addAction(cancelAction)
            
            if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
            {
                if let currentPopoverpresentioncontroller = alert.popoverPresentationController{
                    DispatchQueue.main.async {
                        currentPopoverpresentioncontroller.sourceView = sender
                        currentPopoverpresentioncontroller.sourceRect = sender.bounds
                        currentPopoverpresentioncontroller.permittedArrowDirections = .up
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }else{
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}


extension AddProdectVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count + imgesAt.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item <= selectedImages.count - 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCell", for: indexPath) as! ImagesCell
            
            let img = selectedImages[indexPath.item]
            cell.img_view.image = img
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCell", for: indexPath) as! ImagesCell
        
        let img = imgesAt[indexPath.item - selectedImages.count]
        cell.img_view.sd_custom(url: img.image!)
        
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 55, height: 55)
    }
    
}
