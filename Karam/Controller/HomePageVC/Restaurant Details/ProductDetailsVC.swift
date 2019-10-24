//
//  ProductDetailsVC.swift
//  Karam
//
//  Created by musbah on 6/20/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import Cosmos
import FSPagerView


class ProductDetailsVC: SuperViewController {

    
    @IBOutlet weak var lblViews: UILabel!
    
    @IBOutlet weak var lblLikes: UILabel!

    @IBOutlet weak var OldPriceView: UIView!
    
    @IBOutlet weak var lblOldPrice: UILabel!
    
    @IBOutlet weak var lblNewPrice: UILabel!

    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var rateView: CosmosView!
    
     @IBOutlet weak var EndOffersDateView: UIView!
    
    @IBOutlet weak var lblEndOfferDate: UILabel!
    
    var idCat : Int?
    var name_en = ""
    var name_ar = ""
    var description_ar = ""
    var description_en = ""
    var price = ""
    var discount = ""
    var offer_from = ""
    var offer_to = ""
    var categoryString = ""
    
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }

    @IBOutlet weak var pageControlle: FSPageControl!{
        didSet{
            pageControlle.numberOfPages = SliderArray.count
            pageControlle.contentHorizontalAlignment = .center
            pageControlle.setImage(UIImage(named: "whiteRect"), for: .normal)
            pageControlle.setImage(UIImage(named: "selectedRect"), for: .selected)
            
        }
    }

    @IBOutlet weak var lblDeliveryTime: UILabel!
    
    
    @IBOutlet weak var lblProductCategory: UILabel!
    
    
    @IBOutlet weak var lblProductDetails: UILabel!
    
    
    //@IBOutlet weak var imgRestaurant: UIImageView!
    
    //@IBOutlet weak var lblRestaurantName: UILabel!
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    
    
    var SliderArray = [ProductImage]()

    var RelatedProductsArray = [ProductItemStruct]()

    var productID:Int?
    
    var Object: ProductItemStruct?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagerView.layer.cornerRadius = 5
        pagerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        let navigation = self.navigationController as! CustomNavigationBar
        navigation.setCustomBackButtonForViewController(sender: self)
        navigation.setRightButtons([navigation.MoreBtn!], sender: self)

        sideMenuController!.isLeftViewSwipeGestureEnabled = false
        sideMenuController!.isRightViewSwipeGestureEnabled = false
        
        self.collectionView.registerCell(id: "RelatedProductsCVC")

        LoadData()
    }
    
    
    
    override func didClickRightButton(_sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Product".localized, message: "", preferredStyle: .actionSheet)
        
        let AdditionAction = UIAlertAction(title: "Addition".localized, style: .default, handler: { alert -> Void in
            
        
            
            let vc:AdditionalVC = AppDelegate.sb_main.instanceVC()
            
            vc.AddId = self.idCat
            self.navigationController?.pushViewController(vc, animated: true)
        })
        
        let editAction = UIAlertAction(title: "Edit".localized, style: .default, handler: { alert -> Void in
            
            
            let vc:AddProdectVC = AppDelegate.sb_main.instanceVC()
            vc.isFromEdit = true
            
            //                    if self.SelectedCategoryID == 0{
            //                        let  producatobjavalvity = self.ProductArray[index.section].product![index.row]
            
            
            vc.isFromEdit = true
            vc.name_en = self.name_en
            vc.name_ar = self.name_ar
            vc.description_ar = self.description_ar
            vc.description_en = self.description_en
            vc.price = self.price
            vc.discount = self.discount
            vc.offer_from = self.offer_from
            vc.offer_to = self.offer_to
            vc.categoryString = self.categoryString
            
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
    
    
    
    func getProducts(){
        
        _ = WebRequests.setup(controller: self).prepare(query: "relatedProduct/\(productID ?? 0)", method: HTTPMethod.get).start(){ (response, error) in
            do {
                
                let object =  try JSONDecoder().decode(ProductsCategoryObject.self, from: response.data!)
                
                self.RelatedProductsArray = object.items!
                
                
                
                self.collectionView.reloadData()
                
                
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
        
    }
    
    
    
    func LoadData() {
        _ = WebRequests.setup(controller: self).prepare(query: "getProductById/\(productID ?? 0)", method: HTTPMethod.get).start(){ (response, error) in
            do {
                
                self.getProducts()
                
               
                let object =  try JSONDecoder().decode(ProductStruct.self, from: response.data!)
                self.Object = object.items!
                
                
                self.SliderArray = self.Object?.productImage ?? []
                
                self.pagerView.reloadData()
                self.pageControlle.numberOfPages = self.SliderArray.count
                
                
                self.lblViews.text = "\(self.Object?.views ?? 0) " + "Views".localized
                self.lblLikes.text = "\(self.Object?.likeCount ?? 0) " + "Likes".localized
                
                if self.Object?.priceAfterOffer == nil {
                    self.lblNewPrice.text = "\(self.Object?.price ?? "0") " + "SAR".localized
                    self.OldPriceView.isHidden = true
                    self.lblOldPrice.isHidden = true
                }else{
                    self.lblOldPrice.text = "\(self.Object?.price ?? "0") " + "SAR".localized
                    self.lblNewPrice.text = "\(self.Object?.priceAfterOffer ?? "0") " + "SAR".localized
                }
                
                
                self.lblProductName.text = self.Object?.name ?? ""
                if let EndOffer = self.Object?.dealDayDate{
                    self.lblEndOfferDate.text = EndOffer
                }else{
                    self.EndOffersDateView.isHidden = true
                }
                
                self.lblDeliveryTime.text = "\(self.Object?.deliveryTime ?? "") Min".localized
                self.lblProductDetails.text = self.Object?.description ?? ""
                self.rateView.rating = Double((self.Object?.rate!)!)
                
                self.lblProductCategory.text = self.Object?.categoryName ?? ""
                
              
                let navigation = self.navigationController as! CustomNavigationBar
                navigation.setTitle( (self.Object?.name)!, sender: self,Srtingcolor :"AECB1B")
                
                
                
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
        
    }
    
    
    


  

}





// MARK: - UI CollectionView
extension ProductDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.RelatedProductsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RelatedProductsCVC", for: indexPath) as! RelatedProductsCVC
        
        
        let obj = RelatedProductsArray[indexPath.row]
        
        if let text = obj.discount {
            cell.imgCorner.isHidden = false
            cell.lblDiscount.isHidden = false
            cell.lblDiscount.text = "\(text)%"
        }else{
            cell.imgCorner.isHidden = true
            cell.lblDiscount.isHidden = true
        }
        
        cell.imgProduct.sd_custom(url: obj.coverImage ?? "")
        cell.lblProductName.text = obj.name ?? ""
        
        cell.lblProductPrice.text = "\(obj.priceAfterOffer ?? "0") " + "SAR".localized
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 122 , height: 196)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        
        
    }
    
    
}



extension ProductDetailsVC: FSPagerViewDelegate, FSPagerViewDataSource{
    
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return SliderArray.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.sd_custom(url: SliderArray[index].image ?? "")
        self.pageControlle.currentPage = pagerView.currentIndex
        return cell
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControlle.currentPage = pagerView.currentIndex
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControlle.currentPage = targetIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        //let browser = SKPhotoBrowser(photos: images)
        //browser.initializePageIndex(index)
        //SKPhotoBrowserOptions.displayAction = false    // action button will be hidden
        //self.present(browser, animated: true, completion: nil)
    }
    
    
}

/*
 

 
 

 
 */
