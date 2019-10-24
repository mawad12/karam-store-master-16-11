//
//  ProductTVC.swift
//  Karam
//
//  Created by musbah on 6/19/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class ProductTVC: UITableViewCell {

    
    @IBOutlet weak var imgProduct: UIImageView!
    
    @IBOutlet weak var lblOldPrice: UILabel!
    
    @IBOutlet weak var lblNewPrice: UILabel!
    
    @IBOutlet weak var OldPriceView: UIView!

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var lblProductsDescrpiton: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblDiscount: UILabel!

    @IBOutlet weak var imgCorner: UIImageView!
    
    @IBOutlet weak var MoreButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if MOLHLanguage.isArabic(){
            let flippedImage = UIImage(named: "ConerImage")?.imageFlippedForRightToLeftLayoutDirection()
            self.imgCorner.image = flippedImage
        } else {
            let flippedImage = UIImage(named: "ConerImage")
            self.imgCorner.image = flippedImage
        }
        
        
        lblDiscount.rotate(degrees: 45)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
