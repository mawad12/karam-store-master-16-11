//
//  OrderCell.swift
//  Karam
//
//  Created by ahmed on 6/26/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

    
    @IBOutlet weak var BackgroundContentView: UIView!
    
    
    @IBOutlet weak var lblOrderId: UILabel!

    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblTotal: UILabel!
    
    @IBOutlet weak var lblCustomerName: UILabel!
    
    @IBOutlet weak var lblCustomerMobile: UILabel!
    
    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var lblStuts: UILabel!
    
    @IBOutlet weak var LocationButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
