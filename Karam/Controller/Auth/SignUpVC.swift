//
//  ViewController.swift
//  PT
//
//  Created by musbah on 3/24/19.
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


class SignUpVC: UIViewController,  UITextFieldDelegate,GalleryControllerDelegate,SelectTypeFoodDelegate , Address,PlacesPickerDelegate{
  
    
  
    
//    GMSPlacePickerViewControllerDelegate
    @IBOutlet weak var txttypefood: UITextField!
    @IBOutlet weak var imgProfile: UIImageView!
    var selected_image: UIImage? = nil
    var selectedImages: [UIImage] = []
    var selectedCatId: [String] = []
    var selectedCatName: [String] = []

    var values: [String: Any] = [:]
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var videoData : Data!
    var isVideo = false
    var sub_id = 0
    var type = ""
    var typeFood_id = 0
     var address = ""
    var lat = ""
    var lng = ""
    var isSelectedImgProfile = false

    let regularFont = UIFont.systemFont(ofSize: 16)
    let boldFont = UIFont.boldSystemFont(ofSize: 16)
    var is24 = false
    @IBOutlet weak var imgHr24: UIImageView!
    @IBOutlet weak var btnFromTo: UIButton!
    @IBOutlet weak var imgTabber: UIImageView!
    @IBOutlet weak var viewImgPro: UIView!
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewPhone: UIView!
    @IBOutlet weak var viewDescr: UIView!
    @IBOutlet weak var viewPack: UIView!
    @IBOutlet weak var viewNext1: UIView!
    @IBOutlet weak var viewType: UIView!
    @IBOutlet weak var viewFrom: UIView!
    @IBOutlet weak var viewFulltime: UIView!
    @IBOutlet weak var viewSelectCoun: UIView!
    @IBOutlet weak var viewCity: UIView!
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var viewFoodType: UIView!
    @IBOutlet weak var viewNext2: UIView!
    @IBOutlet weak var viewDelivary: UIView!
    @IBOutlet weak var viewCost: UIView!
    @IBOutlet weak var viewImgarray: UIView!
    @IBOutlet weak var viewVideo: UIView!
    @IBOutlet weak var viewSinup: UIView!
    @IBOutlet weak var viewTitleWorking: UIView!
    @IBOutlet weak var cityPicker: AAPickerView!

    
    @IBOutlet weak var viewPayment: UIView!
    
    @IBOutlet weak var txtName: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtEmail: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtMobile: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtDescription: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtSubscrption: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtArabicDiscrbtion: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var txtArabicName: SkyFloatingLabelTextFieldWithIcon!

    
    @IBOutlet weak var lbllocation: SkyFloatingLabelTextField!
    @IBOutlet weak var txtTimefrom: AAPickerView!
    @IBOutlet weak var txtTimeto: AAPickerView!

    @IBOutlet weak var txtdelaviryCost: SkyFloatingLabelTextField!
    
    @IBOutlet weak var counrty_Img: UIImageView!
    @IBOutlet weak var country_Lbl: UILabel!
    @IBOutlet weak var selectCountryButton: UIButton!
    
    @IBOutlet weak var imgCompany: UIImageView!
    @IBOutlet weak var imgIndividual: UIImageView!
     @IBOutlet weak var imgCash: UIImageView!
    @IBOutlet weak var imgOnline: UIImageView!
    @IBOutlet weak var imgBoth: UIImageView!

    
    @IBOutlet weak var imgDelivery: UIImageView!
    @IBOutlet weak var imgpickup: UIImageView!
    @IBOutlet weak var imgBothD: UIImageView!

    
    @IBOutlet weak var checkBoxButton: CheckBox!

    
    var CategoryArray = [TypeFood]()
    var SelectedCategoryArray:[TypeFood] = []
    var SelectedCategoryID:String?
    
    
    let selectCountryDropDown = DropDown()
    var countryArray = [CountryStruct]()
    
    var cityArray = [CountryStruct]()
    var foodArray = [TypeFood]()

    var slectedCounrty:String?
    var slectedCounrtyID:String?
    
    var slectedCity:String?
    var slectedCityID:String?

