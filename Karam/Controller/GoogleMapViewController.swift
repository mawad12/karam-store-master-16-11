//
//  GoogleMapViewController.swift
//  Karam
//
//  Created by ibrahim eljabaly on 9/18/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces


class GoogleMapViewController: UIViewController , GMSMapViewDelegate , CLLocationManagerDelegate{

    @IBOutlet weak var gmap: GMSMapView!
    @IBOutlet weak var view_Cover: UIView!
    var city : String?
    var country : String?
    var output = ""
    var lat1 : Double?
    var long1 : Double?
    
    var lat2 : Double?
    var long2 : Double?
    
    var lat3 : Double?
    var long3 : Double?
    
    var lat4 : Double?
    var long4 : Double?
    
    var addressString : String = ""

    
    var delegate : Address?
    

    @IBOutlet weak var btnAddress : UIButton!

    @IBOutlet weak var imgLocation : UIImageView!
    @IBOutlet weak var imgMarker : UIImageView!

    

     var manager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        delegate?.addressIS(address: <#T##String#>)
        
        imgLocation.image = imgLocation.image?.withRenderingMode(.alwaysTemplate)
        imgLocation.tintColor = #colorLiteral(red: 0.7338325381, green: 0.8205114603, blue: 0.1322879195, alpha: 1)
        
        imgMarker.image = imgMarker.image?.withRenderingMode(.alwaysTemplate)
        imgMarker.tintColor = #colorLiteral(red: 0.7338325381, green: 0.8205114603, blue: 0.1322879195, alpha: 1)
        
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        manager.delegate = self
        
        
        manager.startUpdatingHeading()
        
        view_Cover.isHidden = true
        
        
        gmap.isMyLocationEnabled = true
        
        gmap.isMyLocationEnabled = true
        gmap.settings.compassButton = true
        gmap.delegate = self

        getCoordinateFrom(address: city ?? "Medina") { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            DispatchQueue.main.async {
                
//                guard let lat = self.gmap.myLocation?.coordinate.latitude,
//                    let lng = self.gmap.myLocation?.coordinate.longitude else { return }
                guard let lat = self.gmap.myLocation?.coordinate.latitude,
                    let lng = self.gmap.myLocation?.coordinate.longitude else { return }
                
                let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 30)
                
                self.gmap.animate(to: camera)
//                let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng, zoom: 14)
//                self.gmap.camera = camera
//                self.gmap.
                
               
            }

            
        }

    }
    
    
//    @IBAction func btnChoseAddress(Button : UIButton){
//
//    }
    
   
    
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }

    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let myLocation = locations.last
//        let marker = GMSMarker()
//
//
//        marker.map = gmap

//        let location = locations.last
//
        guard let lat = self.gmap.myLocation?.coordinate.latitude,
            let lng = self.gmap.myLocation?.coordinate.longitude else { return }
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 30)

        self.gmap.animate(to: camera)

        //Finally stop updating location otherwise it will come again and again in this delegate
        self.manager.startUpdatingLocation()
    }

    

    @IBAction func btnCurrentLocation(sender : UIButton){
        guard let lat = self.gmap.myLocation?.coordinate.latitude,
            let lng = self.gmap.myLocation?.coordinate.longitude else { return }
        
        let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: 30)
        self.gmap.animate(to: camera)
    }
    
    
   
  

