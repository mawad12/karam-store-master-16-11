//
//  NotifcationVC.swift
//  Karam
//
//  Created by ramez adnan on 02/07/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class NotifcationVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableview: UITableView!
    var MyNotificationsArray = [NotificationsItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.registerCell(id: "NotifcationsCell")
        getNotifcation()
    }
    func getNotifcation(){
        
        _ = WebRequests.setup(controller: self).prepare(query: "myNotifications", method: HTTPMethod.get, isAuthRequired:true).start(){ (response, error) in
            do {
                
                let object =  try JSONDecoder().decode(NotificationsStruct.self, from: response.data!)
                
                self.MyNotificationsArray = object.items!
                
                self.tableview.reloadData()
                
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        let navigation = self.navigationController as! CustomNavigationBar
        
        navigation.setTitle("Notifcation".localized, sender: self,Srtingcolor :"AECB1B")
        navigation.setMeunButton(sender: self)
        navigation.setShadowNavBar()
        
        
        sideMenuController!.isLeftViewSwipeGestureEnabled = true
        sideMenuController!.isRightViewSwipeGestureEnabled = true
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyNotificationsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotifcationsCell", for: indexPath) as! NotifcationsCell
        let obj = MyNotificationsArray[indexPath.row]
        cell.lbltitle.text = obj.title ?? ""
        cell.lblName.text = obj.nameUser ?? ""
        cell.lblMessage.text = obj.message ?? ""
        cell.lblDate.text = obj.createdAt?.prefix(10).description ?? ""
        cell.imgNotfi.sd_custom(url: obj.imageUser ?? "" )
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
