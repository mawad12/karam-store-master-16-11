//
//  AdditionsCell.swift
//  Karam
//
//  Created by ibrahim eljabaly on 10/3/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class AdditionsCell: UITableViewCell {

    @IBOutlet weak var lblNameText : UILabel!
    @IBOutlet weak var lblCountText : UILabel!
    @IBOutlet weak var lblPriceText : UILabel!
    @IBOutlet weak var lblSpectialRequestText : UILabel!

    
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblCount : UILabel!
    @IBOutlet weak var lblPrice : UILabel!
    @IBOutlet weak var lblSpectialRequest : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        lblNameText.text = "Name :".localized
        lblCountText.text = "| Count :".localized
        lblPriceText.text = "| Price :".localized
        lblSpectialRequestText.text = "Spectial Request :".localized

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
