//
//  SelectMainCatogrisVC.swift
//  Eshtrakat
//
//  Created by ramez adnan on 18/03/2019.
//  Copyright © 2019 ramez adnan. All rights reserved.
//


import UIKit
protocol SelectTypeFoodDelegate {
    func didcatogorisSelected(ids: [String], names: [String])
    
}
class SelectMainCatogrisVC: UIViewController {
    
    var type:String = ""
    
    var foodArray = [TypeFood]()
    
    var logisticArray = [LogisticCat]()
    
    var selectedCatId: [String] = []
    var selectedCatName: [String] = []

    var delegate: SelectTypeFoodDelegate?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.allowsMultipleSelection = true
        tableView.registerCell(id: "paymentItemCell")
        tableView.registerCell(id: "buttonCell")
        
        lblTitle.text = "Category"
        allCategoris()

       

    }
    
    
    func allCategoris() {
        _ = WebRequests.setup(controller: self).prepare(query: "getLogisticsCategories", method: HTTPMethod.get).start(){ (response, error) in
            do {
                
                let object =  try JSONDecoder().decode(StructLogisticCat.self, from: response.data!)
                self.logisticArray = object.items!
                self.tableView.reloadData()
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }
    
    
    

    
    
    @objc func CategoriesSelected(_ sender: Any){
        if self.selectedCatId.count == 0{
            // self.showAlert(title: "Error".localized, message: Msg.typecarIsRequired())
        }else{
            
            self.delegate?.didcatogorisSelected(ids: self.selectedCatId, names: self.selectedCatName)
            dismiss(animated: true)

        }
    }
    
    
}

extension SelectMainCatogrisVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logisticArray.count + 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == logisticArray.count{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! buttonCell
            cell.btnSave.addTarget(self, action: #selector(CategoriesSelected(_:)), for: .touchUpInside)
            return cell
            
        }
        
        let cell: paymentItemCell = tableView.dequeueTVCell()
        
        let item = logisticArray[indexPath.row]
        
        cell.lbltitle.text = item.name
        
        
        
    
        
        if cell.isSelected || selectedCatId.contains("\(item.id ?? 0)") {
            cell.accessoryType = .checkmark

        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
       guard let cell = tableView.cellForRow(at: indexPath) as? paymentItemCell else { return }
    
       cell.isSelected = true
       cell.accessoryType = .checkmark
   
       let selectedCat = logisticArray[indexPath.row]
   
//        if selectedCatId.contains("\(selectedCat.id ?? 0)") {
//            if let index = selectedCatName.firstIndex(of: selectedCat.name!) {
//                selectedCatId.remove(at: index)
//                selectedCatName.remove(at: index)
//                //selectedCatprice.remove(at: index)
//
//            }
//        } else {
//            if selectedCatId.count == 0{
//                selectedCatId.append("\(selectedCat.id ?? 0)")
//                selectedCatName.append(selectedCat.name!)
//                //selectedCatprice.append(selectedCat.price!)
//
//            }else{
//
//            }
//
//
//        }
   
       selectedCatId.removeAll()
       selectedCatName.removeAll()
       selectedCatId.append("\(selectedCat.id ?? 0)")
    print("selected cat id \(String(describing: selectedCat.id)) ")
       selectedCatName.append(selectedCat.name ?? "")
    print("selected cat name \(String(describing: selectedCat.name))")

       self.tableView.reloadData()
       print(selectedCatName)
       print(selectedCatId)
   
   }

 
    
    
    //func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    //    guard let cell = tableView.cellForRow(at: indexPath) as? paymentItemCell else { return }
    //    cell.isSelected = false
    //    cell.accessoryType = .none
    //    let selectedCat = arrayData[indexPath.row]
    //    if selectedCatId.contains("\(selectedCat.id ?? 0)") {
    //        if let index = selectedCatName.firstIndex(of: selectedCat.name!) {
    //            selectedCatId.remove(at: index)
    //            selectedCatName.remove(at: index)
    //            selectedCatprice.remove(at: index)

    //        }
    //    }
    //    print(selectedCatName)
    //    print(selectedCatId)

    //}
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    
}
