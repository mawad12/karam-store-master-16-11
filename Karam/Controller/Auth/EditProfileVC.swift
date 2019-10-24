//
//  EditProfileVC.swift
//  Karam
//
//  Created by ramez adnan on 20/07/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import AAPickerView
import DropDown
import GoogleMaps
import BIZPopupView
import GooglePlaces
import GooglePlacePicker
import ActionSheetPicker_3_0
import Gallery
import MobileCoreServices
import PlacesPicker


class EditProfileVC: SuperViewController , UITextFieldDelegate,GalleryControllerDelegate,SelectTypeFoodDelegate,PlacesPickerDelegate {
    
    @IBOutlet weak var txttypefood: UITextField!
    @IBOutlet weak var imgProfile: UIImageView!
    var selected_image: UIImage? = nil
    var selectedImages: [UIImage] = []
    var values: [String: Any] = [:]
    @IBOutlet weak var collectionView: UICollectionView!
    var videoData : Data!
    var isVideo = false
    var sub_id = 0
    var selectedCatId: [String] = []
    var selectedCatName: [String] = []

    var typeFood_id = 0
    var address = ""
    var lat = ""
    var lng = ""
    var haveplace = ""
    @IBOutlet weak var imgHr24: UIImageView!
    @IBOutlet weak var btnFromTo: UIButton!
    @IBOutlet weak var viewImgPro: UIView!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var viewPhone: UIView!
    @IBOutlet weak var viewDescr: UIView!
    @IBOutlet weak var viewFrom: UIView!
    @IBOutlet weak var viewFulltime: UIView!
    @IBOutlet weak var viewSelectCoun: UIView!
    
    @IBOutlet weak var viewDeleviryTime: UIView!
    @IBOutlet weak var viewDeleviryCost: UIView!
    @IBOutlet weak var viewCity: UIView!
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var viewFoodType: UIView!
    @IBOutlet weak var viewDelivary: UIView!
    @IBOutlet weak var viewCost: UIView!
    @IBOutlet weak var viewImgarray: UIView!
    @IBOutlet weak var viewVideo: UIView!
    @IBOutlet weak var viewSinup: UIView!
    @IBOutlet weak var viewTitleWorking: UIView!
    @IBOutlet weak var cityPicker: AAPickerView!
    
    @IBOutlet weak var viewPayment: UIView!
    
    @IBOutlet weak var txtName: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtMobile: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtDescription: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtArabicDiscrbtion: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtArabicName: SkyFloatingLabelTextFieldWithIcon!

    @IBOutlet weak var lbllocation: SkyFloatingLabelTextField!
    @IBOutlet weak var txtTimefrom: AAPickerView!
    @IBOutlet weak var txtTimeto: AAPickerView!
    
    @IBOutlet weak var txtdelaviryCost: SkyFloatingLabelTextField!
    @IBOutlet weak var txtdelavirytime: SkyFloatingLabelTextField!
    @IBOutlet weak var txtdminimum: SkyFloatingLabelTextField!

    @IBOutlet weak var txtfacebok: SkyFloatingLabelTextField!
    @IBOutlet weak var txttwitter: SkyFloatingLabelTextField!
    @IBOutlet weak var txtinstagram: SkyFloatingLabelTextField!

    @IBOutlet weak var counrty_Img: UIImageView!
    @IBOutlet weak var country_Lbl: UILabel!
    @IBOutlet weak var selectCountryButton: UIButton!
    
    @IBOutlet weak var imgNo: UIImageView!
    @IBOutlet weak var imgYes: UIImageView!
    @IBOutlet weak var imgCash: UIImageView!
    @IBOutlet weak var imgOnline: UIImageView!
    @IBOutlet weak var imgBoth: UIImageView!
    
    
    @IBOutlet weak var imgDelivery: UIImageView!
    @IBOutlet weak var imgpickup: UIImageView!
    @IBOutlet weak var imgBothD: UIImageView!
    
    let selectCountryDropDown = DropDown()
    var countryArray = [CountryStruct]()
    
    var cityArray = [CountryStruct]()
    var foodArray = [TypeFood]()
    
    var slectedCounrty:String?
    var slectedCounrtyID:String?
    var imgesAt : [AttatchmentUser] = []
    var slectedCity:String?
    var slectedCityID:String?
    var userProfile : userprofile? = nil
    var typeServiceProvider = "individual"
    var deliveryType = "delivery"
    var paymentType = "cash"

    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerCell(id: "ImagesCell")
        getCountry()
        allFoodTypeDate()
        cityPicker.isEnabled = false
        pickersSetup()
        pickersSetupto()
        getProfile()
        txtName.text = CurrentUser.userInfo?.name_en
        txtArabicName.text = CurrentUser.userInfo?.name_ar

