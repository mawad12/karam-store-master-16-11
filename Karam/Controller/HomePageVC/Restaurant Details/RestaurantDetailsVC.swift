//
//  RestaurantDetailsVC.swift
//  Karam
//
//  Created by musbah on 6/17/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import FSPagerView
import Cosmos
import MessageUI


class RestaurantDetailsVC: SuperViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
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
    
    
    @IBOutlet weak var menuButton: UIButton!
    
    @IBOutlet weak var infoButton: UIButton!
    
    
    var indexpathlist = [IndexPath]()

    
    @IBOutlet weak var imgRestauant: UIImageView!
    
    @IBOutlet weak var lblRestaurantName: UILabel!
    
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var imgSatuts: UIImageView!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var RateView: CosmosView!
    
    @IBOutlet weak var lblMinumm: UILabel!
    
    @IBOutlet weak var lblDelivary: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var LikeButton: UIButton!
    
    @IBOutlet weak var commintButton: UIButton!
    
    
    
    var SliderArray = [RestaurantsAttatchment]()

    var MenuArray = [AllCategoryStruct]()
    
    var RestaurantsDetails:RestaurantsStruct?
    
    var ProductArray = [ProductsStruct]()
    
    var ProductItemArray = [ProductItemStruct]()
    
    var Selected_index:Int = 0
    
    var SelectedCategoryID:Int  = 0
    
    
    var isInfo = false
    
    
    var category_id: Int = 0
    var SortBy: String = ""
    var offers: Bool = false
    var Featured: Bool = false
    var MaxValue:Double = 0.0
    var MinValue:Double = 0.0
    
    
    var navigation:UINavigationController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigation = self.navigationController as! CustomNavigationBar
        
        self.collectionView.registerCell(id: "MenuCVC")
        
        self.tableView.registerCell(id: "InfoTVC")
        self.tableView.registerCell(id: "ProductTVC")
        
        pagerView.layer.cornerRadius = 5
        pagerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        
        menuButton.addBottomBorderWithColor(color: "AECB1B".color, width: 1)
        infoButton.addBottomBorderWithColor(color: "FFFFFF".color, width: 1)

        
        imgRestauant.sd_custom(url: CurrentUser.userInfo?.profileImage ?? "")
        lblRestaurantName.text = CurrentUser.userInfo?.name_en
        lblType.text = CurrentUser.userInfo?.restaurantType
        RateView.rating = (Double((CurrentUser.userInfo?.rate)!)) ?? 0.0
        lblMinumm.text = CurrentUser.userInfo?.minimumOrderPrice
        lblDelivary.text = CurrentUser.userInfo?.delivery
        lblTime.text = CurrentUser.userInfo?.deliveryTime

        if CurrentUser.userInfo?.statusNow == "1"{
            lblStatus.text = "Open"
            imgSatuts.image = UIImage(named: "whiteOpen")
        }else{
            lblStatus.text = "Close"
            imgSatuts.image = #imageLiteral(resourceName: "closeIco")
        }
        
        
       
        getAllCategory()
        getProducts()
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        navigation!.navigationBar.isTranslucent = false
        navigation!.navigationBar.setBackgroundImage(UIImage(named: "whiteBar"), for: .default)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let navigation = self.navigationController as! CustomNavigationBar
        navigation.navigationBar.isTranslucent = true
        navigation.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigation.navigationBar.shadowImage = UIImage()
        navigation.setMeunButton(sender: self)
        
       
        
        sideMenuController?.isLeftViewSwipeGestureEnabled = true
        sideMenuController?.isRightViewSwipeGestureEnabled = true
        
        
        getRestaurantsByID()
    }
    
    
    

    @IBAction func EditButtonAction(_ sender: Any) {
        print("edit")
        let vc:EditProfileVC = AppDelegate.sb_main.instanceVC()
        navigationController?.pushViewController(vc, animated: true)
        

        
    }
    
    
    @IBAction func menuButtonAction(_ sender: Any) {
        if let headerView = self.tableView.tableHeaderView {
            
            var headerFrame = headerView.frame
            headerFrame.size.height = 390
            headerView.frame = headerFrame
            self.tableView.tableHeaderView = headerView
            
        }
        isInfo = false
        menuButton.addBottomBorderWithColor(color: "AECB1B".color, width: 1)
        infoButton.addBottomBorderWithColor(color: "D4D1D1".color, width: 1)
        collectionView.isHidden = false
        tableView.reloadData()

    }
    
    
    @IBAction func infoButtonAction(_ sender: Any) {
        if let headerView = self.tableView.tableHeaderView {
            
            var headerFrame = headerView.frame
            headerFrame.size.height = 345
            headerView.frame = headerFrame
            self.tableView.tableHeaderView = headerView
            
        }
        isInfo = true
        menuButton.addBottomBorderWithColor(color: "D4D1D1".color, width: 1)
        infoButton.addBottomBorderWithColor(color: "AECB1B".color, width: 1)
        collectionView.isHidden = true
        tableView.reloadData()

    }
    

    
    
    
    // Get Restaurants By ID
    func getRestaurantsByID(){
        
        if let id = CurrentUser.userInfo?.id {
            _ = WebRequests.setup(controller: self).prepare(query: "getRestaurantById/\(id)", method: HTTPMethod.get).start(){ (response, error) in
                do {
                    
                    let object =  try JSONDecoder().decode(RestaurantDetailsObject.self, from: response.data!)
                    
                    self.RestaurantsDetails = object.items!
                    
                    self.SliderArray = (self.RestaurantsDetails?.attatchment)!
                    self.pagerView.reloadData()
                    self.pageControlle.numberOfPages = self.SliderArray.count
                    
                    self.tableView.reloadData()
                    
                    
                } catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
            }
        }
    }
    
    // Get Products
    func getProducts(){
        
        if let id = CurrentUser.userInfo?.id {
            
            var parameters: [String: Any] = [:]
            
            parameters["restaurant_id"] = id
            
            if category_id != 0 {
                SelectedCategoryID = category_id
            }
            
            if SelectedCategoryID != 0 {
                category_id = 0
                parameters["category_id"] = SelectedCategoryID
            }
            
            if SortBy == "high to Low" {
                parameters["SortBy"] = "1"
            }
            
            if offers != false {
                parameters["offers"] = "1"
            }
            
            if Featured != false {
                parameters["featuredProduct"] = "1"
            }
            
            if MaxValue != 0.0 {
                parameters["price_to"] = MaxValue.description
            }
            
            if MinValue != 0.0 {
                parameters["price_from"] = MinValue.description
            }
            
            _ = WebRequests.setup(controller: self).prepare(query: "getProducts", method: HTTPMethod.post,parameters:parameters).start(){ (response, error) in
                do {
                    
                    if self.SelectedCategoryID == 0{
                        let object =  try JSONDecoder().decode(ProductsObject.self, from: response.data!)
                        
                        self.ProductArray = object.items!
                        
//                  self.ProductItemArray = self.ProductArray.compactMap{$0.product}.flatMap({$0})
                        
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
    
    
    
    
    @IBAction func FilterAction(_ sender: Any) {
        
        let vc:RestaurantsProductsFilterVC = AppDelegate.sb_main.instanceVC()
        vc.CategoryArray = self.MenuArray
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.RestaurantsProductsDelgate = self
        
        self.present(vc, animated: false, completion: nil)
        
    }
    
    
    @IBAction func LikeAction(_ sender: Any) {
    }
    
    
    
    @IBAction func commintAction(_ sender: Any) {
    }
    
    

}






extension RestaurantDetailsVC: FSPagerViewDelegate, FSPagerViewDataSource{
    
    
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
        //        if let id = SliderArray[index]{
        //
        //            let vc:TrainerDetailesVC = AppDelegate.sb_main.instanceVC()
        //            vc.TrainerID = Int(id)
        //            navigationController?.pushViewController(vc, animated: true)
        //        }
        
        //if let LinkURL = SliderArray[index].link{
        //    guard let url = URL(string: LinkURL) else {return}
        //    UIApplication.shared.open(url, options: [:], completionHandler: nil)
        //}
    }
    
    
}


// MARK: - UI CollectionView
extension RestaurantDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
extension RestaurantDetailsVC: UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate{
    
    // Location Button
    @objc func LocationButton(sender:UIButton) {
        guard let latitude = CurrentUser.userInfo?.lat else{
            self.showAlert(title: "Erorr".localized, message: "latitude Can't be Empty".localized)
            return
        }
        guard let longitude = CurrentUser.userInfo?.lan else{
            self.showAlert(title: "Erorr".localized, message: "longitude Can't be Empty".localized)
            return
        }
        
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            // let mrkerPath = "comgooglemaps://?center=\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)"
            if let url = URL(string: "comgooglemaps://?center=\(latitude),\(longitude)&zoom=14&views=traffic&q=\(latitude),\(longitude)"), !url.absoluteString.isEmpty {
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            
            
        } else {
            self.showAlert(title: "Erorr".localized, message: "Can't use google maps Because it does not exist on your mobile device".localized)
            NSLog("Can't use comgooglemaps://");
        }
    }
    
    // Phone Button
    @objc func PhoneButton(sender:UIButton) {
        if (UIApplication.shared.canOpenURL(NSURL(string: "tel://")! as URL)) {
            if let url = URL(string: "tel://\(CurrentUser.userInfo?.mobile)"), !url.absoluteString.isEmpty {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            self.showAlert(title: "Erorr".localized, message: "Can't use tel ".localized)
            NSLog("Can't use tel://");
        }
    }
    
    
    // Mail Button
    @objc func MailButton(sender:UIButton) {
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients([((CurrentUser.userInfo?.email)!)])
        composeVC.setSubject("Message Subject")
        composeVC.setMessageBody("Message content.", isHTML: false)
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
    // Facebook Button
    @objc func FacebookButton(sender:UIButton) {
        if let facebookURL = CurrentUser.userInfo?.facebook{
            guard let url = URL(string: facebookURL) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    // Instagaram Button
    @objc func InstagaramButton(sender:UIButton) {
        if let instagramURL = CurrentUser.userInfo?.instagram{
            guard let url = URL(string: instagramURL) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    // Twitter Button
    @objc func TwitterButton(sender:UIButton) {
        if let twitterURL = CurrentUser.userInfo?.twitter{
            guard let url = URL(string: twitterURL) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
            let  producatobjavalvity = self.ProductArray[index.section].product![index.row]
            
            let vc:AddProdectVC = AppDelegate.sb_main.instanceVC()
            
            if self.SelectedCategoryID == 0{
                
                vc.ProId = producatobjavalvity.id!
                vc.name_ar = ""
                vc.name_en = ""
                vc.price = ""
                vc.description_ar = ""
                vc.description_en = ""
                vc.discount = ""
                vc.offer_from = ""
                vc.offer_to = ""
                vc.is_start = ""
                vc.status = ""
                vc.category_id = ""

            }else{
                vc.ProId = self.ProductItemArray[sender.tag].id!
                
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
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
    
    
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isInfo{
            return 1
        }else{
            if self.SelectedCategoryID == 0{
            return ProductArray.count
            }
            return ProductItemArray.count

        }

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = UITableViewCell()
        
        if isInfo{
            return cell
        }else{
            if self.SelectedCategoryID == 0{
                
                let obj = ProductArray[section]
                
                cell.textLabel?.font = UIFont(name: "Roboto", size: 15)
                cell.textLabel?.textColor = "434731".color
                
                cell.textLabel?.text = obj.title
                
                return cell
            }
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isInfo {
            return 1
        }else{
            if self.SelectedCategoryID == 0{
                 return ProductArray[section].product!.count
            }else{
                 return ProductItemArray.count
            }
            
           
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if isInfo {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTVC", for: indexPath) as! InfoTVC
            
            
            cell.RestaurantID = self.RestaurantsDetails?.id
            cell.getMostCeller()
            cell.controller = self
            
            cell.lblDescription.text = self.RestaurantsDetails?.itemDescription
            cell.lblLocation.text = self.RestaurantsDetails?.address
            cell.lblPhone.text = self.RestaurantsDetails?.mobile
            cell.lblMail.text = self.RestaurantsDetails?.email
            cell.lblFrom.text = self.RestaurantsDetails?.timeFrom
            cell.lblTo.text = self.RestaurantsDetails?.timeTo
            cell.lblDelivaryMethode.text = self.RestaurantsDetails?.delivery
            cell.lblPaymentMethode.text = self.RestaurantsDetails?.paymentMethod
            
            
            if CurrentUser.userInfo?.isAvailable == "1"{
                cell.imgCheck.image = #imageLiteral(resourceName: "GreenTrue")
            }else{
                cell.imgCheck.image = #imageLiteral(resourceName: "GreenTrue")
            }
            
            
            
            cell.LoactionButton.addTarget(self, action: #selector(LocationButton), for: UIControl.Event.touchUpInside)
            
            cell.PhoneButton.addTarget(self, action: #selector(self.PhoneButton), for: UIControl.Event.touchUpInside)
            
            cell.MailButton.addTarget(self, action: #selector(self.MailButton), for: UIControl.Event.touchUpInside)
            
            
            
            if CurrentUser.userInfo?.facebook != nil {
                cell.facebookAction.addTarget(self, action: #selector(self.FacebookButton), for: UIControl.Event.touchUpInside)
            }else{
                cell.facebookAction.isHidden = true
            }
            
            if CurrentUser.userInfo?.instagram != nil {
                cell.instagramAction.addTarget(self, action: #selector(self.InstagaramButton), for: UIControl.Event.touchUpInside)
            }else{
                cell.instagramAction.isHidden = true
            }
            
            if CurrentUser.userInfo?.instagram != nil {
                cell.TwitterAction.addTarget(self, action: #selector(self.TwitterButton), for: UIControl.Event.touchUpInside)
            }else{
                cell.TwitterAction.isHidden = true
            }
            
           
            
            
            return cell
        }else{

            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTVC", for: indexPath) as! ProductTVC
            
            //let singleObj = ProductArray[0].product![indexPath.row]
            
            if self.SelectedCategoryID == 0{
                
                let obj = ProductArray[indexPath.section].product![indexPath.row]
                
                if obj.priceAfterOffer == nil {
                    cell.lblNewPrice.text = "\(obj.price!) " + "SAR".localized
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
                indexpathlist.append(indexPath)

                cell.MoreButton.tag = indexpathlist.count -  1
                cell.MoreButton.addTarget(self, action: #selector(self.MoreButton), for: UIControl.Event.touchUpInside)
                
                return cell
            }else{
                
                let obj = ProductItemArray[indexPath.row]

                if obj.priceAfterOffer == nil {
                    cell.lblNewPrice.text = "\(obj.price!) " + "SAR".localized
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

        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isInfo{
            
        }else{
            let vc:ProductDetailsVC = AppDelegate.sb_main.instanceVC()
            if self.SelectedCategoryID == 0{
                vc.productID = ProductArray[indexPath.row].id
                navigationController?.pushViewController(vc, animated: true)
            }else{
                vc.productID = ProductItemArray[indexPath.row].id
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if isInfo {
            return UITableView.automaticDimension
        }else{
            return 170
        }
    }
    
    
}



extension RestaurantDetailsVC: RestaurantsProductsFilterDelgate {
    
    func SelectedDone(category_id: Int, SortBy: String, offers: Bool, Featured: Bool, MaxValue: Double, MinValue: Double) {
        
        self.category_id = category_id
        self.SortBy = SortBy
        self.offers = offers
        self.Featured = Featured
        self.MaxValue = MinValue
        self.MinValue = MaxValue
        
        
        getProducts()
        
    }
    
}
