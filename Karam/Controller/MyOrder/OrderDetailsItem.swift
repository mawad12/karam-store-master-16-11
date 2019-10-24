
//
//  OpenOrderItem.swift
//  Karam
//
//  Created by ahmed on 6/25/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import AAPickerView



class OrderDetailsVC: SuperViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var lblOrderID: UILabel!
    
    @IBOutlet weak var lblOrderDate: UILabel!
    
    @IBOutlet weak var lblStoreName: UILabel!
    
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
    
    
    @IBOutlet weak var StatePicker: AAPickerView!
    
    
    var OrderObj:OrderItems?
    var additonItem:AdditionAddition?
    var additionsArray = [AdditionElement]()

    

    var ProductArray = [ProductElement]()

    
    var OrderID:Int?
    
    
    override func viewDidLoad() {
        
        let navigation = navigationController as! CustomNavigationBar
        navigation.setTitle("Order Products".localized, sender: self, Srtingcolor :"AECB1B")
        navigation.setCustomBackButtonForViewController(sender: self)
    
        sideMenuController!.isLeftViewSwipeGestureEnabled = false
        sideMenuController!.isRightViewSwipeGestureEnabled = false
    
        self.tableView.registerCell(id: "OpenDetailsProductCell")
        
        LoadData()
        LoadAdditionsData()
    }

    func LoadData() {

        _ = WebRequests.setup(controller: self).prepare(query: "orderDetail/\(OrderID ?? 0)", method: HTTPMethod.get).start(){ (response, error) in
            do {

                let object =  try JSONDecoder().decode(OrderDetailStruct.self, from: response.data!)
                
                
                
                
                self.OrderObj = object.OrderItems
                self.ProductArray = (self.OrderObj?.products)!
                self.tableView.reloadData()


            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }

    }
    
    func LoadAdditionsData() {
        
        _ = WebRequests.setup(controller: self).prepare(query: "orderDetail/\(OrderID ?? 0)", method: HTTPMethod.get).start(){ (response, error) in
            do {
                
                let object =  try JSONDecoder().decode(AdditionElement.self, from: response.data!)
                
                print("ooooooooo \(object)")

                self.additionsArray = [object]
                
                print("ccccccc \(self.additionsArray.count)")

                self.additonItem = object.addition
                
               print("rrrrrrrrrrrrr \(self.additonItem?.productName)")
                
                
//                self.additionsArray = (self.additonItem?.products)!
//                self.tableView.reloadData()
                
               
                
                
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
        
    }
    
    
    @IBAction func ChangeStatusButton(_ sender: Any) {
        
        
    }
    
    
//    override func prepareCellForData(in tableView: UITableView, Data: Any ,indexPath : IndexPath) -> UITableViewCell {
//
//        if indexPath.row == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailsHeaderCell", for: indexPath) as! OrderDetailsHeaderCell
//            cell.lbl_total.text = "\(listArray?.id ?? 0)"
//            cell.lbl_StoreName.text = listArray?.storeName
//            cell.lbl_Date.text = listArray?.createdAt
//            cell.lbl_total.text = listArray?.totalPrice ?? "0" + "SAR".localized
//
//            //        cell.LocationButton
//            return cell
//
//        }
//        let obj = listArray?.products![indexPath.row - 1]
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "OpenDetailsProductCell", for: indexPath) as! OpenDetailsProductCell
//        cell.lblName.text = obj?.product?.name
//        cell.lblQunt.text = "QTY".localized + ":\(obj?.quantity ?? "0")"
//        cell.lblPrice.text = "\(obj?.product?.price ?? "0")" + "SAR".localized
//        cell.lblDescription.text = obj?.product?.description
////        cell.lblSpectialRequest.text = obj?.product?
////        cell.lblAdditions.text =
//            cell.img.sd_custom(url: (obj?.product?.coverImage)!)
//
////        cell.LocationButton
//        return cell
//    }
//    override func getCount() -> Int
//    {
//        if listArray == nil{
//        return 0
//        }
//        return (listArray?.products!.count)! + 1
//    }
//   override func prepareCellheight(indexPath : IndexPath) -> CGFloat
//    {
//        if indexPath.row == 0 {
//            return 500
//        }
//        return UITableView.automaticDimension
//
//    }
    
    
}



// MARK: - UI TableView
extension OrderDetailsVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OpenDetailsProductCell", for: indexPath) as! OpenDetailsProductCell
        
        let obj = ProductArray[indexPath.row]
        cell.lblName.text = obj.product?.name
        cell.lblQunt.text = "QTY".localized + " \(obj.quantity ?? "")"
        cell.lblPrice.text = "\(obj.price ?? "") " + "SAR".localized
        cell.lblDescription.text = obj.product?.description
        //cell.lblSpectialRequest.text = obj.product
        //cell.lblAdditions.text = obj.
        cell.img.sd_custom(url: obj.product?.coverImage ?? "" )
        
        return cell
    }
    
   
}