    var typeServiceProvider = "individual"
    var deliveryType = "delivery"
    var paymentType = "cash"


    var objData : [SubscriptionDate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if (txtMobile != nil)
//        {
//            txtMobile.text = "05"
//        }
        
        if type == "2"{
            self.txttypefood.placeholder = "Category"
        }else{
            self.txttypefood.placeholder = "Food Type"
        }
        
        viewType.isHidden = true
        viewFrom.isHidden = true
        viewFulltime.isHidden = true
        viewSelectCoun.isHidden = true
        viewCity.isHidden = true
        viewLocation.isHidden = true
        viewFoodType.isHidden = true
        viewNext2.isHidden = true
        viewDelivary.isHidden = true
        viewCost.isHidden = true
        viewImgarray.isHidden = true
        viewVideo.isHidden = true
        viewSinup.isHidden = true
        viewTitleWorking.isHidden = true
        viewPayment.isHidden = true
        
        collectionView.registerCell(id: "ImagesCell")
        
        getCountry()
        allCategoris()
        cityPicker.isEnabled = false
        
        pickersSetup()
        pickersSetupto()

        GetSubscriptionPakege()
        
    }
    
    
    @IBAction func btn1(_ sender: UIButton) {
        if sender.tag == 0{
            viewImgPro.isHidden = false
            viewName.isHidden = false
            viewEmail.isHidden = false
            viewPhone.isHidden = false
            viewDescr.isHidden = false
            viewPack.isHidden = false
            viewNext1.isHidden = false
            

            viewType.isHidden = true
            viewFrom.isHidden = true
            viewFulltime.isHidden = true
            viewSelectCoun.isHidden = true
            viewCity.isHidden = true
            viewLocation.isHidden = true
            viewFoodType.isHidden = true
            viewNext2.isHidden = true
            viewDelivary.isHidden = true
            viewCost.isHidden = true
            viewImgarray.isHidden = true
            viewVideo.isHidden = true
            viewSinup.isHidden = true
            viewTitleWorking.isHidden = true
            viewPayment.isHidden = true

        }else if sender.tag == 1 {
            
            
            if isSelectedImgProfile == false {
                self.showAlert(title: "Error".localized, message: "Please enter  Image is Required".localized)
                return
            }
            
            guard let name = self.txtName.text, !name.isEmpty else {
                self.showAlert(title: "Error".localized, message: "Please enter your name".localized)
                return }
            
            guard let email = self.txtEmail.text, !email.isEmpty else {
                self.showAlert(title: "Error".localized, message: "Please enter your email".localized)
                return }
            
            guard let mobile = self.txtMobile.text, !mobile.isEmpty else {
                self.showAlert(title: "Error".localized, message: "Please enter your mobile".localized)
                return }
            
            guard let Description = self.txtDescription.text, !Description.isEmpty else {
                self.showAlert(title: "Error".localized, message: "Please enter your Description".localized)
                return }
            
            guard let Subscrption = self.txtSubscrption.text, !Subscrption.isEmpty else {
                self.showAlert(title: "Error".localized, message: "Please enter your Subscrption".localized)
                return }
            
            guard let DescriptionArabic = self.txtArabicDiscrbtion.text, !Description.isEmpty else {
                self.showAlert(title: "Error".localized, message: "Please enter your Description".localized)
                return }

            imgTabber.image = UIImage(named: "Group 74072")
            
            viewImgPro.isHidden = true
            viewName.isHidden = true
            viewEmail.isHidden = true
            viewPhone.isHidden = true
            viewDescr.isHidden = true
            viewPack.isHidden = true
            viewNext1.isHidden = true
            
            viewType.isHidden = false
            viewTitleWorking.isHidden = false
            
            viewFrom.isHidden = false
            viewFulltime.isHidden = false
            viewSelectCoun.isHidden = false
            viewCity.isHidden = false
            viewLocation.isHidden = false
            viewFoodType.isHidden = false
            viewNext2.isHidden = false
            viewDelivary.isHidden = true
            viewCost.isHidden = true
            viewImgarray.isHidden = true
            viewVideo.isHidden = true
            viewSinup.isHidden = true
            viewPayment.isHidden = true
            

        }else{
            
        }
        
    }
    
