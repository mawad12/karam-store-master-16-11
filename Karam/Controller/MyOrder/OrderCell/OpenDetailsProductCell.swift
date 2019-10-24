//
//  OpenDetailsProductCell.swift
//  Karam
//
//  Created by ramez adnan on 26/06/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class OpenDetailsProductCell: UITableViewCell {
   
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblQunt: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
//    @IBOutlet weak var lblSpectialRequest: UILabel!
    @IBOutlet weak var lblAdditions: UILabel!
    @IBOutlet weak var img: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
}
