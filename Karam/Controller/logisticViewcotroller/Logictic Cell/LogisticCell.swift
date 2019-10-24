//
//  LogisticCell.swift
//  Karam
//
//  Created by ramez adnan on 02/07/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class LogisticCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblCatogery: UILabel!
    @IBOutlet weak var lblDetails: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
