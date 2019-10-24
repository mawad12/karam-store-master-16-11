//
//  DayDealsVC.swift
//  Karam
//
//  Created by ramez adnan on 27/06/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class DayDealsVC: SuperViewController {
    @IBOutlet weak var tableview: UITableView!
    var arrayDealDay : [DelayMealsData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.registerCell(id: "DayDealsCell")
        getDealDay()
        // Do any additional setup after loading the view. StructDelayMeals
    }
    
    
    func getDealDay() {
        
        
        _ = WebRequests.setup(controller: self).prepare(query: "getAllDealDayForStore", method: HTTPMethod.get).start(){ (response, error) in
            
            do {
                let Status =  try JSONDecoder().decode(StructDelayMeals.self, from: response.data!)
                self.arrayDealDay = Status.items!
                self.tableview.reloadData()
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }}
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let navigation = self.navigationController as! CustomNavigationBar
        
        navigation.setTitle("Deal Day".localized, sender: self,Srtingcolor :"AECB1B")
        navigation.setRightButtons([navigation.addBtn], sender: self)
        navigation.setMeunButton(sender: self)
        navigation.setShadowNavBar()
        
        
        sideMenuController!.isLeftViewSwipeGestureEnabled = true
        sideMenuController!.isRightViewSwipeGestureEnabled = true
        
        
    }
    
    override func didClickRightButton(_sender: UIBarButtonItem) {
        print("add")
        
        let vc:AddDealDayCV = AppDelegate.sb_main.instanceVC()
        
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
extension DayDealsVC: UITableViewDataSource, UITableViewDelegate{
    
    // More Button
    @objc func MoreButton(sender:UIButton) {
        print("more")
        let alertController = UIAlertController(title: "".localized, message: "", preferredStyle: .actionSheet)
        
        let AdditionAction = UIAlertAction(title: "Addition".localized, style: .default, handler: { alert -> Void in
            let vc:AdditionalVC = AppDelegate.sb_main.instanceVC()
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        })
        
        let editAction = UIAlertAction(title: "Edit".localized, style: .default, handler: { alert -> Void in
            let vc:AddDealDayCV = AppDelegate.sb_main.instanceVC()
            let ProductID = self.arrayDealDay[sender.tag]
            
            vc.isFrom = true
            vc.prodect_id = "\(ProductID.id ?? 0)"
            vc.Desar = ProductID.description_ar ?? ""
            vc.Desen = ProductID.description_en ?? ""
            vc.dis = ProductID.discount ?? ""
            vc.Nameen = ProductID.name_en ?? ""
            vc.Namear = ProductID.name_ar ?? ""
            vc.imgs = ProductID.image ?? ""
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        })
        
        let deleteAction = UIAlertAction(title: "Delete".localized, style: .destructive, handler: { alert -> Void in
            
            let ProductID = self.arrayDealDay[sender.tag].id
            _ = WebRequests.setup(controller: self).prepare(query: "deleteDealDay/\(ProductID ?? 0)", method: HTTPMethod.get, isAuthRequired:true).start(){ (response, error) in
                do {
                    let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                    
                    if !Status.status! {
                        self.showAlert(title: "Error".localized, message:Status.message!)
                        return
                    }else{
                        self.getDealDay()
                    }
                }catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
            }
            
            
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
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDealDay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayDealsCell", for: indexPath) as! DayDealsCell
        
        let item = arrayDealDay[indexPath.row]
        
        cell.img.sd_custom(url: item.image!)
        
        cell.lblDate.text = "\(item.dealsDate?.prefix(11) ?? "0" )"
        
        cell.lblName.text = item.name
        
        cell.lblPrice.text = "\(item.price!) " + "SAR".localized
        cell.lbldOldprice.text = "\(item.product!.price!) " + "SAR".localized
        
        cell.lblDiscription.text = item.itemDescription
        
        cell.lblDiscont.text = "\(item.discount!)" + "%".localized
        
        cell.MoreButton.tag = indexPath.row
        cell.MoreButton.addTarget(self, action: #selector(self.MoreButton), for: UIControl.Event.touchUpInside)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let vc:OpenDetailsVC = AppDelegate.sb_main.instanceVC()
        //navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    
}
