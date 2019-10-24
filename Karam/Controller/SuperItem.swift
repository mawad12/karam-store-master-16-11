
//
//  SuperItem.swift
//  Karam
//
//  Created by ahmed on 6/25/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import Alamofire

//protocol  superItemDataSource : NSObjectProtocol {
//
////    func ItemSetupNavigation(viewPager: SuperItem)
//    func ItemSetupNavigation(view: SuperItem, prepareNavigationBar: CustomNavigationBar)
//
//}
class SuperItem :NSObject  {
    
    var viewController: SuperViewController!
    var withIdentifierCell: [String]!
    var tableView: UITableView!
    var countItem = 0
    var RequestUrl = ""
    var typeData:Any!
    var parameters = [String : Any]()
    
    func prepareTable() {
        if tableView != nil{
            for id in withIdentifierCell{
                tableView.registerCell(id: id)
            }
            tableView.reloadData()
        }
    }
    
    
    func LoadItem()  {
        
    }
    
    func LoadCompletedItem()  {
        
    }
    
    /// UITableViewDelegate
    func getCount() -> Int{
        return 0
    }
    
    func prepareCellForData(in tableView: UITableView, Data: Any ,indexPath : IndexPath) -> UITableViewCell{
        return UITableViewCell()
    }
    
    
    func prepareCellheight(indexPath : IndexPath) -> CGFloat{
        return UITableView.automaticDimension
        
    }
    func cellDidSelected(indexPath : IndexPath){
        // do sometheing
        
    }
    
    
    
    
    func ItemSetupNavigation(forViewController: SuperViewController, prepareNavigationBar: CustomNavigationBar,title : String){
        
        self.viewController = forViewController
        //        prepareNavigationBar.setTitle(title, sender: forViewController)
        prepareNavigationBar.setTitle(title, sender: forViewController,Srtingcolor :"AECB1B")
        
    }
    
}