    func didcatogorisSelected(ids: [String], names: [String]) {
        self.txttypefood.text = names.joined(separator: ", ")
        print("ramez")
        self.values["category_id"] = ids.joined(separator: ",")

    }

    
   // select type
    
    @IBAction func btnTypeacount(_ sender: UIButton) {
        if sender.tag == 0 {
            imgIndividual.image = UIImage(named:"checkedBox")
            imgCompany.image = UIImage(named:"checkBox")
           typeServiceProvider = "individual"
    }else{
            imgIndividual.image = UIImage(named:"checkBox")
            imgCompany.image = UIImage(named:"checkedBox")
            typeServiceProvider = "company"

        }}
    // working time
    @IBAction func btnWorkingTime(_ sender: UIButton) {
        if sender.tag == 0 {
        imgHr24.image = UIImage(named:"checkBox")
            btnFromTo.setImage(UIImage(named:"checkedBox"), for: .normal)
            
        }else{
           imgHr24.image = UIImage(named:"checkedBox")
            btnFromTo.setImage(UIImage(named:"checkBox"), for: .normal)
is24 = true
        }
    }
    // select delivery
    
    @IBAction func btnDelivaryStaues(_ sender: UIButton) {
        if sender.tag == 0 {
            imgDelivery.image = UIImage(named:"checkedBox")
            imgpickup.image = UIImage(named:"checkBox")
            imgBothD.image = UIImage(named:"checkBox")
            deliveryType = "delivery"

        }else if sender.tag == 1 {
            imgDelivery.image = UIImage(named:"checkBox")
            imgpickup.image = UIImage(named:"checkedBox")
            imgBothD.image = UIImage(named:"checkBox")
            deliveryType = "Pickup"

        }else{
            imgDelivery.image = UIImage(named:"checkBox")
            imgpickup.image = UIImage(named:"checkBox")
            imgBothD.image = UIImage(named:"checkedBox")
            deliveryType = "all"

        }

        
    }
    // select pament
    
    @IBAction func btnPaymentes(_ sender: UIButton) {
        
        if sender.tag == 0 {
            imgCash.image = UIImage(named:"checkedBox")
            imgOnline.image = UIImage(named:"checkBox")
            imgBoth.image = UIImage(named:"checkBox")
            paymentType = "cash"
            
        }else if sender.tag == 1 {
            imgCash.image = UIImage(named:"checkBox")
            imgOnline.image = UIImage(named:"checkedBox")
            imgBoth.image = UIImage(named:"checkBox")
            paymentType = "online"

        }else{
            imgCash.image = UIImage(named:"checkBox")
            imgOnline.image = UIImage(named:"checkBox")
            imgBoth.image = UIImage(named:"checkedBox")
            paymentType = "all"

        }

        
    }
    
    
    

