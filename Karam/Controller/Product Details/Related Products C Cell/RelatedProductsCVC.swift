//
//  RelatedProductsCVC.swift
//  Karam
//
//  Created by musbah on 6/30/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class RelatedProductsCVC: UICollectionViewCell {

    
    @IBOutlet weak var lblDiscount: UILabel!
    
    @IBOutlet weak var imgProduct: UIImageView!
    
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var lblProductPrice: UILabel!
    
    @IBOutlet weak var imgCorner: UIImageView!
    
    
    override func awakeFromNib() {
        lblDiscount.rotate(degrees: -45)
 super.awakeFromNib()
        // Initialization code
    }

}