        txtMobile.text = CurrentUser.userInfo?.mobile
        txtDescription.text = CurrentUser.userInfo?.itemsDescription

        
        country_Lbl.text = CurrentUser.userInfo?.country?.name
        cityPicker.text = CurrentUser.userInfo?.city?.name
        lbllocation.text = CurrentUser.userInfo?.address
        txtdminimum.text = CurrentUser.userInfo?.minimumOrderPrice
        txtdelaviryCost.text = CurrentUser.userInfo?.deliveryCost
        txtdelavirytime.text = CurrentUser.userInfo?.deliveryTime
        txtTimefrom.text = CurrentUser.userInfo?.timeFrom
        txtTimeto.text = CurrentUser.userInfo?.timeTo
        imgProfile.sd_custom(url: (CurrentUser.userInfo?.profileImage)!)
        slectedCityID = CurrentUser.userInfo?.cityID
        slectedCounrtyID = CurrentUser.userInfo?.country?.id?.description
        self.txttypefood.text = CurrentUser.userInfo?.category?.title

        // self.imgesAt = ((CurrentUser.userInfo?.attatchment)!)
        // self.collectionView.reloadData()


        let navigation = self.navigationController as! CustomNavigationBar
        navigation.setTitle("Edit Profile", sender: self,Srtingcolor :"AECB1B")
        navigation.setCustomBackButtonForViewController(sender: self)
        
        
        sideMenuController?.isLeftViewSwipeGestureEnabled = false
        sideMenuController?.isRightViewSwipeGestureEnabled = false
        
        
    }
    
    func getProfile() {
        
        
        _ = WebRequests.setup(controller: self).prepare(query: "getProfile", method: HTTPMethod.get).start(){ (response, error) in
            
            do {
                let Status =  try JSONDecoder().decode(StructUserProfile.self, from: response.data!)
             
                self.userProfile = Status.items
                
                let txtdata = self.userProfile?.foodType
                self.imgesAt = (self.userProfile?.attatchment)!
                
                self.txttypefood.text = txtdata!.compactMap{$0.name}.joined(separator:", ")
//                self.txttypefood.text = self.userProfile?.category?.title
              self.collectionView.reloadData()


//                if let selectedCatName = selectedCatName {
//                    self.txttypefood.text = selectedCatName.map {($0.name! as? String) ?? nil}.compactMap({$0}).joined(separator: ",")
//                }

               // self.txttypefood.text = self.userProfile?.foodType.jo
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }}
        
    }

    @IBAction func SelectedCatogoris(_ sender: Any) {
        let smallViewController = AppDelegate.sb_main.instantiateViewController(withIdentifier: "SelectMainCatogrisVC") as! SelectMainCatogrisVC
        smallViewController.delegate = self
        smallViewController.selectedCatId = self.selectedCatId
        smallViewController.selectedCatName = self.selectedCatName
        let popupViewController = BIZPopupViewController(contentViewController: smallViewController, contentSize: CGSize(width: CGFloat(300), height: CGFloat(400)))
        
        popupViewController?.showDismissButton = true
        popupViewController?.enableBackgroundFade = true
        self.present(popupViewController!, animated: false, completion: nil)
    }

    func didcatogorisSelected(ids: [String], names: [String]) {
        self.txttypefood.text = names.joined(separator: ", ")
        print("ramez")
        self.values["foodType"] = ids.joined(separator: ",")
        
    }
   
    @IBAction func btnTypeacount(_ sender: UIButton) {
        if sender.tag == 0 {
            imgNo.image = UIImage(named:"checkedBox")
            imgYes.image = UIImage(named:"checkBox")
            haveplace = "0"
            
        }else{
            imgNo.image = UIImage(named:"checkBox")
            imgYes.image = UIImage(named:"checkedBox")
            haveplace = "1"
        }}
    // working time
    @IBAction func btnWorkingTime(_ sender: UIButton) {
        if sender.tag == 0 {
            imgHr24.image = UIImage(named:"checkBox")
            btnFromTo.setImage(UIImage(named:"checkedBox"), for: .normal)
        }else{
            imgHr24.image = UIImage(named:"checkedBox")
            btnFromTo.setImage(UIImage(named:"checkBox"), for: .normal)
            
        }
    }
    // select delivery
    
    @IBAction func btnDelivaryStaues(_ sender: UIButton) {
        if sender.tag == 0 {
            imgDelivery.image = UIImage(named:"checkedBox")
            imgpickup.image = UIImage(named:"checkBox")
            imgBothD.image = UIImage(named:"checkBox")
            
        }else if sender.tag == 1 {
            imgDelivery.image = UIImage(named:"checkBox")
            imgpickup.image = UIImage(named:"checkedBox")
            imgBothD.image = UIImage(named:"checkBox")
            
        }else{
            imgDelivery.image = UIImage(named:"checkBox")
            imgpickup.image = UIImage(named:"checkBox")
            imgBothD.image = UIImage(named:"checkedBox")
            
        }
        
        
    }
    // select pament
    
    @IBAction func btnPaymentes(_ sender: UIButton) {
        
        if sender.tag == 0 {
            imgCash.image = UIImage(named:"checkedBox")
            imgOnline.image = UIImage(named:"checkBox")
            imgBoth.image = UIImage(named:"checkBox")
            
        }else if sender.tag == 1 {
            imgCash.image = UIImage(named:"checkBox")
            imgOnline.image = UIImage(named:"checkedBox")
            imgBoth.image = UIImage(named:"checkBox")
            
        }else{
            imgCash.image = UIImage(named:"checkBox")
            imgOnline.image = UIImage(named:"checkBox")
            imgBoth.image = UIImage(named:"checkedBox")
            
        }
        
        
    }
    
    //    allFoodType
    
    func allFoodTypeDate() {
        _ = WebRequests.setup(controller: self).prepare(query: "allFoodType", method: HTTPMethod.get).start(){ (response, error) in
            do {
                
                let object =  try JSONDecoder().decode(StructTypeFood.self, from: response.data!)
                self.foodArray = object.items!
                
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
    
    
    func getCountry() {
        _ = WebRequests.setup(controller: self).prepare(query: "country", method: HTTPMethod.get).start(){ (response, error) in
            do {
                
                let object =  try JSONDecoder().decode(CountryObject.self, from: response.data!)
                self.countryArray = object.items!
                self.setupSelectCountryDropDown()
                
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    func getCity() {
        
        if let CounrtyID = slectedCounrtyID {
            
            
            _ = WebRequests.setup(controller: self).prepare(query: "city", method: HTTPMethod.post, parameters: ["country_id":CounrtyID]).start(){ (response, error) in
                do {
                    
                    let object =  try JSONDecoder().decode(CountryObject.self, from: response.data!)
                    
                    self.cityArray = object.items!
                    if  self.cityArray.count > 0{
                        self.config_CityPicker()
                        self.cityPicker.isEnabled = true
                    }else{
                        self.slectedCityID = nil
                        self.cityPicker.text = ""
                        self.cityPicker.isEnabled = false
                    }
                    
                    
                } catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
            }
        }
    }
    
    func setupSelectCountryDropDown() {
        
        selectCountryDropDown.anchorView = selectCountryButton
        selectCountryDropDown.dataSource = countryArray.map{$0.name!}
        selectCountryDropDown.direction = .bottom
        selectCountryDropDown.bottomOffset = CGPoint(x: 0, y: selectCountryButton.bounds.height)
        
        
        selectCountryDropDown.cellNib = UINib(nibName: "MyCell", bundle: nil)
        selectCountryDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? MyCell else { return }
            
            // Setup your custom UI components
            //cell.logoImageView.image = UIImage(named: "logo_\(index)")
            cell.logoImageView.sd_custom(url:  self.countryArray[index].flag!)
            
            
            self.selectCountryDropDown.selectionAction = { [weak self] (index, item) in
                //self?.CityButton.setTitle(item, for: .normal)
                
                self!.country_Lbl.text = (item)
                self!.counrty_Img.sd_custom(url:  self!.countryArray[index].flag!)
                self!.slectedCounrtyID = "\(self!.countryArray[index].id!)"
                self!.getCity()
            }
            
        }
        
    }
    
    
    
    // MARK: - Select City Button
    func config_CityPicker() {
        
        cityPicker.pickerType = .string(data: cityArray.map{$0.name!})
        
        cityPicker.heightForRow = 40
        
        cityPicker.toolbar.barTintColor = .darkGray
        cityPicker.toolbar.tintColor = .black
        
        cityPicker.valueDidSelected = { (index) in
            print("selected String ", self.cityArray[index as! Int].id!)
            self.slectedCityID = self.cityArray[index as! Int].id?.description
            self.slectedCity = self.cityArray[index as! Int].name!
            
        }
        
        cityPicker.valueDidChange = { value in
            print("selected Value",value)
            print("selected String ",  self.cityArray[value as! Int].id!)
            self.slectedCityID = self.cityArray[value as! Int].id!.description
            self.slectedCity = self.cityArray[value as! Int].name!
            
        }
        
    }
    
    
    
    @IBAction func selecteCountryButton(_ sender: Any) {
        selectCountryDropDown.show()
    }
    
    
    
    
    
    
    @IBAction func BtnTypeFood(_ sender: Any) {
        ActionSheetStringPicker.show(withTitle: "Type food", rows: self.foodArray.map { $0.name as Any}, initialSelection: 0, doneBlock: {
            picker, value, index in
            if let Value = index {
                
                self.txttypefood.text = Value as? String
            }
            self.typeFood_id = self.foodArray[value].id!
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender)
        
    }
    
    
    // Selecte Location
    @IBAction func selectLocationButton(_ sender: Any) {
//        let config = GMSPlacePickerConfig(viewport: nil)
//        let placePicker = GMSPlacePickerViewController(config: config)
//        placePicker.delegate = self
//
//        present(placePicker, animated: true, completion: nil)
//
        let controller = PlacePicker.placePickerController()
        controller.delegate = self
        let navigationController = UINavigationController(rootViewController: controller)
        self.show(navigationController, sender: nil)

    }
    
    func placePickerController(controller: PlacePickerController, didSelectPlace place: GMSPlace) {

        controller.dismiss(animated: true, completion: nil)
        let _place = place.formattedAddress ?? "\(place.coordinate.latitude);\(place.coordinate.longitude)"
        
        if place.formattedAddress != nil {
            print("formattedAddress: \(place.formattedAddress ?? "0")")
            //                let address = place.formattedAddress ?? "0"
            
            print(_place)
            self.lbllocation.text = _place // + ", " + address
            self.values["address"] = _place // + ", " + address
            self.values["lat"] = "\(place.coordinate.latitude.description)"
            self.values["lan"] = "\(place.coordinate.longitude.description)"
        }
        print("new \(self.values)")
        
    }
    
    
    func placePickerControllerDidCancel(controller: PlacePickerController){
        controller.dismiss(animated: true, completion: nil)
        
        print("No place selected")
    }
//    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
//
//        //viewController.dismiss(animated: true, completion: nil)
//        //print("Place name \(place.name)")
//        //print("Place address \(place.formattedAddress)")
//        //print("Place attributions \(place.attributions)")
//
//        print("old \(values)")
//        dismiss(animated: true) {
//            if place.formattedAddress != nil {
//                print("formattedAddress: \(place.formattedAddress ?? "0")")
//                //                let address = place.formattedAddress ?? "0"
//                let _place = place.name ?? ""
//                print(_place)
//                self.lbllocation.text = _place // + ", " + address
//                self.values["address"] = _place // + ", " + address
//                self.values["Latitude"] = "\(place.coordinate.latitude.description ?? "")"
//                self.values["Longitude"] = "\(place.coordinate.longitude.description ?? "")"
//            }
//            print("new \(self.values)")
//        }
//    }
//
//    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
//        // Dismiss the place picker, as it cannot dismiss itself.
//        viewController.dismiss(animated: true, completion: nil)
//
//        print("No place selected")
//    }
//
    
    
    func pickersSetup(){
        txtTimefrom.pickerType = .date
        let datePicker = txtTimefrom.datePicker
        datePicker?.datePickerMode = .time
        
        
        let dateFormatter = txtTimefrom.dateFormatter
        dateFormatter.dateFormat = "HH:mm"
        
        
        txtTimefrom.valueDidSelected = { (index) in
        }
        txtTimefrom.valueDidChange = { value in
            print(value)
        }
    }
    
    
    func pickersSetupto(){
        txtTimeto.pickerType = .date
        let datePicker = txtTimeto.datePicker
        datePicker?.datePickerMode = .time
        
        
        let dateFormatter = txtTimeto.dateFormatter
        dateFormatter.dateFormat = "HH:mm"
        
        
        txtTimeto.valueDidSelected = { (index) in
        }
        txtTimeto.valueDidChange = { value in
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
                        self.collectionView.reloadData()
                    }
                    self.collectionView.reloadData()
                }
            }
            self.collectionView.reloadData()
            controller.dismiss(animated: true)
        }else{
            controller.showAlert(title: "Error".localized, message: "chose one photo at lest".localized)
        }
    }
    
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        
        
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {}
    
    func galleryControllerDidCancel(_ controller: GalleryController) { dismiss(animated: true, completion: nil) }
    
    
    @IBAction func didPhotoLibraryButtonPressed(_ sender: UIButton) {
        openPhotoLibraryButtonPressed(sender)
    }
    @IBAction func didvideoLibraryButtonPressed(_ sender: UIButton) {
        showImagePicker(sender)
    }
    
    
    
    // Skip button
    
    
    @IBAction func signUpButton(_ sender: Any) {
        values["name_en"] = txtName.text ?? ""
        values["mobile"] = txtMobile.text ?? ""
        values["description_en"] = txtDescription.text ?? ""
       // values["package_id"] = sub_id.description
        values["typeServiceProvider"] = typeServiceProvider ?? ""
       values["payment_method"] = paymentType ?? ""
        values["timeFrom"] = txtTimefrom.text ?? ""
        values["timeTo"] = txtTimeto.text ?? ""
        values["country_id"] = slectedCounrtyID?.description ?? ""
        values["city_id"] = slectedCityID?.description ?? ""
        //  values["category_id"] = slectedCategoryID.description
        values["delivery"] = deliveryType 
        values["minimumOrderPrice"] = txtdelaviryCost.text ?? ""
//        values["deliveryTime"] = txtdelavirytime.text ?? ""
        values["deliveryCost"] = txtdelaviryCost.text ?? ""
        values["eatingPlace"] = haveplace 

        values["facebook"] = txtfacebok.text ?? ""
        values["twitter"] = txttwitter.text ?? ""
        values["instagram"] = txtinstagram.text ?? ""
        values["name_ar"] = txtArabicName.text ?? ""
        values["description_ar"] = txtArabicDiscrbtion.text ?? ""

        
        self.showIndicator()
        WebRequests.sendPostMultipartWithImages(url: TAConstant.APIBaseURL + "editProfileService", parameters: values as! [String : String], imgs: selectedImages, withName: "images", img: imgProfile.image ?? UIImage(), logoName: "profile_image", video: videoData ?? Data()) { (response, error) in
            //            Helper.hideIndicator(view: self.view)
            
            self.hideIndicator()
            do {
                
                let Status =  try JSONDecoder().decode(StatusStruct.self, from: (response).data!)
                if Status.status!  {
                    
                    
                    do {
                        let Status =  try JSONDecoder().decode(UserObject.self, from: (response).data!)
                        CurrentUser.userInfo = Status.items
                        let vc:MainVC = AppDelegate.sb_main.instanceVC()
                        let NavigationController :CustomNavigationBar = AppDelegate.sb_main.instanceVC()
                        NavigationController.pushViewController(vc, animated: true)
                        vc.modalPresentationStyle = .fullScreen

                        self.present(vc, animated: true, completion: nil)
                        
                    } catch let jsonErr {
                        print("Error serializing  respone json", jsonErr)
                    }
                    
                }else{
                    self.showAlert(title: "Error".localized, message: Status.message!)
                    
                }
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
            
            
            
        }

        
    }
    
    
    @IBAction func backToSiginInButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}

extension EditProfileVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count + imgesAt.count
    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell: ImagesCell = collectionView.dequeueCVCell(indexPath: indexPath)
//
//
//        if selectedImages.count <= 0{
//            cell.img_view.image = "attach".toImage
//        }else{
//
//            let img = selectedImages[indexPath.item]
//            cell.img_view.image = img
//        }
//
//
//        if imgesAt.count <= 0{
//            cell.img_view.image = "attach".toImage
//        }else{
//
//            let img = imgesAt[indexPath.item]
//            cell.img_view.sd_custom(url: img.image!)
//        }
//
//
//
//
//
//        return cell
//    }
    
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

extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
                
                
            } catch  {
            }
            
        }else{
            
            let image  = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
            
            imgProfile.image = image
            
            
            
            picker.dismiss(animated: true, completion: nil)
            
            
//            self.imgProfile.image = image
//            self.selected_image = image
//            isVideo = true
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
