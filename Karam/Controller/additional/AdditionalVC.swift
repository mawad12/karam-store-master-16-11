//
//  AdditionalVC.swift
//  Karam
//
//  Created by ramez adnan on 03/07/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class AdditionalVC: SuperViewController ,UITableViewDelegate,UITableViewDataSource{
    
    var arrayAddition : [AdditionItem] = []
    var AddId:Int?
    
    var isFromprdect = false
    @IBOutlet weak var tableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.registerCell(id: "AdditinalCell")
        
        self.getAddition()
        
        
        
    }
    

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let navigation = self.navigationController as! CustomNavigationBar
        navigation.setTitle("Add Addition", sender: self,Srtingcolor :"AECB1B")
        navigation.setRightButtons([navigation.addBtn!], sender: self)
        navigation.setCustomBackButtonForViewController(sender: self)
        
        self.getAddition()
        
        sideMenuController!.isLeftViewSwipeGestureEnabled = false
        sideMenuController!.isRightViewSwipeGestureEnabled = false
        
        
    }
    
    
    override func didClickRightButton(_sender: UIBarButtonItem) {
        print("add")
        
        let vc:AddAdditionVC = AppDelegate.sb_main.instanceVC()
        vc.addId = AddId!
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func getAddition() {
        
        
        _ = WebRequests.setup(controller: self).prepare(query: "getAdditionByProductId/\(AddId ?? 0))", method: HTTPMethod.get).start(){ (response, error) in
            
            do {
                let Status =  try JSONDecoder().decode(StructAddition.self, from: response.data!)
                self.arrayAddition = Status.items!
                self.tableview.reloadData()
//                self.getAddition()
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }}
        
    }


    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayAddition.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdditinalCell", for: indexPath) as! AdditinalCell
        let item = arrayAddition[indexPath.row]
        cell.lblname.text = item.name
        cell.lblprice.text = item.price

        cell.btnMore.tag = indexPath.row
        cell.btnMore.addTarget(self, action: #selector(self.MoreButton), for: UIControl.Event.touchUpInside)

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
    @objc func MoreButton(sender:UIButton) {

        let alertController = UIAlertController(title: "Product".localized, message: "", preferredStyle: .actionSheet)
        
        
        let editAction = UIAlertAction(title: "Edit".localized, style: .default, handler: { alert -> Void in
            let vc:AddAdditionVC = AppDelegate.sb_main.instanceVC()
            vc.isFrom = true
            let item = self.arrayAddition[sender.tag]

            vc.namear = item.nameAr!
            vc.nameen = item.nameEn!
            vc.price = item.price!
            vc.myID = (item.id)!
            vc.addId = Int(item.productID!)!
            self.navigationController?.pushViewController(vc, animated: true)

            
        })
        
        let deleteAction = UIAlertAction(title: "Delete".localized, style: .destructive, handler: { alert -> Void in
            
            let ProductID = self.arrayAddition[sender.tag].id
            _ = WebRequests.setup(controller: self).prepare(query: "deleteAddition/\(ProductID ?? 0)", method: HTTPMethod.get, isAuthRequired:true).start(){ (response, error) in
                    do {
                        let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                        
                        if !Status.status! {
                            self.showAlert(title: "Error".localized, message:Status.message!)
                            return
                        }else{
                            self.getAddition()
                        }
                    }catch let jsonErr {
                        print("Error serializing  respone json", jsonErr)
                    }
                }
            
            
            
        })
        
        
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: {
            (action : UIAlertAction!) -> Void in })
        
        alertController.addAction(editAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        alertController.preferredAction = editAction
        
        self.present(alertController, animated: true, completion: nil)
        

        
        
        
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
