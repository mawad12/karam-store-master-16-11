


//
//  ShowVC.swift
//  Karam
//
//  Created by  Ahmed’s MacBook Pro on 8/18/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit

class ShowVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func bt_show(_ sender: Any) {
        let vc:SignInVC = AppDelegate.sb_main.instanceVC()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

}
