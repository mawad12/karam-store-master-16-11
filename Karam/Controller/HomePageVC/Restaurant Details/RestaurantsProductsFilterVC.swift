//
//  RestaurantsProductsFilterVC.swift
//  Karam
//
//  Created by musbah on 7/1/19.
//  Copyright © 2019 musbah. All rights reserved.
//

import UIKit
import RangeSeekSlider
import AAPickerView

protocol RestaurantsProductsFilterDelgate : class {
    func SelectedDone(
        category_id: Int,
        SortBy: String,
        offers:Bool,
        Featured:Bool,
        MaxValue:Double,
        MinValue:Double
    )
}



class RestaurantsProductsFilterVC: UIViewController {
    
    
    @IBOutlet fileprivate weak var rangeSliderCurrency: RangeSeekSlider!
    
    @IBOutlet weak var OffersSwitch: UISwitch!
    
    @IBOutlet weak var FeaturedSwitch: UISwitch!
    
    
    @IBOutlet weak var CategoryPicker: AAPickerView!
    
    @IBOutlet weak var SortByPicker: AAPickerView!
    
    
    
    var Offers = false
    var Featured = false
    
    var RangeMaxValue = 0.0
    var RangeMinValue = 0.0
    
    var CategoryArray = [AllCategoryStruct]()

    var SortByArray = ["Low to high".localized, "high to Low".localized]
    
    var slectedCategoryID = 0
    var slectedCategory:String?

    var slectedSortBy:String = ""
    
    
    var RestaurantsProductsDelgate:RestaurantsProductsFilterDelgate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // currency range slider
        rangeSliderCurrency.delegate = self
        rangeSliderCurrency.numberFormatter.numberStyle = .currency
        rangeSliderCurrency.numberFormatter.currencySymbol = "SAR".localized
        
        
        config_SortByPicker()
        config_CategoryPicker()
    }
    
    
    @IBAction func OffersSwitch(_ sender: UISwitch) {
        if sender.isOn == true{
            Offers = true
        }else{
            Offers = false
        }
    }
    
    @IBAction func FeaturedSwitch(_ sender: UISwitch) {
        if sender.isOn == true{
            Featured = true
        }else{
            Featured = false
        }
    }
    
    // Category Picker
    func config_CategoryPicker() {
        
        CategoryPicker.pickerType = .string(data: CategoryArray.map{$0.title!})
        
        CategoryPicker.heightForRow = 40
        
        CategoryPicker.toolbar.barTintColor = .darkGray
        CategoryPicker.toolbar.tintColor = .black
        
        CategoryPicker.valueDidSelected = { (index) in
            print("selected String ", self.CategoryArray[index as! Int].id!)
            self.slectedCategoryID = self.CategoryArray[index as! Int].id!
            self.slectedCategory = self.CategoryArray[index as! Int].title!
            
        }
        
        CategoryPicker.valueDidChange = { value in
            print("selected Value",value)
            print("selected String ",  self.CategoryArray[value as! Int].id!)
            self.slectedCategoryID = self.CategoryArray[value as! Int].id!
            self.slectedCategory = self.CategoryArray[value as! Int].title!
            
        }
        
    }
    
    
    
    // SortBy Picker
    func config_SortByPicker() {
        
        SortByPicker.pickerType = .string(data: self.SortByArray)
        
        SortByPicker.heightForRow = 40
        
        SortByPicker.toolbar.barTintColor = .darkGray
        SortByPicker.toolbar.tintColor = .black
        
        SortByPicker.valueDidSelected = { (index) in
            print("selected String ", self.SortByArray[index as! Int])
            
            self.slectedSortBy = self.SortByArray[index as! Int]
            
        }
        
        SortByPicker.valueDidChange = { value in
            print("selected Value",value)
            print("selected String ",  self.SortByArray[value as! Int])
            self.slectedSortBy = self.SortByArray[value as! Int]
            
        }
        
    }
    
    
    
    
    @IBAction func tapButton(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    

    
    @IBAction func ResetButton(_ sender: Any) {
        
    }
    
    @IBAction func FilterButton(_ sender: Any) {
        RestaurantsProductsDelgate?.SelectedDone(category_id: slectedCategoryID,
                                                 SortBy: slectedSortBy,
                                                 offers: Offers,
                                                 Featured: Featured,
                                                 MaxValue: RangeMaxValue,
                                                 MinValue: RangeMinValue
                                                )
        self.dismiss(animated: true, completion: nil)
        
        
    }
    

}



// MARK: - RangeSeekSliderDelegate
extension RestaurantsProductsFilterVC: RangeSeekSliderDelegate {

    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {

        print("Currency slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        self.RangeMaxValue = Double(maxValue)
        self.RangeMinValue = Double(minValue)
    }

    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }

    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}
