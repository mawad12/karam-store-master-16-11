//
//  StructTypeFood.swift
//  Karam
//
//  Created by ramez adnan on 04/07/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import Foundation
struct StructTypeFood: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [TypeFood]?
}

// MARK: - Item
struct TypeFood: Codable {
    let id: Int?
    let name: String?
    let title: String?
}

struct StructLogisticCat: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [LogisticCat]?
}

//Mark: - logistic Category
struct LogisticCat: Codable {
    let id: Int?
    let image: String?
    let status: String?
    let type: String?
    let name: String?
}

struct NotificationsStruct: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [NotificationsItem]?
}

// MARK: - Item
struct NotificationsItem: Codable {
    let id: Int?
    let userId, orderId, title, message: String?
    let createdAt: String?
    let imageUser: String?
    let nameUser: String?
    let typeMsg: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case orderId = "order_id"
        case title, message
        case createdAt = "created_at"
        case imageUser = "image_user"
        case nameUser = "name_user"
        case typeMsg = "type_msg"
    }
}



