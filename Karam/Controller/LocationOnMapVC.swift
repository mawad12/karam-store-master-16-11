//
//  LocationOnMapVC.swift
//  Karam
//
//  Created by ibrahim eljabaly on 9/17/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import GoogleMaps
class LocationOnMapVC: UIViewController {

    @IBOutlet weak var gms : GMSMapView!
    var lat : String?
    var long : String?
    var name : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        let camera = GMSCameraPosition.camera(withLatitude: Double(lat!)!, longitude: Double(long!)!, zoom: 11.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(lat!)!, longitude: Double(long!)!)
        marker.title = name!
                
        marker.map = mapView
//        gms.camera = camera
        
    }
    
    
//    @IBAction func btnBack(sender : UIButton){
//        self.dismiss(animated: true, completion: nil)
//    }



}
