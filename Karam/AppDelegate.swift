//
//  AppDelegate.swift
//  Karam
//
//  Created by musbah on 5/13/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces
import FirebaseMessaging
import UserNotifications
import Firebase
import BRYXBanner
import PlacesPicker


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MOLHResetable {

    var window: UIWindow?
    static let sb_main = UIStoryboard.init(name: "Main", bundle: nil)
    let gcmMessageIDKey = "gcm.message_id"

    func reset() {
        guard let window = UIApplication.shared.keyWindow else { return }
        let vc : SplashVC = AppDelegate.sb_main.instanceVC()
        window.rootViewController = vc
    }


    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = .white
        IQKeyboardManager.shared.placeholderColor = .white
        IQKeyboardManager.shared.toolbarBarTintColor = "AECB1B".color
        
        IQKeyboardManager.shared.shouldToolbarUsesTextFieldTintColor = false
        PlacePicker.configure(googleMapsAPIKey: "AIzaSyC1xTzuJMYp8F4Vs9dxiJZg3iAJkaEwipM",
                              placesAPIKey: "AIzaSyC1xTzuJMYp8F4Vs9dxiJZg3iAJkaEwipM")
        

        
//        GMSServices.provideAPIKey("AIzaSyC1xTzuJMYp8F4Vs9dxiJZg3iAJkaEwipM")
//        GMSPlacesClient.provideAPIKey("AIzaSyC1xTzuJMYp8F4Vs9dxiJZg3iAJkaEwipM")
        
        MOLH.shared.activate(true)
        
        
        
        Messaging.messaging().subscribe(toTopic: "kram")
        configureNotifications(application)

        return true
    }
    private func configureNotifications(_ application: UIApplication){
        Messaging.messaging().delegate = self
        Messaging.messaging().subscribe(toTopic:"kram")
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    //    func userNotificationCenter(_ center: UNUserNotificationCenter,
    //                                willPresent notification: UNNotification,
    //                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    //        let userInfo = notification.request.content.userInfo
    //
    //        // With swizzling disabled you must let Messaging know about the message, for Analytics
    //        // Messaging.messaging().appDidReceiveMessage(userInfo)
    //        // Print message ID.
    //        if let messageID = userInfo[gcmMessageIDKey] {
    //            print("Message ID: \(messageID)")
    //        }
    //
    //        // Print full message.
    //        print(userInfo)
    //
    //        // Change this to your preferred presentation option
    //        completionHandler([])
    //    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let fullInfo = userInfo as? [String:Any] {
            let _TypeId = fullInfo["type"] as? String ?? ""
            
            if let aps = fullInfo["aps"] as? [String:Any] {
                if let alert = aps["alert"] as? [String:Any] {
                    
                    let body = alert["body"] as? String ?? ""
                    let _title = alert["title"] as? String ?? ""
                    let _object = alert["object"] as? String ?? ""
                    let typeMsg = alert["typeMsg"] as? Int ?? 0

                    
                }
            }
        }
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        let userInfo = notification.request.content.userInfo
        let state = UIApplication.shared.applicationState
        
        if let userId = userInfo["gcm.notification.order_id"] {
            print("User Id: \(userId)")
            let msggId = userId as? String
            let msId = Int(msggId!)
            
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTheTable"), object: msId)
        }
        
        if state == .active {
            print(userInfo)
            if let aps = userInfo["aps"] as? [String:Any] {
                if let alert = aps["alert"] as? [String:Any] {
                    let body = alert["body"] as? String ?? ""
                    let title = alert["title"] as? String ?? ""
                    let typeMsg = alert["typeMsg"] as? Int ?? 0
                    NotificationCenter.default.post(name: Notification.Name("ReceiveData"), object: nil)
                    let orderId = userInfo["gcm.notification.order_id"] as? String ?? ""
                    
                    let code = userInfo["gcm.notification.code"] as? String ?? ""
                    let banner = Banner(title: title, subtitle: body, image: nil, backgroundColor: "3D3D3D".color)
                    banner.dismissesOnSwipe = true
                    banner.show(duration: 3.0)
                    banner.didTapBlock = {
                        
                        if let messageType = userInfo["gcm.notification.typeMsg"] {
                            print("Message typeee: \(messageType)")
                            let msgg = messageType as? String
                            let ms = Int(msgg!)
                            
                        if ms == 1 {
//                            let story = UIStoryboard(name: "Main", bundle: nil)
//                            let vc = story.instantiateViewController(withIdentifier: "ChatVC")
////                            story.pre
//                            UIApplication.shared.keyWindow?.rootViewController = vc
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showController"), object: nil)

                        }else if ms == 2 {
                            let story = UIStoryboard(name: "Main", bundle: nil)
                            let vc = story.instantiateViewController(withIdentifier: "MainVC")
                            UIApplication.shared.keyWindow?.rootViewController = vc

                            
                        } else {
                            print("nooo")
                        }
                            
                        }
                        //                        Push To Viewcontroller
                    }
                }
            }
        }
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        print(userInfo)
        
        let orderId = userInfo["gcm.notification.order_id"] as? String ?? ""
        NotificationCenter.default.post(name: Notification.Name("ReceiveData"), object: nil)

        let code = userInfo["gcm.notification.code"] as? String ?? ""
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
            NotificationCenter.default.post(name: Notification.Name("ReceiveData"), object: nil)

        }
        
        // Print full message.
        print(userInfo)
        
        completionHandler()
    }
}
// [END ios_10_message_handling]



extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        Helper.device_token = fcmToken
        print("Firebase registration token2: \(Helper.device_token)")

        if Helper.user_token != "" {
            NotificationCenter.default.post(name: Notification.Name("ReceiveData"), object: nil)
             Helper.user_token = fcmToken
        }
        //        let dataDict:[String: String] = ["token": fcmToken]
        //        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
        NotificationCenter.default.post(name: Notification.Name("ReceiveData"), object: nil)
    }
    // [END ios_10_data_message]
    
    
}
