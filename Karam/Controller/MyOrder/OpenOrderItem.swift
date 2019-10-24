
//
//  OpenOrderItem.swift
//  Karam
//
//  Created by ahmed on 6/25/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class OpenOrderItem: SuperItem {
    var listArray = [OrderItems]()
    
    
    override func LoadItem() {
        if CurrentUser.userInfo?.typeUser == "4"{
            self.withIdentifierCell = ["OrderCell"]
            _ = WebRequests.setup(controller: self.viewController).prepare(query: self.RequestUrl, method: HTTPMethod.get,parameters: self.parameters,isAuthRequired:true).start(){ (response, error) in
                do {
                    
                    let object =  try JSONDecoder().decode(MyOrderStruct.self, from: response.data!)
                    self.listArray = object.OrderItems!
                    
                    self.prepareTable()
                    
                    
                } catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
            }

        }
        //
        self.withIdentifierCell = ["OrderCell"]
        _ = WebRequests.setup(controller: self.viewController).prepare(query: self.RequestUrl, method: HTTPMethod.post,parameters: self.parameters,isAuthRequired:true).start(){ (response, error) in
            do {
                
                let object =  try JSONDecoder().decode(MyOrderStruct.self, from: response.data!)
                self.listArray = object.OrderItems!
                
                self.prepareTable()
                
                
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
     //
    }
    
    override func prepareCellheight(indexPath: IndexPath) -> CGFloat {
        return 195
    }
    
    
    override func prepareCellForData(in tableView: UITableView, Data: Any ,indexPath : IndexPath) -> UITableViewCell {
        let obj = listArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        
        cell.BackgroundContentView.clipsToBounds = true
        
        cell.lblOrderId.text = "\(obj.id ?? 0)"
        cell.lblDate.text = obj.createdAt
        cell.lblTotal.text = "\(obj.totalPrice!) " + "SAR".localized
        
        cell.lblCustomerName.text = obj.customerName
        
        cell.lblCustomerMobile.text = obj.customerMobile

        cell.lblCity.text = obj.customerCity?.city?.name
    
        
        if obj.status == "0"{
            cell.lblStuts.text =  "new".localized
            cell.lblStuts.textColor = .orange
        }
        if obj.status == "1"{
            cell.lblStuts.text =  "Preparing".localized
            cell.lblStuts.textColor = .green
        }
        if obj.status == "2"{
            cell.lblStuts.text =  "Ready".localized
            cell.lblStuts.textColor = .red
        }
        if obj.status == "3"{
        cell.lblStuts.text =  "onDelivery".localized
        cell.lblStuts.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                            }
        if obj.status == "4"{
        cell.lblStuts.text =  "Completed".localized
        cell.lblStuts.textColor = .green
    }
        
        return cell
        
    }
    
    
    
    override func getCount() -> Int{
        return listArray.count
    }
    
    
    
    override func cellDidSelected(indexPath: IndexPath) {
        //let vc:ListViewController = AppDelegate.sb_main.instanceVC()
        
        //let item = OrderDetails()
        //item.RequestUrl =  "orderDetail/\(listArray[indexPath.row].id ?? 0)"
        //item.parameters = self.parameters
        //vc.SuperPageItem = item
        //self.viewController.navigationController?.pushViewController(vc, animated: true)
        
        let vc:OrderDetails = AppDelegate.sb_main.instanceVC()
        vc.OrderID = listArray[indexPath.row].id
        self.viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
