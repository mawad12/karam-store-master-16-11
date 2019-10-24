//
//  ContactUsVC.swift
//  Karam
//
//  Created by musbah on 7/1/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import GoogleMaps
import SkyFloatingLabelTextField
import AAPickerView
import MessageUI


class ContactUsVC: UIViewController, GMSMapViewDelegate, MFMailComposeViewControllerDelegate {

    
    
    @IBOutlet weak var lbl_Phone: UILabel!
    
    @IBOutlet weak var lbl_Mobile: UILabel!
    
    @IBOutlet weak var lbl_Email: UILabel!
    
    
    
    @IBOutlet weak var Name_TF: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var Email_TF: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var Mobile_TF: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var Description_TF: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet weak var SuggestionPicker: AAPickerView!
    
    var seletedSuggestion:String?

    @IBOutlet weak var mapView: GMSMapView!
    
    
    let lat = Double((CurrentSettings.settingsInfo?.latitude)!)
    let lng = Double((CurrentSettings.settingsInfo?.longitude)!)
    
    
    var SuggestionsArray = ["Complaint".localized,"Suggestion".localized,"Inquiry".localized]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigation = self.navigationController as! CustomNavigationBar
        
        navigation.setTitle("Contact us".localized, sender: self,Srtingcolor :"AECB1B")
        navigation.setMeunButton(sender: self)
        navigation.setShadowNavBar()
        
        
        sideMenuController!.isLeftViewSwipeGestureEnabled = true
        sideMenuController!.isRightViewSwipeGestureEnabled = true
        
        lbl_Phone.text = CurrentSettings.settingsInfo?.phone
        lbl_Email.text = CurrentSettings.settingsInfo?.infoEmail
        lbl_Mobile.text = CurrentSettings.settingsInfo?.mobile
        
        
        mapView.camera = GMSCameraPosition(latitude: lat!, longitude: lng!, zoom: 11)
        mapView.delegate = self
        
        let position = CLLocationCoordinate2D(latitude: lat!, longitude:  lng!)
        let marker = GMSMarker(position:position )
        marker.title = "marker"
        marker.map = mapView
        
        
        config_SuggestionsPicker()
    }
    
    
    
    
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    // Config Suggestion Picker
    func config_SuggestionsPicker() {
        
        SuggestionPicker.pickerType = .string(data: self.SuggestionsArray)
        
        SuggestionPicker.heightForRow = 40
        
        SuggestionPicker.toolbar.barTintColor = .darkGray
        SuggestionPicker.toolbar.tintColor = .black
        
        SuggestionPicker.valueDidSelected = { (index) in
            print("selected String ", self.SuggestionsArray[index as! Int])
            self.seletedSuggestion = self.SuggestionsArray[index as! Int]
            
        }
        
        SuggestionPicker.valueDidChange = { value in
            print("selected Value",value)
            print("selected String ",  self.SuggestionsArray[value as! Int])
            self.seletedSuggestion = self.SuggestionsArray[value as! Int]
            
        }
        
    }
    
    
    
    
    
    @IBAction func mailButton(_ sender: Any) {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients([(CurrentSettings.settingsInfo!.adminEmail!)])
        composeVC.setSubject("Message Subject")
        composeVC.setMessageBody("Message content.", isHTML: false)
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    
    @IBAction func mobileButton(_ sender: Any) {
        if (UIApplication.shared.canOpenURL(NSURL(string: "tel://")! as URL)) {
            if let url = URL(string: "tel://\(CurrentSettings.settingsInfo!.mobile!)"), !url.absoluteString.isEmpty {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            self.showAlert(title: "Erorr".localized, message: "Can't use tel ".localized)
            NSLog("Can't use tel://");
        }
        
    }
    
    @IBAction func phoneButton(_ sender: Any) {
        if (UIApplication.shared.canOpenURL(NSURL(string: "tel://")! as URL)) {
            if let url = URL(string: "tel://\(CurrentSettings.settingsInfo!.phone!)"), !url.absoluteString.isEmpty {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            self.showAlert(title: "Erorr".localized, message: "Can't use tel ".localized)
            NSLog("Can't use tel://");
        }
    }
    
    
    @IBAction func facebookButton(_ sender: Any) {
        if let facebookURL = CurrentSettings.settingsInfo?.facebook{
            guard let url = URL(string: facebookURL) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func instagramButton(_ sender: Any) {
        if let instagramURL = CurrentSettings.settingsInfo?.instagram{
            guard let url = URL(string: instagramURL) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func twitterButton(_ sender: Any) {
        if let twitterURL = CurrentSettings.settingsInfo?.twitter{
            guard let url = URL(string: twitterURL) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    
    
    @IBAction func sendButton(_ sender: Any) {
        
        
        guard let name = self.Name_TF.text, !name.isEmpty else{
            self.showAlert(title: "Error".localized, message: "Name Can't be Empty".localized)
            return
        }
        
        guard let mobile = self.Mobile_TF.text, !mobile.isEmpty else{
            self.showAlert(title: "Error".localized, message: "Mobile Can't be Empty".localized)
            return
        }
        
        if mobile.count < 8 || mobile.count > 12 {
            showAlert(title: "Error", message: "The mobile must be between 8 and 12 digits".localized)
            return
        }
        
        guard let email = self.Email_TF.text, !email.isEmpty else{
            self.showAlert(title: "Error".localized, message: "Email Can't be Empty".localized)
            return
        }
        
        if !email.isValidEamil{
            self.showAlert(title: "Error".localized, message: "Email Not Valid".localized)
            return
        }
        
        guard let message = self.Description_TF.text, !message.isEmpty else{
            self.showAlert(title: "Error".localized, message: "Description Can't be Empty".localized)
            return
        }
        
        guard let Suggestion = self.seletedSuggestion, self.seletedSuggestion != "" else{
            self.showAlert(title: "Error".localized, message: "Suggestion Can't be Empty".localized)
            return
        }
        
        
        var parameters: [String: Any] = [:]
        
        parameters["name"] = name
        parameters["mobile"] = mobile
        parameters["email"] = email
        parameters["message"] = message
        parameters["suggestion"] = Suggestion
        
        // MARK: - ContactUs API POST Request
        _ = WebRequests.setup(controller: self).prepare(query: "contact", method: HTTPMethod.post, parameters: parameters).start(){ (response, error) in
            
            
            do {
                let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                if !Status.status! {
                    self.showAlert(title: "Error".localized, message:Status.message!)
                    return
                }
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
            do {
                let Status = try JSONDecoder().decode(UserObject.self, from: response.data!)
                
                //print("SessionManager.shared.session", CurrentUser.userInfo as Any)
                if Status.status! {
                    self.showAlert(title: "Success".localized, message:Status.message!)
                }else{
                    self.showAlert(title: "Error".localized, message:Status.message!)
                }
                
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
            
        }
        
    }
    
}
