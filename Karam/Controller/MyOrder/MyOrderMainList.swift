//
//  MyOrderMainList.swift
//  Karam
//
//  Created by ahmed on 6/25/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import BmoViewPager
import CoreLocation
import Firebase
import AVFoundation
import AVKit

private let mainColor = "AECB1B".color

class MyOrderMainList: SuperViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var viewPagerNavigationBar: BmoViewPagerNavigationBar!
    
    @IBOutlet weak var viewPager: BmoViewPager!
    
    var SuperPageItem = SuperItem()
    
    var parameters = [String : Any]()
    var orderId = ""
    var isDelivery = -1
    var status: String = ""
    var selectedDate: String = ""
    
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

    
    var links = ["openOrder","openOrder"]
    var linksDriver = ["getAllOrderToDriver","getAllOrderToDriver"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigation = self.navigationController as! CustomNavigationBar
        
        navigation.setTitle("My Orders".localized, sender: self,Srtingcolor :"AECB1B")
        navigation.setRightButtons([navigation.FilterBtn!], sender: self)
        navigation.setMeunButton(sender: self)
        
        sideMenuController!.isLeftViewSwipeGestureEnabled = true
        sideMenuController!.isRightViewSwipeGestureEnabled = true
        
        
        viewPager.dataSource = self
        viewPagerNavigationBar.autoFocus = false
        viewPagerNavigationBar.viewPager = viewPager
        
        viewPager.layer.borderWidth = 1.0
        viewPager.layer.cornerRadius = 5.0
        viewPager.layer.masksToBounds = true
        viewPager.layer.borderColor = UIColor.white.cgColor
//
//        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)

        
        if self.status != "" {
            self.parameters["status"] = self.status
        }
        
        if self.selectedDate != "" {
            self.parameters["date"] = self.selectedDate
        }
        
        if isDelivery == 1 {
            self.parameters["delivery"] = "dilevery"
        }else if isDelivery == 0{
            self.parameters["delivery"] = "pickup"
        }
        
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //let navigation = self.navigationController as! CustomNavigationBar
        //navigation.navigationBar.isTranslucent = false
        //navigation.navigationBar.setBackgroundImage(UIImage(named: "whiteBar"), for: .default)
        
        
    }
    
    override func didClickRightButton(_sender: UIBarButtonItem) {
        let vc:MyOrdersFilterVC = AppDelegate.sb_main.instanceVC()
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        
        if viewPager.pageControlIndex == 1 {
            vc.isCompleteVC = true
        }
        
        vc.MyOrdersDelgate = self
        
        self.present(vc, animated: false, completion: nil)
        
    }
    
}

extension MyOrderMainList: BmoViewPagerDataSource {
    // Optional
    func bmoViewPagerDataSourceNaviagtionBarItemNormalAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedString.Key : Any]? {
        return [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17.0),
            NSAttributedString.Key.foregroundColor : UIColor.lightGray
        ]
    }
    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedAttributed(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> [NSAttributedString.Key : Any]? {
        return [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17.0),
            NSAttributedString.Key.foregroundColor : mainColor
        ]
    }
    func bmoViewPagerDataSourceNaviagtionBarItemHighlightedBackgroundView(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> UIView? {
        let view = UnderLineView()
        view.marginX = 0.0
        view.lineWidth = 5.0
        view.strokeColor = mainColor
        return view
    }
    func bmoViewPagerDataSourceNaviagtionBarItemNormalBackgroundView(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> UIView? {
        let view = UnderLineView()
        view.marginX = 0.0
        view.lineWidth = 2.0
        view.strokeColor = UIColor.gray
        return view
    }
    func bmoViewPagerDataSourceNaviagtionBarItemTitle(_ viewPager: BmoViewPager, navigationBar: BmoViewPagerNavigationBar, forPageListAt page: Int) -> String? {
        switch page {
        case 0:
            if CurrentUser.userInfo?.typeUser == "4"{
                return "Start deliver".localized

            }
            return "Open Orders".localized
        case 1:
            if CurrentUser.userInfo?.typeUser == "4"{
                return "Completed".localized
                
            }

            return "Completed Orders".localized
        default:
            break
        }
        return "Demo \(page)"
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coord = manager.location?.coordinate else { return }
        print("mmkj")

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
        values["orderId"] = orderId
        ref.child("Employee").child("\(CurrentUser.userInfo?.id ?? 0)").updateChildValues(values) { (error, reference) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            print("success")
        }
    }
    

    
    // Required
    func bmoViewSplitFull(in viewPager: BmoViewPager) -> Bool {
        return true
    }
    func bmoViewPagerDataSourceNumberOfPage(in viewPager: BmoViewPager) -> Int {
        return 2
        
    }
    func bmoViewPagerDataSource(_ viewPager: BmoViewPager, viewControllerForPageAt page: Int) -> UIViewController {
        switch page {

        case 0:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController {
                if CurrentUser.userInfo?.typeUser == "4"{
                    let item = OpenOrderItem()
                    item.RequestUrl = linksDriver[page]
                    item.parameters = self.parameters
                    vc.SuperPageItem = item
                    
                    return vc

                }
                let item = OpenOrderItem()
                item.RequestUrl = links[page] 
                item.parameters = self.parameters
                vc.SuperPageItem = item
                
                return vc
            }
        case 1:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController {
                
                if CurrentUser.userInfo?.typeUser == "4"{
                    print("moh awad is here")
                    let item = CompletedOrderItem()
                    item.RequestUrl = linksDriver[page] + "?status=4"
                    print(item.RequestUrl)
                    item.parameters = self.parameters
                    vc.SuperPageItem = item
                    return vc

                }
                let item = CompletedOrderItem()
                item.RequestUrl = links[page] + "?status=4"
                item.parameters = self.parameters
                vc.SuperPageItem = item
                return vc
            }
            
        default:
            break
        }
        return UIViewController()
    }
}

@IBDesignable
class UnderLineView: UIView {
    @IBInspectable var strokeColor: UIColor = UIColor.black {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var lineWidth: CGFloat = 2.0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var marginX: CGFloat = 0.0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        strokeColor.setStroke()
        context.setLineWidth(lineWidth)
        context.move(to: CGPoint(x: rect.minX + marginX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX - marginX, y: rect.maxY))
        context.strokePath()
    }
}





extension MyOrderMainList: MyOrdersFilterDelgate{
    
    func SelectedDone(isDelivery: Int, status: String, selectedDate: String) {
        
        self.isDelivery = isDelivery
        self.status = status
        self.selectedDate = selectedDate
        self.parameters.removeAll()
        
        
        if self.status != "" {
            self.parameters["status"] = self.status
        }
        
        if self.selectedDate != "" {
            self.parameters["date"] = self.selectedDate
        }
        
       
        if isDelivery == 1 {
            self.parameters["delivery"] = "dilevery"
        }else if isDelivery == 0{
            self.parameters["delivery"] = "pickup"
        }
        
        
        self.viewPager.reloadData()
        
    }
    
    
    
}
