//
//  LogicticVC.swift
//  Karam
//
//  Created by ramez adnan on 02/07/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class LogicticVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var arrayOpenOdrer : [LogisticItem] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.registerCell(id: "LogisticCell")
        _ = WebRequests.setup(controller: self).prepare(query: "logistics", method: HTTPMethod.get).start(){ (response, error) in
            do {
                let Status =  try JSONDecoder().decode(LogisticsStruct.self, from: response.data!)
                self.arrayOpenOdrer = Status.items!
                self.tableview.reloadData()
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let navigation = self.navigationController as! CustomNavigationBar
        
        navigation.setTitle("Logistic".localized, sender: self,Srtingcolor :"AECB1B")
        navigation.setMeunButton(sender: self)
        navigation.setShadowNavBar()
        
        
        sideMenuController!.isLeftViewSwipeGestureEnabled = true
        sideMenuController!.isRightViewSwipeGestureEnabled = true
        
        
    }
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOpenOdrer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let obj = self.arrayOpenOdrer[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogisticCell", for: indexPath) as! LogisticCell
        cell.lblName.text = obj.name ?? ""
        cell.img.sd_custom(url: obj.image ?? "")
        cell.lblCatogery.text = obj.category?.title ?? ""
        cell.lblDetails.text = obj.description ?? ""
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc:LogisticsDetailsVC = AppDelegate.sb_main.instanceVC()
        vc.LogisticID = self.arrayOpenOdrer[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
