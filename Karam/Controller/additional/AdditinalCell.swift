//
//  AdditinalCell.swift
//  Karam
//
//  Created by ramez adnan on 03/07/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class AdditinalCell: UITableViewCell {

    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
