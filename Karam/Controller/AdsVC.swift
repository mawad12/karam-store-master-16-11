//
//  ViewController.swift
//  PT
//
//  Created by musbah on 3/24/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import FSPagerView

class AdsVC: UIViewController {

    @IBOutlet weak var continerView: UIView!
    
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
 
    @IBOutlet weak var pageControlle: FSPageControl!{
        didSet{
            pageControlle.numberOfPages = numberOfItems.count
            pageControlle.contentHorizontalAlignment = .center
            pageControlle.setImage(UIImage(named: "whiteRect"), for: .normal)
            pageControlle.setImage(UIImage(named: "selectedRect"), for: .selected)
            
        }
    }
    
    
    var numberOfItems = [AdsStruct]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        pagerView.
//        pagerView.layer.cornerRadius = 350
//        pagerView.layer.maskedCorners = [.layerMaxXMaxYCorner]
//
//        continerView.layer.cornerRadius = 350
//        continerView.layer.maskedCorners = [.layerMaxXMaxYCorner]

        getAdsRequest()
    }
    
    func getAdsRequest() {
        _ = WebRequests.setup(controller: self).prepare(query: "ads", method: HTTPMethod.get).start(){ (response, error) in
            do {

                let object =  try JSONDecoder().decode(AdsObject.self, from: response.data!)
                self.numberOfItems = object.items!
                self.pagerView.reloadData()
                self.pageControlle.numberOfPages = self.numberOfItems.count

            } catch let jsonErr {
                print("Error serializing  respone json", jsonErr)
            }
        }
        
    }

   
    @IBAction func skipButton(_ sender: Any) {

        if CurrentUser.userInfo != nil{
            let vc:MainVC = AppDelegate.sb_main.instanceVC()
            let NavigationController :CustomNavigationBar = AppDelegate.sb_main.instanceVC()
            NavigationController.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .fullScreen

            self.present(vc, animated: true, completion: nil)
            
        }else{
            let vc:SignInVC = AppDelegate.sb_main.instanceVC()
            vc.modalPresentationStyle = .fullScreen

            self.present(vc, animated: true, completion: nil)
        }
    }
}




// MARK: - FSPager
extension AdsVC: FSPagerViewDelegate, FSPagerViewDataSource{
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return numberOfItems.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        cell.imageView?.sd_custom(url: numberOfItems[index].image!)
        self.pageControlle.currentPage = pagerView.currentIndex
        
        return cell
    }
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControlle.currentPage = pagerView.currentIndex
    }
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControlle.currentPage = targetIndex
    }
    
}