    @IBAction func SelectedCatogoris(_ sender: UIButton) {
        
        if type == "2" {
            
            
            let smallViewController = AppDelegate.sb_main.instantiateViewController(withIdentifier: "SelectMainCatogrisVC") as! SelectMainCatogrisVC
            
            smallViewController.type = "2"
            smallViewController.delegate = self
            smallViewController.selectedCatId = self.selectedCatId
            smallViewController.selectedCatName = self.selectedCatName
            let popupViewController = BIZPopupViewController(contentViewController: smallViewController, contentSize: CGSize(width: CGFloat(300), height: CGFloat(350)))
            
            popupViewController?.showDismissButton = true
            popupViewController?.enableBackgroundFade = true
            self.present(popupViewController!, animated: false, completion: nil)
            
        }else{
            
            let blueColor = sender.backgroundColor
            
            let blueAppearance = YBTextPickerAppearanceManager.init(
                pickerTitle         : "Select Categories",
                titleFont           : boldFont,
                titleTextColor      : .black,
                titleBackground     : .clear,
                searchBarFont       : regularFont,
                searchBarPlaceholder: "Search Categories",
                closeButtonTitle    : "Cancel",
                closeButtonColor    : .darkGray,
                closeButtonFont     : regularFont,
                doneButtonTitle     : "Done",
                doneButtonColor     : blueColor,
                doneButtonFont      : boldFont,
                checkMarkPosition   : .Right,
                itemCheckedImage    : UIImage(named:"blue_ic_checked"),
                itemUncheckedImage  : UIImage(),
                itemColor           : .black,
                itemFont            : regularFont
            )
            
            let fruits = self.CategoryArray.compactMap({$0.name})
            
            let picker = YBTextPicker.init(with: fruits, appearance: blueAppearance,
                                           onCompletion: { (selectedIndexes, selectedValues) in
                                            
                                            
                                            if selectedValues.count > 0{
                                                
                                                var values = [String]()
                                                self.SelectedCategoryArray.removeAll()
                                                for index in selectedIndexes{
                                                    values.append(fruits[index])
                                                    self.SelectedCategoryArray.append(self.CategoryArray[index])
                                                    
                                                }
                                                
                                                let id = self.SelectedCategoryArray.compactMap({$0.id})
                                                
                                                let formatter = NumberFormatter()
                                                formatter.numberStyle = .none
                                                formatter.maximumFractionDigits = 2
                                                formatter.minimumFractionDigits = 0
                                                
                                                self.SelectedCategoryID = id.compactMap { formatter.string(for: $0) }
                                                    .joined(separator: ",")
                                                
                                                print(self.SelectedCategoryID!)
                                                //self.btnFruitsPicker.setTitle(values.joined(separator: ", "), for: .normal)
                                                self.txttypefood.text = values.joined(separator: ", ")
                                                self.values["foodType"] = self.SelectedCategoryID
                                                
                                            }else{
                                                //self.btnFruitsPicker.setTitle("Select Fruits", for: .normal)
                                                //self.sportCategories.text = "select Sport Categories"
                                            }
            },
                                           onCancel: {
                                            print("Cancelled")
            }
            )
            
            if let title = self.txttypefood.text{
                if title.contains(","){
                    picker.preSelectedValues = title.components(separatedBy: ", ")
                }
            }
            
            picker.allowMultipleSelection = true
            picker.show(withAnimation: .Fade)
        }
        
        
      
    }
    
