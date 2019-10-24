//
//  StructSubscription.swift
//  Karam
//
//  Created by ramez adnan on 04/07/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct StructSubscription: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [SubscriptionDate]?
}

// MARK: - Item
struct SubscriptionDate: Codable {
    let id: Int?
    let price, period, unit, status: String?
    let createdAt, name, descriptions: String?
    let translations: [Translation]?
    
    enum CodingKeys: String, CodingKey {
        case id, price, period, unit, status
        case createdAt = "created_at"
        case name, descriptions, translations
    }
}

// MARK: - Translation
struct Translation: Codable {
    let id: Int?
    let subscribeID, locale, name, descriptions: String?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case subscribeID = "subscribe_id"
        case locale, name, descriptions
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}
