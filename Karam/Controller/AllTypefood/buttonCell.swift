//
//  buttonCell.swift
//  print4me
//
//  Created by ramez adnan on 02/01/2019.
//  Copyright © 2019 print4me. All rights reserved.
//

import UIKit

class buttonCell: UITableViewCell {
    @IBOutlet weak var btnSave: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnSave.roundCorners(corners: [.topRight,.bottomRight ,], radius: 17)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
