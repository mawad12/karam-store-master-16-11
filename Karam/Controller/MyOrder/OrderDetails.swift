
//
//  OpenOrderItem.swift
//  Karam
//
//  Created by ahmed on 6/25/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import AAPickerView

import CoreLocation
import Firebase
import AVFoundation
import AVKit


class OrderDetails: SuperViewController ,CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var tableView2HeightC: NSLayoutConstraint!
    
    @IBOutlet weak var changeOrderView: UIView!
    @IBOutlet weak var changeOrderHeightC: NSLayoutConstraint!
    
    @IBOutlet weak var lblOrderID: UILabel!
    
    @IBOutlet weak var lblOrderDate: UILabel!
    
    
    @IBOutlet weak var lblAddetions: UILabel!

    
    
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var lblPaymentMethod: UILabel!
    
    @IBOutlet weak var lblDeliveryMethod: UILabel!
    
    @IBOutlet weak var lblTotal: UILabel!
    
    @IBOutlet weak var lblCustomerName: UILabel!
    
    @IBOutlet weak var lblCustomerMobile: UILabel!

    @IBOutlet weak var lblDeliveryCompany: UILabel!

    @IBOutlet weak var lblDeliveryCost: UILabel!
    
    @IBOutlet weak var lblDeliveryAddress: UILabel!
    
    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var lblBlock: UILabel!
    
    @IBOutlet weak var lblStreet: UILabel!
    
    @IBOutlet weak var lblBulidingNumber: UILabel!
    
    @IBOutlet weak var lblApartmentNumber: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    
    @IBOutlet weak var StatusPicker: AAPickerView!
    
    var StatusArray = ["New".localized, "Preparing".localized, "Ready".localized, "onDelivery".localized]

    var StatusArrayDriver = ["onDelivery".localized, "Complete".localized]

    var slectedStatus = ""
    
    var OrderObj:OrderItems?
    var OrderObj2:AdditionElement?
    var OrderObj3:AdditionElement?

    var orderStatus = ""

    var ProductArray = [ProductElement]()
    var additonItem:AdditionElement?
    var additionsArray = [AdditionElement]()
    var OrderID:Int?
    var lat: Double = 0
    var lng: Double = 0
    
    lazy var locationManager: CLLocationManager = {
        var _locationManager = CLLocationManager()
        _locationManager.delegate = self
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        _locationManager.activityType = .automotiveNavigation
        return _locationManager
    }()
    var seconds = 5
    var timer = Timer()
    var values: [String: Any] = [:]

    
    override func viewDidLoad() {
        
        let navigation = navigationController as! CustomNavigationBar
        navigation.setTitle("Order Products".localized, sender: self, Srtingcolor :"AECB1B")
        navigation.setCustomBackButtonForViewController(sender: self)
    
        sideMenuController!.isLeftViewSwipeGestureEnabled = false
        sideMenuController!.isRightViewSwipeGestureEnabled = false
        
        self.tableView.registerCell(id: "OpenDetailsProductCell")
        tableView2.dataSource = self
        
        LoadData()
        LoadAdditionsData()
        config_StatusPicker()

        if orderStatus == "Completed".localized {
            //changeOrderView.isHidden = true
            changeOrderHeightC.constant = 0
        } else {
         //   changeOrderView.isHidden = false
            changeOrderHeightC.constant = 163.5
        }
        
    }
    
  
    
    func LoadAdditionsData() {
        print("rrrrrrrr1")
        _ = WebRequests.setup(controller: self).prepare(query: "orderDetail/\(OrderID ?? 0)", method: HTTPMethod.get).start(){ (response, error) in
            print("rrrrrrrr2")
            
            do {
                print("rrrrrrrr3")
                
                
                
                
                
                let object =  try JSONDecoder().decode(OrderDetailStruct.self, from: response.data!)
                
                
                
                
                self.OrderObj = object.OrderItems
                self.additionsArray = (self.OrderObj?.additions)!
                print(self.additionsArray)
                print("counttttt \(self.additionsArray.count)")
                self.tableView2.reloadData()
                
                if self.additionsArray.count == 0 {
                    self.tableView2.isHidden = true
                    self.tableView2HeightC.constant = 0

                }else{
                    self.tableView2.isHidden = false
                    self.tableView2HeightC.constant = 150

                }
//
//
//                //
//                let object =  try JSONDecoder().decode(OrderDetailStruct.self, from: response.data!)
//                print("iiiiiii \(object)")
//                self.OrderObj! = object.OrderItems!
//                self.self.additionsArray = self.OrderObj!.additions!
//                print("counttttt \(self.additionsArray.count)")
//
//
                self.tableView.reloadData()
                
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
        
    }
    
    @IBAction func OpenMap(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LocationOnMapVC") as! LocationOnMapVC
        //
        vc.name = self.OrderObj?.customerCity?.city?.name
        vc.lat = self.OrderObj?.customerCity?.lat
        vc.long = self.OrderObj?.customerCity?.lan
//        self.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
  
    
//    @IBAction func btnOpenMap(sender : UIButton){
//        
//
//
////        self.present(vc, animated: true, completion: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
//        
//    
//        
////        self.presentViewController(next, animated: true, completion: nil)
//        
////
////        self.present(vc, animated: true, completion: nil)
//    
//    }
    
    

    func LoadData() {
//changeOrderStatusByDriver
            _ = WebRequests.setup(controller: self).prepare(query: "orderDetail/\(OrderID ?? 0)", method: HTTPMethod.get).start(){ (response, error) in
                self.LoadAdditionsData()
                
                do {
                    
                    let object =  try JSONDecoder().decode(OrderDetailStruct.self, from: response.data!)
                    self.LoadAdditionsData()
                    
                    self.OrderObj = object.OrderItems
                    self.lblOrderID.text = self.OrderObj?.id?.description
                    self.lblOrderDate.text = self.OrderObj?.createdAt
                    self.lblTotal.text = "\(self.OrderObj?.totalPrice ?? "") " + "SAR".localized
                    self.lblCustomerName.text = self.OrderObj?.customerName
                    self.lblCustomerMobile.text = self.OrderObj?.customerMobile
                    
                    
//                    if self.StatusArray[index as! Int] == "New"{
//                        self.slectedStatus = "0"
//                    }else if self.StatusArray[index as! Int] == "Preparing"{
//                        self.slectedStatus = "1"
//                    }else if self.StatusArray[index as! Int] == "Ready"{
//                        self.slectedStatus = "2"
//                    }else if self.StatusArray[index as! Int] == "onDelivery"{
//

                    
                    if self.OrderObj?.status == "0"{
                        self.lblStatus.text = "New".localized
                        
                    } else if self.OrderObj?.status == "1"{
                        self.lblStatus.text = "Preparing".localized
                        
                    }else if self.OrderObj?.status == "2"{
                        self.lblStatus.text = "Ready".localized
                        
                    }else if self.OrderObj?.status == "3"{
                        self.lblStatus.text = "onDelivery".localized
                        
                    }else if self.OrderObj?.status == "4"{
                        self.lblStatus.text = "Completed".localized
                        self.orderStatus = "Completed".localized
                        
                    }
                    else{
                        self.lblStatus.text = ""
                    }
                    
                    
                    self.lblPaymentMethod.text = self.OrderObj?.paymentMethod?.localized
                    self.lblDeliveryMethod.text = self.OrderObj?.deliveryMethod?.localized
                    self.lblDeliveryCompany.text = self.OrderObj?.deliveryCompanyId
                    self.lblDeliveryCost.text = "\(self.OrderObj?.deliveryCost ?? "") " + "SAR".localized
                    self.lblDeliveryAddress.text = self.OrderObj?.deliveryAddress
                    self.lblCity.text = self.OrderObj?.customerCity?.city?.name
                    self.lblBlock.text = self.OrderObj?.customerCity?.block
                    self.lblStreet.text = self.OrderObj?.customerCity?.street
                    self.lblBulidingNumber.text = self.OrderObj?.customerCity?.buildingNumber
                    self.lblApartmentNumber.text = self.OrderObj?.customerCity?.apartmentNumber
                    self.lblLocation.text = self.OrderObj?.customerCity?.address
                    
                    
                    
                    self.ProductArray = (self.OrderObj?.products)!
                    
                    self.tableView.reloadData()
                    
                    
                } catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
            

        }

    }
    
    
    
    
    
    // Status Picker
    func config_StatusPicker() {
        if CurrentUser.userInfo?.typeUser == "4"{
            StatusPicker.pickerType = .string(data: self.StatusArrayDriver)
            StatusPicker.heightForRow = 40
            
            StatusPicker.toolbar.barTintColor = .darkGray
            StatusPicker.toolbar.tintColor = .black
            
            StatusPicker.valueDidSelected = { (index) in
                print("selected String ", self.StatusArrayDriver[index as! Int])
                print("mmm")
                if self.StatusArrayDriver[index as! Int] == "onDelivery" || self.StatusArrayDriver[index as! Int] == "في الطريق"{
                    self.slectedStatus = "3"
                    self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.updateLocation), userInfo: nil, repeats: true)
                    
                    
                }else{
                    self.slectedStatus = "4"
                }}
            }else{
                StatusPicker.pickerType = .string(data: self.StatusArray)
                
                StatusPicker.heightForRow = 40
                
                StatusPicker.toolbar.barTintColor = .darkGray
                StatusPicker.toolbar.tintColor = .black
                
                StatusPicker.valueDidSelected = { (index) in
                    print("selected String ", self.StatusArray[index as! Int])
                    
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
                    
//                    if self.StatusArray[index as! Int] == "New"{
//                        self.slectedStatus = "0"
//                    }else if self.StatusArray[index as! Int] == "Preparing"{
//                        self.slectedStatus = "1"
//                    }else if self.StatusArray[index as! Int] == "Ready"{
//                        self.slectedStatus = "2"
//                    }else if self.StatusArray[index as! Int] == "onDelivery"{
//                        self.slectedStatus = "3"
//                        
//                    }else if self.StatusArray[index as! Int] == "Completed"{
//                        self.slectedStatus = "4"
//                        
//                    }
//                    else{
//                        self.slectedStatus = ""
//                    }
                    
            }
                
            
                StatusPicker.valueDidChange = { value in
                    print("selected Value",value)
                    print("selected String ",  self.StatusArray[value as! Int])
                    
                    
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
                
  
                
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coord = manager.location?.coordinate else { return }
        print(coord)
        updateLocatoinOnFirebase(la: coord.latitude, ln: coord.longitude)
        lat = coord.latitude
        lng = coord.longitude
        
        locationManager.stopUpdatingLocation()
    }
    
    @objc func updateLocation(){
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    @objc func updateLocatoinOnFirebase(la: Double, ln: Double){
        let ref = Database.database().reference()
        var values: [String: Any] = [:]
        values["latitude"] = la
        values["longitude"] = ln
//        values["orderId"] = OrderID
        
        ref.child("Employee").child(String(OrderID!)).updateChildValues(values) { (error, reference) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            print("success")
        }
    }
    
    
    

    
    @IBAction func ChangeStatusButton(_ sender: Any) {
        
        guard let orderID = self.OrderID else{
            return
        }
        
        guard self.slectedStatus != "" else{
            self.showAlert(title: "Erorr".localized, message: "Order Status Can't be Empty".localized)
            return
        }
        
        
        var parameters: [String: Any] = [:]
        
        parameters["order_id"] = orderID
        parameters["status"] = self.slectedStatus
        
        if CurrentUser.userInfo?.typeUser == "4"{
            _ = WebRequests.setup(controller: self).prepare(query: "changeOrderStatusByDriver", method: HTTPMethod.post, parameters: parameters).start(){ (response, error) in
                print(self.slectedStatus)
                do {
                    let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                    if !Status.status! {
                        print("id: \(orderID)")
                        self.showAlert(title: "Error".localized, message:Status.message!)
                        return
                    }else{
                        let vc:MainVC = AppDelegate.sb_main.instanceVC()
                        let appDelegate =  UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = vc
                        
//                        self.navigationController?.popViewController(animated: true)
                        self.showAlert(title: "Success".localized, message:Status.message!)
                    }
                    
                }catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
            }
            
            }else{
                _ = WebRequests.setup(controller: self).prepare(query: "changeOrderStatus", method: HTTPMethod.post, parameters: parameters).start(){ (response, error) in
                    
                    do {
                        let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                        if !Status.status! {
                            
                            self.showAlert(title: "Error".localized, message:Status.message!)
                            return
                        }else{
//                            self.navigationController?.popViewController(animated: true)
                            let vc:MainVC = AppDelegate.sb_main.instanceVC()
                            let appDelegate =  UIApplication.shared.delegate as! AppDelegate
                            appDelegate.window?.rootViewController = vc
                            self.showAlert(title: "Success".localized, message:Status.message!)
                        }
                        
                    }catch let jsonErr {
                        print("Error serializing  respone json", jsonErr)
                    }
                }
                

            }
    
        
    }
    
    

}



// MARK: - UI TableView
extension OrderDetails: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if tableView == self.tableView {
//                        return ProductArray.count
//                    } else if tableView == tableView2 {
//                        return additionsArray.count
//                    }
        return tableView == self.tableView ? ProductArray.count: additionsArray.count

        
//        return ProductArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "OpenDetailsProductCell", for: indexPath) as! OpenDetailsProductCell
//
//        let obj = ProductArray[indexPath.row]
//        cell.lblName.text = obj.product?.name
//        cell.lblQunt.text = "QTY:".localized + " \(obj.quantity ?? "")"
//        cell.lblPrice.text = "\(obj.price ?? "") " + "SAR".localized
//        cell.lblDescription.text = obj.product?.description
//        cell.lblSpectialRequest.text = obj.product?.addition?.compactMap{$0.name}.joined(separator:", ")
//
//        cell.lblAdditions.text = obj.product?.addition?.compactMap{$0.name}.joined(separator:", ")
//        cell.img.sd_custom(url: obj.product?.coverImage ?? "" )
//
//        return cell
        
        
        if tableView == self.tableView,
            let cell = tableView.dequeueReusableCell(withIdentifier: "OpenDetailsProductCell") as? OpenDetailsProductCell {
            let obj = ProductArray[indexPath.row]
            cell.lblName.text = obj.product?.name
            cell.lblQunt.text = "QTY:".localized + " \(obj.quantity ?? "")"
            cell.lblPrice.text = "\(obj.price ?? "") " + "SAR".localized
            cell.lblDescription.text = obj.product?.description
//            cell.lblSpectialRequest.text = obj.product?.addition?.compactMap{$0.name}.joined(separator:", ")
            
            cell.lblAdditions.text = obj.product?.addition?.compactMap{$0.name}.joined(separator:", ")
            cell.img.sd_custom(url: obj.product?.coverImage ?? "" )
            
            return cell
            
        } else if tableView == self.tableView2,
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdditionsCell") as? AdditionsCell {
            let obj = additionsArray[indexPath.row]
            cell.lblName.text = obj.addition.name
            cell.lblPrice.text = obj.addition.price + " SAR".localized
            cell.lblCount.text = obj.quantity
            cell.lblSpectialRequest.text = obj.spatialRequest

            cell.selectionStyle = .none

//            cell.fullNameLbL.text = index.name
//            cell.imgProfile.image = index.profileImage
//            cell.delegate = self
            
            return cell
        }
        
        return UITableViewCell()
        
        
    }
}