//    func isWithin(_ point: CLLocationCoordinate2D) -> Bool {
//        let p = GMSMutablePath()
//
////        getCoordinateFrom(address: city!) { coordinate, error in
////            guard let coordinate = coordinate, error == nil else { return }
////            DispatchQueue.main.async {
////
////
////
////            }
////
////
////        }
//
//        p.add(CLLocationCoordinate2D(latitude:25.121924, longitude: 47.224224))
//
//        p.add(CLLocationCoordinate2D(latitude:25.128103, longitude: 46.536538))
//
//        p.add(CLLocationCoordinate2D(latitude:24.410418, longitude: 47.135918))
//        p.add(CLLocationCoordinate2D(latitude:24.509680, longitude: 46.498014))
//
//                        if GMSGeometryContainsLocation(point, p, true) {
//                            print("YES: you are in this polygon.")
//                            self.view_Cover.isHidden = true
//                            self.btnAddress.isEnabled = true
//
//                        } else {
//                            print("You do not appear to be in this polygon.")
//                            self.view_Cover.isHidden = false
//                            self.btnAddress.isEnabled = false
//
//
//                        }
//
//
//        return GMSGeometryContainsLocation(point, p, true)
//
//
//    }
    
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {

//        guard let lat = self.gmap.myLocation?.coordinate.latitude,
//            let lng = self.gmap.myLocation?.coordinate.longitude else { return }
         let coordinate = self.gmap.projection.coordinate(for: self.gmap.center)
//        self.isWithin(CLLocationCoordinate2D(latitude: (coordinate.latitude), longitude: (coordinate.longitude)))

        getAddressFromLatLon(pdblLatitude: String(coordinate.latitude), withLongitude: String(coordinate.longitude))
//        print("aaaaaaaaaaaaa \(addressString)")
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                if placemarks != nil {
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
//                    print(pm.country)
                    print("city ISSS : \(pm.locality)")
//                    print(pm.subLocality)
//                    print(pm.thoroughfare)
//                    print(pm.postalCode)
//                    print(pm.subThoroughfare)
                    
                    if pm.subLocality != nil {
                        self.addressString = self.addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        self.addressString = self.addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        self.addressString = self.addressString + pm.locality! + ", "
                        
                    }
                    if pm.country != nil {
                        self.addressString = self.addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        self.addressString = self.addressString + pm.postalCode! + " "
                    }
                    
//                    print(pm.locality)
//                    if pm.locality != nil {
//                    if self.city!.elementsEqual(pm.locality!) {
//                        print("ooohhhh we goooo")
//                        self.view_Cover.isHidden = true
//                        self.btnAddress.isEnabled = true
//                        self.btnAddress.alpha = 1
//
//                    } else {
//                        self.view_Cover.isHidden = false
//                        self.btnAddress.isEnabled = false
//                        self.btnAddress.alpha = 0.5
//
//                        print("nooooooooo")
//                    }
//
//                    } else {
//                        self.view_Cover.isHidden = false
//                        self.btnAddress.isEnabled = false
//                        self.btnAddress.alpha = 0.5
//
//                    }
                    
                    print("FULL ADDRESS \(self.addressString)")
                    self.delegate?.addressIS(address: self.addressString , city : pm.locality ?? "")

                }
                }
        })
        
    }
    
    @IBAction func btnChoseen(sender : UIButton){
        guard let lat = self.gmap.myLocation?.coordinate.latitude,
            let lng = self.gmap.myLocation?.coordinate.longitude else { return }
//        let coordinate = self.gmap.projection.coordinate(for: self.gmap.center)

//        getAddressFromLatLon(pdblLatitude: String(coordinate.latitude), withLongitude: String(coordinate.longitude))
                getAddressFromLatLon(pdblLatitude: String(lat), withLongitude: String(lng))

        self.dismiss(animated: true, completion: nil)
    }

}
//                if coordinate.latitude == coordinate.latitude && coordinate.longitude == coordinate.longitude{
//
//                    guard let lat = self.gmap.myLocation?.coordinate.latitude,
//                        let lng = self.gmap.myLocation?.coordinate.longitude else { return }
//
//
//                    self.getAddressFromLatLon(pdblLatitude: String(lat), withLongitude: String(lng))
//
//                }else{
//
//
//                }


//                if GMSGeometryContainsLocation(point, p, true) {
//                    print("YES: you are in this polygon.")
//                    self.view_Cover.isHidden = true
//
//                } else {
//                    print("You do not appear to be in this polygon.")
//                    self.view_Cover.isHidden = false
//
//                }
