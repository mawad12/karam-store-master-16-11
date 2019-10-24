//
//  MyMessageCell.swift
//  PT
//
//  Created by musbah on 5/27/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class MyMessageCell: UITableViewCell {


    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblText: UILabel!
    
    @IBOutlet weak var textView: UIView!
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
}
