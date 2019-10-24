//
//  OffersVC.swift
//  Karam
//
//  Created by ramez adnan on 02/07/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

    class OffersVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
        
        
        @IBOutlet weak var tableview: UITableView!
        
        var arrayMyOffer : [MyOfferData] = []
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            tableview.registerCell(id: "ProductTVC")
            getMyOffer()


        }
        
        
        func getMyOffer() {
            
            
            _ = WebRequests.setup(controller: self).prepare(query: "myOffers", method: HTTPMethod.get).start(){ (response, error) in
                
                do {
                    let Status =  try JSONDecoder().decode(StructMyOffer.self, from: response.data!)
                    self.arrayMyOffer = Status.items!
                    self.tableview.reloadData()
                }catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }}
            
        }

       
        override func viewWillAppear(_ animated: Bool) {
            let navigation = self.navigationController as! CustomNavigationBar
            
            navigation.setTitle("Offer".localized, sender: self,Srtingcolor :"AECB1B")
            navigation.setMeunButton(sender: self)
            navigation.setShadowNavBar()
            
            
            sideMenuController!.isLeftViewSwipeGestureEnabled = true
            sideMenuController!.isRightViewSwipeGestureEnabled = true
            
            
        }
        
        
        // More Button
        @objc func MoreButton(sender:UIButton) {
            print("more")
            let alertController = UIAlertController(title: "Product".localized, message: "", preferredStyle: .actionSheet)
            
            let AdditionAction = UIAlertAction(title: "Addition".localized, style: .default, handler: { alert -> Void in
                
                //guard self.AddressArray[self.selctedIndex!].isDefault == "0" else{
                //    self.showAlert(title: "Erorr".localized, message: "Can't Delete Default //Address".localized)
                //    return
                //}
                //
                //self.DeleteAddressById()
            })
            
            let editAction = UIAlertAction(title: "Edit".localized, style: .default, handler: { alert -> Void in
                
                //let vc:AddNewAddressVC = AppDelegate.sb_main.instanceVC()
                //vc.isEdit = true
                //vc.UserAddress = self.AddressArray[self.selctedIndex!]
                //self.navigationController?.pushViewController(vc, animated: true)
            })
            
            let deleteAction = UIAlertAction(title: "Delete".localized, style: .destructive, handler: { alert -> Void in
                
                //guard self.AddressArray[self.selctedIndex!].isDefault == "0" else{
                //    self.showAlert(title: "Erorr".localized, message: "Can't Delete Default //Address".localized)
                //    return
                //}
                //
                //self.DeleteAddressById()
            })
            
            
            
            let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: {
                (action : UIAlertAction!) -> Void in })
            
            alertController.addAction(AdditionAction)
            alertController.addAction(editAction)
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            
            alertController.preferredAction = editAction
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrayMyOffer.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTVC", for: indexPath) as! ProductTVC
            let item = arrayMyOffer[indexPath.row]
            
            
            //cell.lblOldPrice.text = item.price
            //cell.lblNewPrice.text = item.priceAfterOffer
            
            if item.priceAfterOffer == nil {
                cell.lblNewPrice.text = "\(item.price!) " + "SAR".localized
                cell.lblOldPrice.isHidden = true
                cell.OldPriceView.isHidden = true
            }else{
                cell.lblOldPrice.text = "\(item.price!) " + "SAR".localized
                cell.lblNewPrice.text = "\(item.priceAfterOffer ?? "") " + "SAR".localized
            }
            
            if let text = item.discount {
                cell.imgCorner.isHidden = false
                cell.lblDiscount.isHidden = false
                cell.lblDiscount.text = "\(text)%"
                cell.lblOldPrice.isHidden = false
                cell.OldPriceView.isHidden = false
            }else{
                cell.imgCorner.isHidden = true
                cell.lblDiscount.isHidden = true
                cell.lblOldPrice.isHidden = true
                cell.OldPriceView.isHidden = true
            }
            
            cell.lblProductName.text = item.name
            cell.imgProduct.sd_custom(url: item.restaurantLogo!)
            
            cell.MoreButton.tag = indexPath.row
            cell.MoreButton.addTarget(self, action: #selector(self.MoreButton), for: UIControl.Event.touchUpInside)
            
            
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 180
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc:ProductDetailsVC = AppDelegate.sb_main.instanceVC()
            navigationController?.pushViewController(vc, animated: true)
            
        }
       
        
}

//
//let alertController = UIAlertController(title: "Product".localized, message: "", preferredStyle: .actionSheet)
//
//let AdditionAction = UIAlertAction(title: "Addition".localized, style: .default, handler: { alert -> Void in
//
//    let index = self.indexpathlist[sender.tag]
//    let  producatobjavalvity = self.arrayMyOffer[index.section].id
//
//    let vc:AdditionalVC = AppDelegate.sb_main.instanceVC()
//
//
//
//    self.navigationController?.pushViewController(vc, animated: true)
//})
//
//let editAction = UIAlertAction(title: "Edit".localized, style: .default, handler: { alert -> Void in
//
//    let index = self.indexpathlist[sender.tag]
//
//    let vc:AddProdectVC = AppDelegate.sb_main.instanceVC()
//    vc.isFromEdit = true
//
//    //                if self.SelectedCategoryID == 0{
//    let  producatobjavalvity = self.arrayMyOffer[index.section].id
//
//    print(producatobjavalvity)
//    //                    vc.ProId = producatobjavalvity.id!
//    //                    vc.name_en = producatobjavalvity.name_en ?? ""
//    //                    vc.name_ar = producatobjavalvity.name_ar ?? ""
//    //                    vc.description_ar = producatobjavalvity.description_ar ?? ""
//    //                    vc.description_en = producatobjavalvity.description_en ?? ""
//    //                    vc.price = producatobjavalvity.price ?? ""
//    //                    vc.discount = producatobjavalvity.discount ?? ""
//    //                    vc.offer_from = producatobjavalvity.offerFrom ?? ""
//    //                    vc.offer_to = producatobjavalvity.offerTo ?? ""
//    //                    vc.is_start = producatobjavalvity.start ?? ""
//    //                    vc.status = producatobjavalvity.status ?? ""
//    //                    vc.category_id = producatobjavalvity.categoryName ?? ""
//    //                    vc.imgesAt = producatobjavalvity.productImage!
//    //                    vc.categoryString = producatobjavalvity.categoryName ?? ""
//
//
//    self.navigationController?.pushViewController(vc, animated: true)
//
//
//    //let vc:AddNewAddressVC = AppDelegate.sb_main.instanceVC()
//    //vc.isEdit = true
//    //vc.UserAddress = self.AddressArray[self.selctedIndex!]
//    //self.navigationController?.pushViewController(vc, animated: true)
//})
//
//let deleteAction = UIAlertAction(title: "Delete".localized, style: .destructive, handler: { alert -> Void in
//
//    //guard self.AddressArray[self.selctedIndex!].isDefault == "0" else{
//    //    self.showAlert(title: "Erorr".localized, message: "Can't Delete Default //Address".localized)
//    //    return
//    //}
//    //
//    //self.DeleteAddressById()
//})
//
//
//
//let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: {
//    (action : UIAlertAction!) -> Void in })
//
//alertController.addAction(AdditionAction)
//alertController.addAction(editAction)
//alertController.addAction(deleteAction)
//alertController.addAction(cancelAction)
//
//alertController.preferredAction = editAction
//
//self.present(alertController, animated: true, completion: nil)
//
//
