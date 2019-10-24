//
//  AllChatTVC.swift
//  Karam
//
//  Created by musbah on 7/21/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class AllChatTVC: UITableViewCell {

    @IBOutlet weak var imgResturant: UIImageView!
    
    
    @IBOutlet weak var lblRestuarantName: UILabel!
    
    @IBOutlet weak var lblMessage: UILabel!
    
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var RedNotification: UIImageView!
    
    @IBOutlet weak var lblNotificationNumber: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
