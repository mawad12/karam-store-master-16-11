//
//  DayDealsCell.swift
//  Karam
//
//  Created by ramez adnan on 27/06/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class DayDealsCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lbldOldprice: UILabel!
    
    @IBOutlet weak var OldPriceView: UIView!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblDiscont: UILabel!
    @IBOutlet weak var imgCorner: UIImageView!

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lblDiscription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var MoreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblDiscont.rotate(degrees: 45)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
