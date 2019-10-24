//
//  InfoTVC.swift
//  Karam
//
//  Created by musbah on 6/19/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class InfoTVC: UITableViewCell {

    @IBOutlet weak var lblDescription: UILabel!
    
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var LoactionButton: UIButton!
    
    
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var PhoneButton: UIButton!
   
    
    @IBOutlet weak var lblMail: UILabel!
    
    @IBOutlet weak var MailButton: UIButton!
    
    
    @IBOutlet weak var lblFrom: UILabel!
    
    @IBOutlet weak var lblTo: UILabel!
    
    
    @IBOutlet weak var lblDelivaryMethode: UILabel!
    
    
    @IBOutlet weak var lblPaymentMethode: UILabel!
    
    @IBOutlet weak var imgCheck: UIImageView!
    
    
    @IBOutlet weak var facebookAction: UIButton!
    
    @IBOutlet weak var instagramAction: UIButton!
    
    @IBOutlet weak var TwitterAction: UIButton!
    
    var imgArray = [ProductItemStruct]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var controller:SuperViewController?
    
    var RestaurantID:Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.registerCell(id: "MostCellerCVC")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    
    // Get Most Celler
    func getMostCeller(){
        if let id = RestaurantID{
            _ = WebRequests.setup(controller: nil).prepare(query: "mostSaler/\(id)", method: HTTPMethod.get).start(){ (response, error) in
                do {
                    
                    let object =  try JSONDecoder().decode(ProductsCategoryObject.self, from: response.data!)
                    
                    self.imgArray = object.items!
                    self.collectionView.reloadData()
                    
                } catch let jsonErr {
                    print("Error serializing  respone json", jsonErr)
                }
            }
        }
    }
    
    
}


extension InfoTVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MostCellerCVC", for: indexPath) as! MostCellerCVC
        
        if let img = imgArray[indexPath.row].coverImage{
            cell.cellerImage.sd_custom(url: img)
        }
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc:ProductDetailsVC = AppDelegate.sb_main.instanceVC()
//        vc.productID = imgArray[indexPath.row].id
        self.controller?.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
}
