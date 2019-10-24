//
//  SuperViewController.swift
//  Project
//
//  Created by ahmed on 6/10/18.
//  Copyright © 2018 ahmed. All rights reserved.
//

import UIKit


class SuperViewController: UIViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // enable swipe to pop
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func didClickRightButton(_sender :UIBarButtonItem) {
    }
    
    func backButtonAction(_sender :UIBarButtonItem) {
       
        self.navigationController?.popViewController(animated: true)
    }
    
    func ShowMenuAction(_sender :UIBarButtonItem) {
       
    }
    
    func backButtonActionWithdismiss(_sender :UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
  
    
    
} 
