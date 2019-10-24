//
//  Helper.swift
//  HanDIYman
//
//  Created by Ahmad on 1/21/18.
//  Copyright © 2018 Ahmad. All rights reserved.
//

import UIKit
import SystemConfiguration
import AVFoundation
import ARSLineProgress
import Alamofire

class Helper: NSObject {
    
    //MARK: Check Internet Connection
    class func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    
    static func getName() -> String {
        let dateFormatter = DateFormatter()
        let dateFormat = "yyyyMMddHHmmss"
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.string(from: Date())
        let name = date.appending(".mp4")
        return name
    }
    
    static var terms_of_use:String{
        get{
            return UserDefaults.standard.object(forKey: "terms_of_use") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "terms_of_use")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var privacy_policy:String{
        get{
            return UserDefaults.standard.object(forKey: "privacy_policy") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "privacy_policy")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    
    static var about_us:String{
        get{
            return UserDefaults.standard.object(forKey: "about_us") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "about_us")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    
    
    static var user_token:String{
        get{
            return UserDefaults.standard.object(forKey: "user_token") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "user_token")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var isNotificationsEnabled:Bool{
        get{
            return UserDefaults.standard.object(forKey: "NotificationsEnabled") as? Bool ?? true
        }set{
            UserDefaults.standard.set(newValue, forKey: "NotificationsEnabled")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var device_token:String{
        get{
            return UserDefaults.standard.object(forKey: "device_token") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "device_token")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var member_ship:String{
        get{
            return UserDefaults.standard.object(forKey: "member_ship") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "member_ship")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    class func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
    // Add Video To View
    func addVideoPlayer(videoUrl: URL, to view: UIView) {
        let player = AVPlayer(url: videoUrl)
        let layer: AVPlayerLayer = AVPlayerLayer(player: player)
        
        layer.backgroundColor = UIColor.black.cgColor
        layer.frame = view.bounds
        layer.videoGravity = .resizeAspect
        view.layer.sublayers?
            .filter { $0 is AVPlayerLayer }
            .forEach { $0.removeFromSuperlayer() }
        view.layer.addSublayer(layer)
        //player.play()
        //player.isMuted = true
    }
    
    
    //MARK: Create group Chat Id
    static func createChatGroupId(userId:String,userId2:String) -> String {
        var chatRoomId = ""
        let comparison = userId.compare(userId2).rawValue
        
        if comparison < 0 {
            chatRoomId =  userId + "_" + userId2
        } else {
            chatRoomId = userId2 + "_" + userId
        }
        return chatRoomId
    }
    
    class func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    static func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    
    
    
    class func showIndicator(view: UIView)->Void{
        if !ARSLineProgress.shown{
            ARSLineProgress.show()
            view.isUserInteractionEnabled = false
        }
    }
    
    class func hideIndicator(view: UIView)->Void{
        ARSLineProgress.hide()
        view.isUserInteractionEnabled = true
    }
    
    class func hideIndicatorWithSuccess(view: UIView)->Void{
        ARSLineProgress.showSuccess()
        view.isUserInteractionEnabled = true
    }
    
    class func hideIndicatorWithFail(view: UIView)->Void{
        ARSLineProgress.showFail()
        view.isUserInteractionEnabled = true
    }
    
    //    static func go_home(_ window: UIWindow){
    //        let vc = AppDelegate.sb_main.instantiateViewController(withIdentifier: "MainVC")
    //        let nav = UINavigationController.init(rootViewController: vc)
    //        window.rootViewController = nav
    //    }
    //
    //    static func set_Root(_ window: UIWindow, iden: String){
    //        let vc = AppDelegate.sb_main.instantiateViewController(withIdentifier: iden)
    //        let nav = UINavigationController.init(rootViewController: vc)
    //        window.rootViewController = nav
    //    }
    //
    //    static func saveUserData(usr: UserStruct){
    //
    //        Helper.save_user_id             = usr.id
    //        Helper.save_user_name           = usr.name
    //        Helper.save_user_email          = usr.email
    //        Helper.save_user_image          = usr.profile_image
    //        Helper.save_user_mobile         = usr.mobile
    //        Helper.user_token               = usr.access_token
    //        Helper.save_user_city_name      = usr.location
    //        Helper.is_driver                = usr.admin
    //        Helper.save_longitude           = usr.lan
    //        Helper.save_latitude            = usr.lat
    //    }
    //
    //
    
    static var save_gym_points:Int{
        get{
            return UserDefaults.standard.object(forKey: "gym_points") as? Int ?? 0
        }set{
            UserDefaults.standard.set(newValue, forKey: "gym_points")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var save_supplement_points:Int{
        get{
            return UserDefaults.standard.object(forKey: "supplement_points") as? Int ?? 0
        }set{
            UserDefaults.standard.set(newValue, forKey: "supplement_points")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var save_restaurant_points:Int{
        get{
            return UserDefaults.standard.object(forKey: "restaurant_points") as? Int ?? 0
        }set{
            UserDefaults.standard.set(newValue, forKey: "restaurant_points")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    static var save_user_id:Int{
        get{
            return UserDefaults.standard.object(forKey: "user_id") as? Int ?? 0
        }set{
            UserDefaults.standard.set(newValue, forKey: "user_id")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var save_default_address:Int{
        get{
            return UserDefaults.standard.object(forKey: "default_address") as? Int ?? 0
        }set{
            UserDefaults.standard.set(newValue, forKey: "default_address")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var cart_type:String{
        get{
            return UserDefaults.standard.object(forKey: "cart_type") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "cart_type")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var save_user_gender:String{
        get{
            return UserDefaults.standard.object(forKey: "user_gender") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "user_gender")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    static var save_user_area:String{
        get{
            return UserDefaults.standard.object(forKey: "user_area") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "user_area")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var save_user_principal:String{
        get{
            return UserDefaults.standard.object(forKey: "user_principal") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "user_principal")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var save_user_name:String{
        get{
            return UserDefaults.standard.object(forKey: "user_name") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "user_name")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var save_school_type:String{
        get{
            return UserDefaults.standard.object(forKey: "school_type") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "school_type")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var save_guidance:String{
        get{
            return UserDefaults.standard.object(forKey: "user_guidance") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "user_guidance")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    static var save_user_email:String{
        get{
            return UserDefaults.standard.object(forKey: "user_email") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "user_email")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    static var save_user_mobile:String{
        get{
            return UserDefaults.standard.object(forKey: "user_mobile") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "user_mobile")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    static var save_user_type:String {
        get{
            return UserDefaults.standard.object(forKey: "user_type") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "user_type")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    static var save_user_image:String{
        get{
            return UserDefaults.standard.object(forKey: "user_image") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "user_image")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    static var save_user_city: Int{
        get{
            return UserDefaults.standard.object(forKey: "save_user_city") as? Int ?? -1
        }set{
            UserDefaults.standard.set(newValue, forKey: "save_user_city")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var save_main_id_cart: Int{
        get{
            return UserDefaults.standard.object(forKey: "main_id_cart") as? Int ?? -1
        }set{
            UserDefaults.standard.set(newValue, forKey: "main_id_cart")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var save_user_city_name: String{
        get{
            return UserDefaults.standard.object(forKey: "user_city_name") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "user_city_name")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var save_user_currency: String{
        get{
            return UserDefaults.standard.object(forKey: "currency_iso") as? String ?? "KWD"
        }set{
            UserDefaults.standard.set(newValue, forKey: "currency_iso")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var save_notification_count: String{
        get{
            return UserDefaults.standard.object(forKey: "save_notification_count") as? String ?? "KWD"
        }set{
            UserDefaults.standard.set(newValue, forKey: "save_notification_count")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var save_user_country_logo: String{
        get{
            return UserDefaults.standard.object(forKey: "user_country_logo") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "user_country_logo")
            UserDefaults.standard.synchronize()
        }
    }
    
    static func isValidJson(text: String) -> Bool{
        if let data = text.data(using: .utf8) {
            do {
                let data =  try JSONSerialization.jsonObject(with: data, options: [])
                //print("JSONSerializationJSONSerializationJSONSerialization")
                print(data)
                return true
            } catch {
                print(error.localizedDescription)
            }
        }
        return false
    }
    
    static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth,height: newHeight))
        image.draw(in: CGRect(x: 0,y: 0,width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    static func getLocationImageURL(lat: Double, long: Double) -> String{
        let fromLocation = "\(lat), \(long)"
        let url = "https://maps.googleapis.com/maps/api/staticmap?center=\(fromLocation)&zoom=18&size=800x410&markers=color:red|\(fromLocation)"
        return url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    
    static func openURL(urlStr: String){
        if let url = URL(string : urlStr){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options:  [:], completionHandler: { (status) in
                    if status {
                        print("fooo/ success")
                    }
                })
            } else {
                
                // Fallback on earlier versions
            }
        }
    }
    
    
    
    static var app_mobile:String{
        get{
            return UserDefaults.standard.object(forKey: "app_mobile") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "app_mobile")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var app_phone:String{
        get{
            return UserDefaults.standard.object(forKey: "app_phone") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "app_phone")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    static var app_email:String{
        get{
            return UserDefaults.standard.object(forKey: "app_email") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "app_email")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    static var app_website:String{
        get{
            return UserDefaults.standard.object(forKey: "app_website") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "app_website")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var is_driver:String{
        get{
            return UserDefaults.standard.object(forKey: "is_driver") as? String ?? "0"
        }set{
            UserDefaults.standard.set(newValue, forKey: "is_driver")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    static var join_description:String{
        get{
            return UserDefaults.standard.object(forKey: "join_description") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "join_description")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    static var join_url:String{
        get{
            return UserDefaults.standard.object(forKey: "join_url") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "join_url")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var twitter_url:String{
        get{
            return UserDefaults.standard.object(forKey: "twitter_url") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "twitter_url")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    static var facebook_url:String{
        get{
            return UserDefaults.standard.object(forKey: "facebook_url") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "facebook_url")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    static var instagram_url:String{
        get{
            return UserDefaults.standard.object(forKey: "instagram_url") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "instagram_url")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var save_latitude:String{
        get{
            return UserDefaults.standard.object(forKey: "save_latitude") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "save_latitude")
            UserDefaults.standard.synchronize()
        }
    }
    
    static var save_longitude:String{
        get{
            return UserDefaults.standard.object(forKey: "save_longitude") as? String ?? ""
        }set{
            UserDefaults.standard.set(newValue, forKey: "save_longitude")
            UserDefaults.standard.synchronize()
        }
    }
}





// Helper function inserted by Swift 4.2 migrator.
//fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
//    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
//}