    func allCategoris() {
        _ = WebRequests.setup(controller: self).prepare(query: "allFoodType", method: HTTPMethod.get).start(){ (response, error) in
            do {
                
                let object =  try JSONDecoder().decode(StructTypeFood.self, from: response.data!)
                self.CategoryArray = object.items!
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

    @IBAction func btnNext1(_ sender: Any) {
        
        
                if imgProfile.image == UIImage(named: "KaramLogo") {
                    self.showAlert(title: "Error".localized, message: "Please enter  Image is Required".localized)
                    return
                }

        guard let name = self.txtName.text, !name.isEmpty else {
            self.showAlert(title: "Error".localized, message: "Please enter your name".localized)
            return }
        
        guard let email = self.txtEmail.text, !email.isEmpty else {
            self.showAlert(title: "Error".localized, message: "Please enter your email".localized)
            return }
        
        guard let mobile = self.txtMobile.text, !mobile.isEmpty else {
            self.showAlert(title: "Error".localized, message: "Please enter your mobile".localized)
            return }
        
        guard let Description = self.txtDescription.text, !Description.isEmpty else {
            self.showAlert(title: "Error".localized, message: "Please enter your Description".localized)
            return }
        
        guard let Subscrption = self.txtSubscrption.text, !Subscrption.isEmpty else {
            self.showAlert(title: "Error".localized, message: "Please enter your Subscrption".localized)
            return }

        
        imgTabber.image = UIImage(named: "Group 74072")
        
        viewImgPro.isHidden = true
        viewName.isHidden = true
        viewEmail.isHidden = true
        viewPhone.isHidden = true
        viewDescr.isHidden = true
        viewPack.isHidden = true
        viewNext1.isHidden = true
        
        viewType.isHidden = false
        viewTitleWorking.isHidden = false
        
        viewFrom.isHidden = false
        viewFulltime.isHidden = false
        viewSelectCoun.isHidden = false
        viewCity.isHidden = false
        viewLocation.isHidden = false
        viewFoodType.isHidden = false
        viewNext2.isHidden = false
        viewDelivary.isHidden = true
        viewCost.isHidden = true
        viewImgarray.isHidden = true
        viewVideo.isHidden = true
        viewSinup.isHidden = true
        viewPayment.isHidden = true


        
    }
    @IBAction func btnNext2(_ sender: Any) {
        if !is24 {
        guard let Timefrom = self.txtTimefrom.text, !Timefrom.isEmpty else {
            self.showAlert(title: "Error".localized, message: "Please enter your Time from".localized)
            return }
        
        guard let Timeto = self.txtTimeto.text, !Timeto.isEmpty else {
            self.showAlert(title: "Error".localized, message: "Please enter your Time to".localized)
            return }
        }
        guard let country = self.country_Lbl.text, !country.isEmpty else {
            self.showAlert(title: "Error".localized, message: "Please enter your country".localized)
            return }
        
        guard let city = self.cityPicker.text, !city.isEmpty else {
            self.showAlert(title: "Error".localized, message: "Please enter your city".localized)
            return }
        guard let typefood = self.txttypefood.text, !typefood.isEmpty else {
            self.showAlert(title: "Error".localized, message: "Please enter your type food".localized)
            return }
        
        if lbllocation?.text == "" {
            self.showAlert(title: "Error".localized, message: "Please enter your country at the map".localized)
            return
        }


        imgTabber.image = UIImage(named: "Group 74073")
        
        viewTitleWorking.isHidden = true
        
        viewImgPro.isHidden = true
        viewName.isHidden = true
        viewEmail.isHidden = true
        viewPhone.isHidden = true
        viewDescr.isHidden = true
        viewPack.isHidden = true
        viewNext1.isHidden = true
        viewType.isHidden = true
        viewFrom.isHidden = true
        viewFulltime.isHidden = true
        viewSelectCoun.isHidden = true
        viewCity.isHidden = true
        viewLocation.isHidden = true
        viewFoodType.isHidden = true
        viewNext2.isHidden = true
        
        viewType.isHidden = true
        viewFrom.isHidden = true
        viewFulltime.isHidden = true
        viewSelectCoun.isHidden = true
        viewCity.isHidden = true
        viewLocation.isHidden = true
        viewFoodType.isHidden = true
        viewNext2.isHidden = true
        viewDelivary.isHidden = false
        viewCost.isHidden = false
        viewImgarray.isHidden = false
        viewVideo.isHidden = false
        viewSinup.isHidden = false
        viewPayment.isHidden = false
        
        

    }
    
    
    
    
    
    
//    @IBAction func BtnTypeFood(_ sender: Any) {
//        ActionSheetStringPicker.show(withTitle: "Type food", rows: self.foodArray.map { $0.name as Any}, initialSelection: 0, doneBlock: {
//            picker, value, index in
//            if let Value = index {
//
//                self.txttypefood.text = Value as? String
//            }
//            self.typeFood_id = self.foodArray[value].id!
//            return
//        }, cancel: { ActionStringCancelBlock in return }, origin: sender)
//
//    }

    
    // Selecte Location
    @IBAction func selectLocationButton(_ sender: Any) {
//        let config = GMSPlacePickerConfig(viewport: nil)
//        let placePicker = GMSPlacePickerViewController(config: config)
//        placePicker.delegate = self
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GoogleMapViewController") as! GoogleMapViewController
//        vc.city = cityPicker.text
//        vc.delegate = self
//
//        vc.country = country_Lbl.text
//
//        present(vc, animated: true, completion: nil)
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
//        print("old \(values)")
//        dismiss(animated: true) {
//            let _place = place.formattedAddress ?? "\(place.coordinate.latitude);\(place.coordinate.longitude)"
//
//            if place.formattedAddress != nil {
//                print("formattedAddress: \(place.formattedAddress ?? "0")")
//                //                let address = place.formattedAddress ?? "0"
//
//                print(_place)
//                self.lbllocation.text = _place // + ", " + address
//                self.values["address"] = _place // + ", " + address
//                self.values["lat"] = "\(place.coordinate.latitude.description)"
//                self.values["lan"] = "\(place.coordinate.longitude.description)"
//            }
//            print("new \(self.values)")
//        }
//    }

//    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
//        // Dismiss the place picker, as it cannot dismiss itself.
//        viewController.dismiss(animated: true, completion: nil)
//
//        print("No place selected")
//    }
    
    
    @IBAction func BtnSubscrption(_ sender: Any) {
        ActionSheetStringPicker.show(withTitle: "Subscription Package", rows: self.objData.map { $0.name as Any}, initialSelection: 0, doneBlock: {
            picker, value, index in
            if let Value = index {
                
                self.txtSubscrption.text = Value as? String
            }
            self.sub_id = self.objData[value].id!
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender)
        
    }
    
    
    
    func GetSubscriptionPakege(){
        
        _ = WebRequests.setup(controller: self).prepare(query: "subscribe", method: HTTPMethod.get).start(){ (response, error) in
            do {
                let Status =  try JSONDecoder().decode(StructSubscription.self, from: response.data!)
                self.objData = Status.items!
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
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
    @IBAction func skipButton(_ sender: Any) {
        let vc:MainVC = AppDelegate.sb_main.instanceVC()
        let NavigationController :CustomNavigationBar = AppDelegate.sb_main.instanceVC()
        NavigationController.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen

        self.present(vc, animated: true, completion: nil)
        
    }
    
//    func textFieldDidBeginEditing(_ textField: SkyFloatingLabelTextField) {
//        txtMobile = textField as! SkyFloatingLabelTextFieldWithIcon

//    }
    
    @IBAction func signUpButton(_ sender: Any) {
        guard Helper.isConnectedToNetwork() else {
            self.showAlert(title: "Error".localized, message: "Network Connection Error".localized)
            return }
//        guard let name = self.txtName.text, !name.isEmpty else {
//            self.showAlert(title: "Error".localized, message: "Please enter your name".localized)
//            return }
//
//        guard let email = self.txtEmail.text, !email.isEmpty else {
//            self.showAlert(title: "Error".localized, message: "Please enter your email".localized)
//            return }
//
//        guard let mobile = self.txtMobile.text, !mobile.isEmpty else {
//            self.showAlert(title: "Error".localized, message: "Please enter your mobile".localized)
//            return }
//
//        guard let Description = self.txtDescription.text, !Description.isEmpty else {
//            self.showAlert(title: "Error".localized, message: "Please enter your Description".localized)
//            return }
//
//        guard let Subscrption = self.txtSubscrption.text, !Subscrption.isEmpty else {
//            self.showAlert(title: "Error".localized, message: "Please enter your Subscrption".localized)
//            return }
        
//        guard let Timefrom = self.txtTimefrom.text, !Timefrom.isEmpty else {
//            self.showAlert(title: "Error".localized, message: "Please enter your Time from".localized)
//            return }
//
//        guard let Timeto = self.txtTimeto.text, !Timeto.isEmpty else {
//            self.showAlert(title: "Error".localized, message: "Please enter your Time to".localized)
//            return }
//
//        guard let country = self.country_Lbl.text, !country.isEmpty else {
//            self.showAlert(title: "Error".localized, message: "Please enter your country".localized)
//            return }
//
//        guard let city = self.cityPicker.text, !city.isEmpty else {
//            self.showAlert(title: "Error".localized, message: "Please enter your city".localized)
//            return }
//        guard let typefood = self.txttypefood.text, !typefood.isEmpty else {
//            self.showAlert(title: "Error".localized, message: "Please enter your type food".localized)
//            return }
        
        guard let deliveryCost = self.txtdelaviryCost.text, !deliveryCost.isEmpty else {
            self.showAlert(title: "Error".localized, message: "Please enter your delivery Cost".localized)
            return }
        
       
        
        guard checkBoxButton.isChecked == true else{
            showAlert(title: "Error".localized, message: "must be agree".localized)
            return
        }
        //        if selected_image?.images == nil {
        //            self.showAlert(title: "Error".localized, message: "Please enter  Image is Required".localized)
        //            return
        //        }
        
        
        values["name_en"] = txtName.text
        values["email"] = txtEmail.text
        values["mobile"] = "05"+txtMobile.text!
        values["description_en"] = txtDescription.text
        values["package_id"] = sub_id.description
        values["typeServiceProvider"] = typeServiceProvider
        values["payment_method"] = paymentType
        values["timeFrom"] = txtTimefrom.text
        values["timeTo"] = txtTimeto.text
        values["country_id"] = slectedCounrtyID?.description
        values["city_id"] = slectedCityID?.description
      
        values["delivery"] = deliveryType
        values["deliveryCost"] = deliveryCost
        values["type"] = type
        values["description_ar"] = txtArabicDiscrbtion.text
        values["name_ar"] = txtArabicName.text

        
            self.showIndicator()
            WebRequests.sendPostMultipartWithImages(url: TAConstant.APIBaseURL + "joinUs", parameters: values as! [String : String], imgs: selectedImages, withName: "images", img: imgProfile.image!, logoName: "profile_image", video: videoData) { (response, error) in
                // Helper.hideIndicator(view: self.view)
                
                self.hideIndicator()
                do {
                    
                    let Status =  try JSONDecoder().decode(StatusStruct.self, from: (response).data!)
                    if Status.status!  {
                        
                        let vc:ShowVC = AppDelegate.sb_main.instanceVC()
                        let NavigationController :CustomNavigationBar = AppDelegate.sb_main.instanceVC()
                        NavigationController.pushViewController(vc, animated: true)
                        vc.modalPresentationStyle = .fullScreen

                        self.present(vc, animated: true, completion: nil)

                        
                    }else{
                        self.showAlert(title: "Error".localized, message: Status.message!)
                        
                    }
                } catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
                
                
            }
            
       
    }
    
    
    @IBAction func backToSiginInButton(_ sender: Any) {
        let vc:SignInVC = AppDelegate.sb_main.instanceVC()
        vc.modalPresentationStyle = .fullScreen

         self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func policyButton(_ sender: Any) {
        let vc:InfoVC = AppDelegate.sb_main.instanceVC()
        vc.Info = CurrentSettings.settingsInfo?.privacy
        vc.IsImage = false
        vc.IsNav = false
        let Nav :CustomNavigationBar = AppDelegate.sb_main.instanceVC()
        Nav.pushViewController(vc, animated: true)
        
        self.present(Nav, animated: true, completion: nil)
    }
    @IBAction func termsButton(_ sender: Any) {
        let vc:InfoVC = AppDelegate.sb_main.instanceVC()
        vc.Info = CurrentSettings.settingsInfo?.terms
        vc.IsImage = false
        vc.IsNav = false
        let Nav :CustomNavigationBar = AppDelegate.sb_main.instanceVC()
        Nav.pushViewController(vc, animated: true)
        
        self.present(Nav, animated: true, completion: nil)
    }
    
}

extension SignUpVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedImages.count <= 0{
            return 3
        }
        return selectedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ImagesCell = collectionView.dequeueCVCell(indexPath: indexPath)
        
        if selectedImages.count <= 0{
            cell.img_view.image = "logo".toImage
        }else{
            let img = selectedImages[indexPath.item]
            cell.img_view.image = img
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 55, height: 55)
    }
    
    func addressIS(address: String , city : String) {
        if city != cityPicker.text{
            print("noooooooo")
            lbllocation.text =  "Medina" ?? ""

        }else{
        lbllocation.text = address
    }
    }
    
}

protocol Address {
    func addressIS(address : String , city : String)
}


//if imgProfile.image == UIImage(named: "KaramLogo") {
//    self.showAlert(title: "Error".localized, message: "Please enter  Image is Required".localized)
//    return
//}











extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        }
            
        }
    
    @objc func showImagePicker(_ sender: UIButton){
//        let picker = UIImagePickerController()
//        picker.delegate = self
//        picker.mediaTypes = [kUTTypeMovie as NSString as String]
//        self.present(picker, animated: true, completion: nil)
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc private func openPhotoLibraryButtonPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            let pickerController = UIImagePickerController()
            
            pickerController.delegate = self
            pickerController.allowsEditing = true
//            pickerController.cameraCaptureMode = .photo
            
            
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
