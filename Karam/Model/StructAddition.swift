//
//  StructAddition.swift
//  Karam
//
//  Created by ramez adnan on 22/07/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import Foundation
struct StructAddition: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [AdditionItem]?
}

// MARK: - Item
struct AdditionItem: Codable {
    let id: Int?
    let price, productID, status, nameAr: String?
    let nameEn, productName, name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, price
        case productID = "product_id"
        case status
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case productName = "product_name"
        case name
    }
}
