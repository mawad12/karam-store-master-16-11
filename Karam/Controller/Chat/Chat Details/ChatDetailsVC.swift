//
//  ChatDetailsVC.swift
//  Karam
//
//  Created by musbah on 7/21/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class ChatDetailsVC: SuperViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var lblResturantName: UILabel!
    
    
    @IBOutlet weak var MessageTF: UITextField!
    
    @IBOutlet weak var viewOldMessage: UIView!

    fileprivate lazy var refreshControl:UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(reloadItems), for: .valueChanged)
        
        return control
    }()
    
    var AllChats = [AllChatStruct]()
    
    var AllMessages = [MessagesStruct]()
    
    
    //var chatObject:AllChatStruct?
    
    var chatUserID:Int?
    var chatUserName:String?
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          NotificationCenter.default.addObserver(self, selector: #selector(self.reloadTable), name: NSNotification.Name(rawValue: "reloadTheTable"), object: nil)
        
        self.hideIndicator()
        let navigation = self.navigationController as! CustomNavigationBar
        navigation.setTitle("Chat", sender: self,Srtingcolor :"AECB1B")
        navigation.setCustomBackButtonForViewController(sender: self)
        navigation.HideBottomBorder()
        
        sideMenuController?.isLeftViewSwipeGestureEnabled = false
        sideMenuController?.isRightViewSwipeGestureEnabled = false
        
        
        tableView.registerCell(id: "MyMessageCell")
        tableView.registerCell(id: "SenderMessageTVC")
        
        collectionView.registerCell(id: "AllChatCVC")
        
        
        
        
        getAllChats()
        getAllMessages()
    }
    
    @objc func reloadTable(_ notification:NSNotification) {
        print("reload table")
        
        if  let user_id =  notification.object as? Int {
            print("uss id \(user_id)")
        }
        
        if let ID = chatUserID {
            
            print("this id \(ID)")
            _ = WebRequests.setup(controller: self).prepare(query: "getChatMessage/\(ID)", method: HTTPMethod.get).startWithoutIndicator(){ (response, error) in
                
                do {
                    let Status =  try JSONDecoder().decode(MessagesObject.self, from: response.data!)
                    
                    if let items = Status.items {
                        
                        self.AllMessages = items
                    }
                    self.lblResturantName.text = self.chatUserName
                    
                    self.tableView.reloadData()
                    
                    DispatchQueue.main.async {
                        self.tableView.scrollToBottom()
                    }
                    
                    
                } catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
                
            }
            
        }
    }
    
    
    func getAllChats() {
        
        
        _ = WebRequests.setup(controller: self).prepare(query: "getAllMessage", method: HTTPMethod.get).start(){ (response, error) in
            
            do {
                let Status =  try JSONDecoder().decode(AllChatObject.self, from: response.data!)
                
                self.AllChats = Status.items!
                self.collectionView.reloadData()
                self.tableView.reloadData()
            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
            
        }
        
    }
    
    @objc fileprivate func reloadItems() {
        getAllMessages()
        tableView.reloadData()
        
    }
    
    func getAllMessages() {
        self.hideIndicator()
        if let ID = chatUserID {
            
            _ = WebRequests.setup(controller: self).prepare(query: "getChatMessage/\(ID)", method: HTTPMethod.get).start(){ (response, error) in
                self.hideIndicator()
                do {
                    self.hideIndicator()
                    let Status =  try JSONDecoder().decode(MessagesObject.self, from: response.data!)
                    
                    
                    self.AllMessages = Status.items!
                    
                    self.lblResturantName.text = self.chatUserName
                    
                    self.tableView.reloadData()
                    
                    print("Count message is : \(self.AllMessages.count)")
                    if self.AllMessages.count == 0 {

                        self.hideIndicator()
                        self.viewOldMessage.isHidden = false
                        self.tableView.isHidden = true
                    }else{
                        self.hideIndicator()
                        self.viewOldMessage.isHidden = true
                        self.tableView.isHidden = false
                    }
                    
                    
                    DispatchQueue.main.async {
                        self.tableView.scrollToBottom()
                    }
                    
                } catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
                
            }
            
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        let img = image
        //let imgData = (image.jpegData(compressionQuality: 0.1))!
        
        
        guard let userID = chatUserID else{
            self.showAlert(title: "Error".localized, message: "User ID Can't be Empty".localized)
            return
        }
        
        var parameters: [String: String] = [:]
        
        parameters["user"] = userID.description
        parameters["type"] = "1"
        
//        self.showIndicator()
        _ = WebRequests.sendPostMultipartRequestWithImgParam(url: "http://kram.b1-store.com/api/sendMessage", parameters:parameters, img: img, withName: "image", completion: {(response, error) in
//            self.hideIndicator()
            do {
                let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                if !Status.status! {
                    
                    self.showAlert(title: "Error".localized, message:Status.message!)
                    return
                }else{
                    self.MessageTF.text = ""
                    self.getAllMessages()
                    self.tableView.reloadData()
                }
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        })
        
        
        
    }
    
    
    
    
    @IBAction func TakePhotoButton(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        self.present(vc, animated: true)
        
    }
    
    
    
    @IBAction func selectPhotoButton(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        self.present(vc, animated: true)
        
    }
    
    
    
    @IBAction func SendButton(_ sender: Any) {
        self.hideIndicator()
        guard let messageText = self.MessageTF.text, !messageText.isEmpty else{
            self.showAlert(title: "Error".localized, message: "message Can't be Empty".localized)
            return
        }
        
        guard let userID = chatUserID else{
            self.showAlert(title: "Error".localized, message: "User ID Can't be Empty".localized)
            return
        }
        
        var parameters: [String: Any] = [:]
        
        parameters["user"] = userID
        parameters["type"] = "0"
        parameters["message"] = messageText
        self.hideIndicator()
        _ = WebRequests.setup(controller: self).prepare(query: "sendMessage", method: HTTPMethod.post, parameters: parameters).start(){ (response, error) in
            self.hideIndicator()
            do {
                self.hideIndicator()
                let Status =  try JSONDecoder().decode(StatusStruct.self, from: response.data!)
                if !Status.status! {
                    
                    self.showAlert(title: "Error".localized, message:Status.message!)
                    return
                }else{
                    self.MessageTF.text = ""
                    self.getAllMessages()
//                    self.tableView.reloadData()
                    self.hideIndicator()
                }
                
            }catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
            
        }
        
        
    }
    
    
    
}



extension ChatDetailsVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AllChats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllChatCVC", for: indexPath) as! AllChatCVC
        
        
        let obj = AllChats[indexPath.row]
        
        cell.imgResturant.sd_custom(url: obj.userImage ?? "")
        cell.REDNotification.isHidden = true
        self.hideIndicator()
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: 40 , height: 65)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.hideIndicator()
        self.chatUserID = Int(AllChats[indexPath.row].user1!)
        self.getAllMessages()
    }
    
}






extension ChatDetailsVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let obj = AllMessages[indexPath.row]
        
        
        if obj.senderID == CurrentUser.userInfo?.id?.description{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyMessageCell", for: indexPath) as! MyMessageCell
            
            
            if obj.type == "1" {
                cell.textView.isHidden = true
                cell.imgView.isHidden = false
                
                cell.imgView.sd_custom(url: obj.message ?? "")
            }else{
                cell.lblText.text = obj.message ?? MessageTF.text
                cell.textView.isHidden = false
                cell.imgView.isHidden = true
            }
            
            
            cell.lblDate.text = obj.createdAt
            
            return cell
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SenderMessageTVC", for: indexPath) as! SenderMessageTVC
            
            if obj.type == "1" {
                cell.TextView.isHidden = true
                cell.imgView.isHidden = false
                cell.imgView.sd_custom(url: obj.message ?? "")
                
            }else{
                cell.lblText.text = obj.message
                cell.imgView.isHidden = true
                cell.TextView.isHidden = false
            }
            
            cell.lblDate.text = obj.createdAt
            cell.imgSender.sd_custom(url: obj.userImage ?? "")
            
            
            return cell
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    
}
