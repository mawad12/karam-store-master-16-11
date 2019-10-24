//
//  ChatVC.swift
//  Karam
//
//  Created by musbah on 7/21/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import DateToolsSwift

class ChatVC: SuperViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    fileprivate lazy var refreshControl:UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(reloadItems), for: .valueChanged)
        
        return control
    }()
    
    var searchBar = UISearchBar()
    
    var AllChats = [AllChatStruct]()
    var FilterChats = [AllChatStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigation = self.navigationController as! CustomNavigationBar
        navigation.setTitle("Chat".localized, sender: self,Srtingcolor :"AECB1B")
        navigation.setMeunButton(sender: self)
        navigation.setRightButtons([navigation.SearchBtn!], sender: self)
        navigation.setShadowNavBar()
        
        tableView.refreshControl = refreshControl
        tableView.registerCell(id: "AllChatTVC")
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getAllChats(controller: self)
        
    }
    
    
    override func didClickRightButton(_sender: UIBarButtonItem) {
        searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50)
        if #available(iOS 11.0, *) {
            searchBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        }
        searchBar.delegate = self
        searchBar.placeholder = "Restaurant name".localized
        searchBar.showsCancelButton = true
        UISearchBar.appearance().barTintColor = "AECB1B".color
        UISearchBar.appearance().tintColor = "AECB1B".color
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.black
        
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        
        self.navigationItem.rightBarButtonItems = nil
        
        
        self.navigationItem.titleView = searchBar;
        searchBar.becomeFirstResponder()
        
        return
    }
    
    
    func getAllChats(controller: UIViewController?) {
        
        
        _ = WebRequests.setup(controller: controller).prepare(query: "getAllMessage", method: HTTPMethod.get).start(){ (response, error) in
            
            do {
                self.refreshControl.endRefreshing()
                
                let Status =  try JSONDecoder().decode(AllChatObject.self, from: response.data!)
                
                self.AllChats = Status.items!
                self.FilterChats = Status.items!
                self.tableView.reloadData()
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
            
        }
        
    }
    
    
    @objc fileprivate func reloadItems() {
        getAllChats(controller: nil)
        tableView.reloadData()
        
    }
    
}




// Mark: - UI SearchBar
extension ChatVC: UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel search button ")
        let navigation = self.navigationController as! CustomNavigationBar
        //navigation.setLogotitle(sender: self)
        navigation.setTitle("Chat", sender: self,Srtingcolor :"AECB1B")
        
        self.navigationItem.rightBarButtonItems = [navigation.SearchBtn] as? [UIBarButtonItem]
        searchBar.resignFirstResponder()
        
        self.AllChats.removeAll() //clear old data
        getAllChats(controller: self)
        //self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let string = searchBar.text
        
        if let keyword = string?.replacingOccurrences(of: " ", with: " "){
            print(keyword)
            
            
            self.AllChats = self.FilterChats.filter{ $0.userName!.contains(keyword) }
            self.tableView.reloadData()
            print(self.AllChats)
            //getRestaurantsByName(parameters: parameters)
            
        }
        
        self.view.endEditing(true)
        
        let navigation = self.navigationController as! CustomNavigationBar
        navigation.setTitle("Restaurants", sender: self,Srtingcolor :"AECB1B")
        self.navigationItem.rightBarButtonItems = [navigation.SearchBtn] as? [UIBarButtonItem]
        searchBar.resignFirstResponder()
        
    }
    
}







// Mark: - UI TableView
extension ChatVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllChats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllChatTVC", for: indexPath) as! AllChatTVC
        
        let obj = AllChats[indexPath.row]
        
        cell.imgResturant.sd_custom(url: obj.userImage ?? "")
        cell.lblRestuarantName.text = obj.userName
        cell.lblMessage.text = obj.lastMessage
        
//        let dateFormatter = DateFormatter()
//        //2019-07-20 22:38:20
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let date = dateFormatter.date(from: obj.createdAt!)
//        print(date as Any)
        
        cell.lblTime.text = obj.createdAt
        cell.RedNotification.isHidden = true
        cell.lblNotificationNumber.text = ""
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:ChatDetailsVC = AppDelegate.sb_main.instanceVC()
        vc.chatUserID = Int(AllChats[indexPath.row].user1!)
        vc.chatUserName = AllChats[indexPath.row].userName
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
   
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let obj = AllChats[indexPath.row]
        
        let DeleteAction =  UIContextualAction(style: .normal, title: "", handler: { (action,view,completionHandler ) in
            
            let alert = UIAlertController(title: "Delelet".localized, message: "Are you sure you want to Delete".localized, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok".localized, style: .default, handler: { (UIAlertAction) in
                CurrentUser.userInfo = nil
                
                
                _ = WebRequests.setup(controller: self).prepare(query: "deleteChat/\(obj.user1!)", method: HTTPMethod.get).start(){ (response, error) in
                    
                    do {
                        
                        let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                        
                        if Status.status!{
                            
                            self.AllChats.remove(at: indexPath.row)
                            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                            self.tableView.reloadData()
                            //self.showAlert(title: "Success".localized, message:Status.message!)
                        }else{
                            self.showAlert(title: "Error".localized, message:Status.message!)
                            return
                        }
                        
                    } catch let jsonErr {
                        print("Error serializing  respone json", jsonErr)
                    }
                    
                }
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel))
            self.present(alert, animated: true, completion: nil)
            
            completionHandler(true)
        })
        
        DeleteAction.backgroundColor = "AECB1B".color
        DeleteAction.image = UIImage(named: "GreenTrash")
        
        let confrigation = UISwipeActionsConfiguration(actions: [DeleteAction])
        confrigation.performsFirstActionWithFullSwipe = true // default is false
        
        return confrigation
    }
}
