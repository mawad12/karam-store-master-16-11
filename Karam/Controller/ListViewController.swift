//
//  OpenOrders.swift
//  Karam
//
//  Created by ahmed on 6/25/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import AVFoundation
import AVKit


class ListViewController: SuperViewController ,CLLocationManagerDelegate{
    var SuperPageItem = SuperItem()
    @IBOutlet weak var tableView: UITableView!
    var listArray = [Any]()
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
        super.viewDidLoad()
        self.SuperPageItem.tableView = self.tableView
        SuperPageItem.viewController = self
        
//        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)

//        self.SuperPageItem.withIdentifierCell = ["RestaurantTVC"]
        self.SuperPageItem.LoadItem()
        
        // Do any additional setup after loading the view.
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
        
        ref.child("Employee").child("\(CurrentUser.userInfo?.id ?? 0)").updateChildValues(values) { (error, reference) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            print("success")
        }
    }
    
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - UI TableView
extension ListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SuperPageItem.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return SuperPageItem.prepareCellForData(in: tableView, Data: listArray, indexPath: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SuperPageItem.cellDidSelected(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SuperPageItem.prepareCellheight(indexPath: indexPath)
    }
    
}
