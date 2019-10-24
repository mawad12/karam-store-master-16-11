//
//  ProductDetailsVC.swift
//  Karam
//
//  Created by ahmed on 6/25/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import MXSegmentedControl

class ProductDetailsVC: SuperViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var segmentController: MXSegmentedControl!
    @IBOutlet weak var tableview: UITableView!
    var CategoryArray = [AllCategoryStruct]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegment()
        tableview.registerCell(id: "ProductTVC")

        // Do any additional setup after loading the view.
    }
    
    


    func setupSegment(){
        
        segmentController.append(title: "All")
        segmentController.append(title: "breckfast")
        segmentController.append(title: "lansche")
        segmentController.append(title: "sweet")
        segmentController.append(title: "cokcakola")
        segmentController.append(title: "dinar")
        
        // segmentController.font = UIFont(name: "TheSans-Plain", size: 13)!
        //        segmentController.select(index: 2, animated: true)
        segmentController.selectedTextColor = .black
        segmentController.textColor = "7F7F7F".color
        
        segmentController.addTarget(self, action: #selector(self.didSegmentChanged(_:)), for: .valueChanged)
    }
    
    
    @objc func didSegmentChanged(_ sender: MXSegmentedControl){
        
    }
    override func viewWillAppear(_ animated: Bool) {
        let navigation = self.navigationController as! CustomNavigationBar
        
        navigation.setTitle("Prodect", sender: self,Srtingcolor :"AECB1B")
        navigation.setMeunButton(sender: self)
        navigation.setShadowNavBar()
        
        navigation.setRightButtons([navigation.addBtn], sender: self)
        sideMenuController!.isLeftViewSwipeGestureEnabled = true
        sideMenuController!.isRightViewSwipeGestureEnabled = true
        
        
    }
    override func didClickRightButton(_sender: UIBarButtonItem) {
        print("add")
        
        let vc:AddProdectVC = AppDelegate.sb_main.instanceVC()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTVC", for: indexPath) as! ProductTVC
      
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc:ProductDetails2VC = AppDelegate.sb_main.instanceVC()
        navigationController?.pushViewController(vc, animated: true)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
