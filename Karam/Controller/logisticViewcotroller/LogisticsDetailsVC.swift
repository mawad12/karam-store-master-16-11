//
//  LogisticsDetailsVC.swift
//  Karam
//
//  Created by musbah on 7/20/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import FSPagerView
import Cosmos
import MessageUI



class LogisticsDetailsVC: SuperViewController, MFMailComposeViewControllerDelegate{

    
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
    
    
    @IBOutlet weak var CompanyImg: UIImageView!
    
    @IBOutlet weak var lblCompanyName: UILabel!
    
    @IBOutlet weak var lblCategory: UILabel!
    
    @IBOutlet weak var imgSatuts: UIImageView!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var RateView: CosmosView!
    
    
    @IBOutlet weak var lblDescription: UILabel!
    
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var LoactionButton: UIButton!
    
    
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var PhoneButton: UIButton!
    
    
    @IBOutlet weak var lblMail: UILabel!
    
    @IBOutlet weak var MailButton: UIButton!
    
    
    @IBOutlet weak var lblCompanyType: UILabel!
    @IBOutlet weak var CompanyTypeButton: UIButton!
    
    
    @IBOutlet weak var lblFrom: UILabel!
    
    @IBOutlet weak var lblTo: UILabel!
    
    
    @IBOutlet weak var lblPaymentMethode: UILabel!
    

    @IBOutlet weak var facebookButton: UIButton!
    
    @IBOutlet weak var instagramButton: UIButton!
    
    @IBOutlet weak var TwitterButton: UIButton!
    
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    var myLat: Double?
    var mylon: Double?
    
    var Faceboock:String?
    var Instagram:String?
    var Twitter:String?
    
    var Mail:String?
    var Phone:String?

    
    var SliderArray = ["","","","","",""]
    
    var imgArray = [ProductItemStruct]()
    
    var LogisticID:Int?
    
    var ObjectDetails:LogisticDetailsStruct?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagerView.layer.cornerRadius = 5
        pagerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        
        getLogisticDetails()
    }
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        let navigation = self.navigationController as! CustomNavigationBar
        navigation.navigationBar.isTranslucent = false
        navigation.navigationBar.setBackgroundImage(UIImage(named: "whiteBar"), for: .default)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let navigation = self.navigationController as! CustomNavigationBar
        navigation.navigationBar.isTranslucent = true
        navigation.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigation.navigationBar.shadowImage = UIImage()
        navigation.setCustomBackButtonForViewController(sender: self)
        
        
        sideMenuController?.isLeftViewSwipeGestureEnabled = false
        sideMenuController?.isRightViewSwipeGestureEnabled = false
        
        
    }
    
    
    func getLogisticDetails(){
        
        _ = WebRequests.setup(controller: self).prepare(query: "getLogisticsDetailById/\(LogisticID ?? 0)", method: HTTPMethod.get).start(){ (response, error) in
            do {
                let Status =  try JSONDecoder().decode(LogisticDetailsObject.self, from: response.data!)
                
                self.ObjectDetails = Status.items!
                
                
                self.CompanyImg.sd_custom(url: self.ObjectDetails?.profileImage ?? "")
                self.lblCompanyName.text = self.ObjectDetails?.name
                self.lblCategory.text = self.ObjectDetails?.category?.title
                
                if self.ObjectDetails?.statusNow == "1"{
                    self.lblStatus.text = "Open"
                    self.imgSatuts.image = UIImage(named: "whiteOpen")
                }else{
                    self.lblStatus.text = "Close"
                    self.imgSatuts.image = #imageLiteral(resourceName: "closeIco")
                }
                
                self.RateView.rating = Double(self.ObjectDetails?.rate ?? 0)
                
                self.lblDescription.text = self.ObjectDetails?.itemsDescription
                
                self.lblLocation.text = self.ObjectDetails?.address
                //self.LoactionButton
                
                self.lblPhone.text = self.ObjectDetails?.mobile
                //self.PhoneButton
                
                self.lblMail.text = self.ObjectDetails?.email
                //self.MailButton
                
                self.lblCompanyType.text = self.ObjectDetails?.typeUser
               // self.CompanyTypeButton
                
                self.lblFrom.text = self.ObjectDetails?.timeFrom
                self.lblTo.text = self.ObjectDetails?.timeTo
                
                self.lblPaymentMethode.text = self.ObjectDetails?.paymentMethod
                
            
                self.myLat = Double((self.ObjectDetails?.lat!)!) as! Double
                self.mylon = Double((self.ObjectDetails?.lan!)!) as! Double
                
                self.Faceboock = self.ObjectDetails?.facebook
                self.Instagram = self.ObjectDetails?.instagram
                self.Twitter = self.ObjectDetails?.twitter
                self.Mail = self.ObjectDetails?.email
                self.Phone = self.ObjectDetails?.mobile
                
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
    
    @IBAction func LocationButton(_ sender: Any) {
        
        guard let latitude = self.myLat else{
            self.showAlert(title: "Erorr".localized, message: "latitude Can't be Empty".localized)
            return
        }
        guard let longitude = self.mylon else{
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
    
    @IBAction func PhoneButton(_ sender: Any) {
        
        if (UIApplication.shared.canOpenURL(NSURL(string: "tel://")! as URL)) {
            if let url = URL(string: "tel://\(self.Phone)"), !url.absoluteString.isEmpty {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            self.showAlert(title: "Erorr".localized, message: "Can't use tel ".localized)
            NSLog("Can't use tel://");
        }
        
        
    }
    
    @IBAction func MailButton(_ sender: Any) {
    
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
    
    
    
    
    @IBAction func FaceBookButton(_ sender: Any) {
        
        if let facebookURL = self.Faceboock{
            guard let url = URL(string: facebookURL) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    @IBAction func InstagramButton(_ sender: Any) {
        if let instagramURL = self.Instagram {
            guard let url = URL(string: instagramURL) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        
    }
    
    @IBAction func TwitterButton(_ sender: Any) {
        
        if let twitterURL = self.Twitter{
            guard let url = URL(string: twitterURL) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    


}



// MARK: - UI FSPagerView
extension LogisticsDetailsVC: FSPagerViewDelegate, FSPagerViewDataSource{
    
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return SliderArray.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        //cell.imageView?.sd_custom(url: SliderArray[index].image ?? "")
        cell.imageView?.image = #imageLiteral(resourceName: "1231")
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
extension LogisticsDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCVC", for: indexPath) as! MenuCVC
//
//        cell.lblTitle.text = MenuArray[indexPath.row].title
//        if (indexPath.row == Selected_index){
//            cell.lblTitle.textColor = "AECB1B".color
//        }else{
//            cell.lblTitle.textColor = "65694F".color
//        }
//
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        

        return CGSize(width: 90 , height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
//        Selected_index = indexPath.row
//        SelectedCategoryID = MenuArray[indexPath.row].id!
//        getProducts()
//        collectionView.reloadData()
//        tableView.reloadData()
//
    }
    
    
}
