//
//  FQAVC.swift
//  Karam
//
//  Created by musbah on 7/9/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class FQAVC: SuperViewController {
    
    
    @IBOutlet weak var tableview: UITableView!

    
    var FQAarray = [FQAStruct]()
    
    var selctedIndex:Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.registerCell(id: "FQACell")
        self.tableview.rowHeight = UITableView.automaticDimension
        
        getFQA()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let navigation = self.navigationController as! CustomNavigationBar
        navigation.navigationBar.isTranslucent = false
        navigation.navigationBar.setBackgroundImage(UIImage(named: "whiteBar"), for: .default)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let navigation = self.navigationController as! CustomNavigationBar
        navigation.setCustomBackButtonForViewController(sender: self)
        navigation.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigation.navigationBar.shadowImage = UIImage()
        
        sideMenuController?.isLeftViewSwipeGestureEnabled = false
        sideMenuController?.isRightViewSwipeGestureEnabled = false
      
    }

    
    
    
    
    func getFQA(){
        
        _ = WebRequests.setup(controller: self).prepare(query: "faq", method: HTTPMethod.get).start(){ (response, error) in
            do {
                
                let object =  try JSONDecoder().decode(FQAObject.self, from: response.data!)
                
                self.FQAarray = object.items!
               
                self.tableview.reloadData()
                
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
    }

    


}




extension FQAVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FQAarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "FQACell", for: indexPath) as! FQACell
        
        let obj = FQAarray[indexPath.row]
        
        cell.backView.backgroundColor = "FFFFFF".color
        
        cell.lblAnswer.text = obj.answers
        cell.lblQustion.text = obj.questions
        
        if selctedIndex == indexPath.row {
            self.tableview.rowHeight = UITableView.automaticDimension
            cell.backView.backgroundColor = "F7FAE7".color
            cell.lblQustion.textColor = "AECB1B".color
            cell.lblAnswer.isHidden = false
            cell.imgArrow.image = #imageLiteral(resourceName: "UpArrow")
        }else{
            cell.backView.backgroundColor = "FFFFFF".color
            cell.lblQustion.textColor = "000000".color
            cell.imgArrow.image = #imageLiteral(resourceName: "DownArrow")
            cell.lblAnswer.isHidden = true
            self.tableview.rowHeight = UITableView.automaticDimension
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.selctedIndex == indexPath.row{
            self.selctedIndex = indexPath.row
            
        }else{
            
            self.selctedIndex = indexPath.row
            self.tableview.reloadData()
            
        }
        
        
    }
    
    
    
}
