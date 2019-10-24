//
//  FQACell.swift
//  Karam
//
//  Created by musbah on 7/10/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class FQACell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var imgArrow: UIImageView!
    
    @IBOutlet weak var lblQustion: UILabel!
    
    @IBOutlet weak var lblAnswer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
