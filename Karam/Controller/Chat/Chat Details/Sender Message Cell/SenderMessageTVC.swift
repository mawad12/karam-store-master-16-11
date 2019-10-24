//
//  SenderMessageTVC.swift
//  Karam
//
//  Created by musbah on 7/22/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class SenderMessageTVC: UITableViewCell {
    
    
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var TextView: UIView!
    
    @IBOutlet weak var lblText: UILabel!
    
    
    @IBOutlet weak var imgSender: UIImageView!
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
