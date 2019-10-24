//
//  ProductVC.swift
//  Karam
//
//  Created by musbah on 7/16/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class ProductVC: SuperViewController {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var collectionView: UICollectionView!

    var MenuArray = [AllCategoryStruct]()

    
    var ProductArray = [ProductsStruct]()
    
    var ProductItemArray = [ProductItemStruct]()
    
    var Selected_index:Int = 0
    
    var SelectedCategoryID:Int  = 0
    
    var indexpathlist = [IndexPath]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.registerCell(id: "MenuCVC")
        
        self.tableView.registerCell(id: "ProductTVC")
        
        let navigation = self.navigationController as! CustomNavigationBar
        navigation.setTitle("Products".localized, sender: self,Srtingcolor :"AECB1B")
        navigation.setRightButtons([navigation.addBtn!], sender: self)
        navigation.setMeunButton(sender: self)
        navigation.setShadowNavBar()
        
        
        
        
        getAllCategory()
        getProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        sideMenuController?.isLeftViewSwipeGestureEnabled = true
        sideMenuController?.isRightViewSwipeGestureEnabled = true
    }
    
    override func didClickRightButton(_sender: UIBarButtonItem) {
        print("add")
        
        let vc:AddProdectVC = AppDelegate.sb_main.instanceVC()
        navigationController?.pushViewController(vc, animated: true)
        
    }

    // Get all Category
    func getAllCategory(){
        
        _ = WebRequests.setup(controller: self).prepare(query: "allCategory", method: HTTPMethod.get).start(){ (response, error) in
            do {
                
                let object =  try JSONDecoder().decode(AllCategoryObject.self, from: response.data!)
                
                self.MenuArray = object.items!
                
                let allCategory = AllCategoryStruct.init(id: 0, logo: "", status: "", title: "All".localized)
                self.MenuArray.insert(allCategory, at: 0)
                
                self.collectionView.reloadData()
                
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }

    
    // Get Products
    func getProducts(){
        
        if let id = CurrentUser.userInfo?.id {
            
            var parameters: [String: Any] = [:]
            
            parameters["restaurant_id"] = id
            
            if SelectedCategoryID != 0 {
                parameters["category_id"] = SelectedCategoryID
            }
        
            _ = WebRequests.setup(controller: self).prepare(query: "getProducts", method: HTTPMethod.post,parameters:parameters).start(){ (response, error) in
                do {
                    
                    if self.SelectedCategoryID == 0{
                        let object =  try JSONDecoder().decode(ProductsObject.self, from: response.data!)
                        
                        self.ProductArray = object.items!
                        //self.ProductItemArray = self.ProductArray.compactMap{$0.product}.flatMap({$0})
                        
                    }else{
                        
                        let object =  try JSONDecoder().decode(ProductsCategoryObject.self, from: response.data!)
                        
                        self.ProductArray.removeAll()
                        self.ProductItemArray = object.items!
                    }
                    
                    
                    
                    self.tableView.reloadData()
                    
                    
                } catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
            }
        }
    }

    
    
    // More Button
    @objc func MoreButton(sender:UIButton) {
        print("more")
        let alertController = UIAlertController(title: "Product".localized, message: "", preferredStyle: .actionSheet)
        
        let AdditionAction = UIAlertAction(title: "Addition".localized, style: .default, handler: { alert -> Void in
            
            let index = self.indexpathlist[sender.tag]
            let  producatobjavalvity = self.ProductArray[index.section].product![index.row].id
            
            let vc:AdditionalVC = AppDelegate.sb_main.instanceVC()
            
            if self.SelectedCategoryID == 0{
                
                vc.AddId = producatobjavalvity
                
            }else{
                vc.AddId = self.ProductItemArray[sender.tag].id
                
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        })
        
        let editAction = UIAlertAction(title: "Edit".localized, style: .default, handler: { alert -> Void in
            
            let index = self.indexpathlist[sender.tag]
            
            let vc:AddProdectVC = AppDelegate.sb_main.instanceVC()
            vc.isFromEdit = true

            if self.SelectedCategoryID == 0{
                let  producatobjavalvity = self.ProductArray[index.section].product![index.row]

                vc.ProId = producatobjavalvity.id!
                vc.name_en = producatobjavalvity.name_en ?? ""
                vc.name_ar = producatobjavalvity.name_ar ?? ""
                vc.description_ar = producatobjavalvity.description_ar ?? ""
                vc.description_en = producatobjavalvity.description_en ?? ""
                vc.price = producatobjavalvity.price ?? ""
                vc.discount = producatobjavalvity.discount ?? ""
                vc.offer_from = producatobjavalvity.offerFrom ?? ""
                vc.offer_to = producatobjavalvity.offerTo ?? ""
                vc.is_start = producatobjavalvity.start ?? ""
                vc.status = producatobjavalvity.status ?? ""
                vc.category_id = producatobjavalvity.categoryName ?? ""
                vc.imgesAt = producatobjavalvity.productImage!
                vc.categoryString = producatobjavalvity.categoryName ?? ""
            }else{

                vc.ProId = self.ProductItemArray[sender.tag].id!
                vc.name_en = self.ProductItemArray[sender.tag].name_en ?? ""
                vc.name_ar = self.ProductItemArray[sender.tag].name_ar ?? ""
                vc.description_ar = self.ProductItemArray[sender.tag].description_ar ?? ""
                vc.description_en = self.ProductItemArray[sender.tag].description_en ?? ""
                vc.price = self.ProductItemArray[sender.tag].price ?? ""
                vc.discount = self.ProductItemArray[sender.tag].discount ?? ""
                vc.offer_from = self.ProductItemArray[sender.tag].offerFrom ?? ""
                vc.offer_to = self.ProductItemArray[sender.tag].offerTo ?? ""
                vc.is_start = self.ProductItemArray[sender.tag].start ?? ""
                vc.status = self.ProductItemArray[sender.tag].status ?? ""
                vc.category_id = self.ProductItemArray[sender.tag].categoryName ?? ""
                vc.imgesAt = self.ProductItemArray[sender.tag].productImage!
                vc.categoryString = self.ProductItemArray[sender.tag].categoryName ?? ""


            }

            self.navigationController?.pushViewController(vc, animated: true)

            
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
}




// MARK: - UI CollectionView
extension ProductVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.MenuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCVC", for: indexPath) as! MenuCVC
        
        cell.lblTitle.text = MenuArray[indexPath.row].title
        if (indexPath.row == Selected_index){
            cell.lblTitle.textColor = "AECB1B".color
        }else{
            cell.lblTitle.textColor = "65694F".color
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let title = self.MenuArray[indexPath.row].title!
        
        let w = title.width(withConstraintedHeight: 10, font: .systemFont(ofSize: 17)) + 15
        return CGSize(width: w , height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        Selected_index = indexPath.row
        SelectedCategoryID = MenuArray[indexPath.row].id!
        getProducts()
        collectionView.reloadData()
        tableView.reloadData()
        
    }
    
    
    
}




// MARK: - UI TableView
extension ProductVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if self.SelectedCategoryID == 0{
            return ProductArray.count
        }
        return ProductItemArray.count
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = UITableViewCell()
        
        if self.SelectedCategoryID == 0{
            
            let obj = ProductArray[section]
            
            cell.textLabel?.font = UIFont(name: "Roboto", size: 15)
            cell.textLabel?.textColor = "434731".color
            
            cell.textLabel?.text = obj.title
            
            return cell
        }
        return cell
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.SelectedCategoryID == 0{
            return ProductArray[section].product!.count
        }else{
            return ProductItemArray.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTVC", for: indexPath) as! ProductTVC
        
        //let singleObj = ProductArray[0].product![indexPath.row]
        
        if self.SelectedCategoryID == 0{
            
            let obj = ProductArray[indexPath.section].product![indexPath.row]
            
            if obj.priceAfterOffer == nil {
                cell.lblNewPrice.text = "\(obj.price!) " + "SAR".localized
                cell.OldPriceView.isHidden = true
                cell.lblOldPrice.isHidden = true
                cell.mainView.isHidden = true
            }else{
                cell.lblOldPrice.text = "\(obj.price!) " + "SAR".localized
                cell.lblNewPrice.text = "\(obj.priceAfterOffer ?? "") " + "SAR".localized
            }
            
            cell.lblProductName.text = obj.name
            cell.lblProductsDescrpiton.text = obj.description
            
            if let text = obj.offerTo {
                cell.lblDate.text =  "\(text.prefix(11))" // split text date
            }
            
            if let img = obj.coverImage, img != ""{
                cell.imgProduct.sd_custom(url: img)
            }
            
            if let text = obj.discount {
                cell.imgCorner.isHidden = false
                cell.lblDiscount.isHidden = false
                cell.lblDiscount.text = "\(text)%"
                cell.lblOldPrice.isHidden = false
                cell.OldPriceView.isHidden = false
                cell.mainView.isHidden = false
            }else{
                cell.imgCorner.isHidden = true
                cell.lblDiscount.isHidden = true
                cell.lblOldPrice.isHidden = true
                cell.OldPriceView.isHidden = true
                cell.mainView.isHidden = true
            }
            
            indexpathlist.append(indexPath)
            
            cell.MoreButton.tag = indexpathlist.count -  1
            cell.MoreButton.addTarget(self, action: #selector(self.MoreButton), for: UIControl.Event.touchUpInside)
            
            
            
//            if item.priceAfterOffer == nil {
//                cell.lblNewPrice.text = "\(item.price!) " + "SAR".localized
//                cell.lblOldPrice.isHidden = true
//                cell.OldPriceView.isHidden = true
//            }else{
//                cell.lblOldPrice.text = "\(item.price!) " + "SAR".localized
//                cell.lblNewPrice.text = "\(item.priceAfterOffer ?? "") " + "SAR".localized
//            }
//
//            if let text = item.discount {
//                cell.imgCorner.isHidden = false
//                cell.lblDiscount.isHidden = false
//                cell.lblDiscount.text = "\(text)%"
//                cell.lblOldPrice.isHidden = false
//                cell.OldPriceView.isHidden = false
//            }else{
//                cell.imgCorner.isHidden = true
//                cell.lblDiscount.isHidden = true
//                cell.lblOldPrice.isHidden = true
//                cell.OldPriceView.isHidden = true
//            }
            return cell
        }else{
            
            let obj = ProductItemArray[indexPath.row]
            
            if obj.priceAfterOffer == nil {
                cell.lblNewPrice.text = "\(obj.price!) " + "SAR".localized
                cell.OldPriceView.isHidden = true
            }else{
                cell.lblOldPrice.text = "\(obj.price!) " + "SAR".localized
                cell.lblNewPrice.text = "\(obj.priceAfterOffer ?? "") " + "SAR".localized
            }
            
            cell.lblProductName.text = obj.name
            cell.lblProductsDescrpiton.text = obj.description
            
            if let text = obj.offerTo {
                cell.lblDate.text =  "\(text.prefix(11))" // split text date
            }
            
            if let img = obj.coverImage, img != ""{
                cell.imgProduct.sd_custom(url: img)
            }
            
            if let text = obj.discount {
                cell.imgCorner.isHidden = false
                cell.lblDiscount.isHidden = false
                cell.lblDiscount.text = "\(text)%"
            }else{
                cell.imgCorner.isHidden = true
                cell.lblDiscount.isHidden = true
            }
            
            
            cell.MoreButton.tag = indexPath.row
            cell.MoreButton.addTarget(self, action: #selector(self.MoreButton), for: UIControl.Event.touchUpInside)
            
            return cell
        }
        
        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let  producatobjavalvity = self.ProductArray[indexPath.section].product![indexPath.row]

        let vc:ProductDetailsVC = AppDelegate.sb_main.instanceVC()
        vc.name_en = producatobjavalvity.name_en ?? ""
        vc.name_ar = producatobjavalvity.name_ar ?? ""
        vc.description_ar = producatobjavalvity.description_ar ?? ""
        vc.description_en = producatobjavalvity.description_en ?? ""
        vc.price = producatobjavalvity.price ?? ""
        vc.discount = producatobjavalvity.price ?? ""
        vc.offer_from = producatobjavalvity.offerFrom ?? ""
        vc.offer_to = producatobjavalvity.offerTo ?? ""
        vc.categoryString = producatobjavalvity.categoryName ?? ""
        vc.idCat = producatobjavalvity.id ?? 0
        if self.SelectedCategoryID == 0{
            vc.productID = ProductArray[indexPath.section].product![indexPath.row].id
            
            navigationController?.pushViewController(vc, animated: true)
        }else{
            vc.productID = ProductItemArray[indexPath.row].id
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 170
    }
    
    
    
}
