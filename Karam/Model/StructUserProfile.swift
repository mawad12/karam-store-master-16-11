//
//  StructUserProfile.swift
//  Karam
//
//  Created by ramez adnan on 22/07/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import Foundation
struct StructUserProfile: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: userprofile?
}

// MARK: - Items
struct userprofile: Codable {
    let id: Int?
    let name, email, mobile, status: String?
    let gender, promotionalUser, promotionalCode: String?
    let itemsDescription: String?
    let restaurantType: String?
    let timeFrom, timeTo, countryID, cityID: String?
    let address, lat, lan, delivery: String?
    let deliveryCost, typeUser: String?
    let typeServiceProvider, packageID: String?
    let profileImage: String?
    let instagram, twitter, facebook, youtube: String?
    let minimumOrderPrice, eatingPlace, deliveryTime, paymentMethod: String?
    let isAvailable, categoryID, closed: String?
    let distance, point: String?
    let video: String?
    let createdAt, accessToken: String?
    let addressDeliveryUser: String?
    let isFavourite: Int?
    let statusNow: String?
    let isSale, rate, countRate: Int?
    let foodType: [FoodTypeUser]?
    let city, country: CityU?
    let attatchment: [AttatchmentUser]?
    let category: CategoryUser?
    let jobs: [String]?
    let package: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, mobile, status, gender
        case promotionalUser = "promotional_user"
        case promotionalCode = "promotional_code"
        case itemsDescription = "description"
        case restaurantType, timeFrom, timeTo
        case countryID = "country_id"
        case cityID = "city_id"
        case address, lat, lan, delivery, deliveryCost, typeUser, typeServiceProvider
        case packageID = "package_id"
        case profileImage = "profile_image"
        case instagram, twitter, facebook, youtube, minimumOrderPrice, eatingPlace, deliveryTime
        case paymentMethod = "payment_method"
        case isAvailable
        case categoryID = "category_id"
        case closed, distance, point, video
        case createdAt = "created_at"
        case accessToken = "access_token"
        case addressDeliveryUser = "address_delivery_user"
        case isFavourite = "is_favourite"
        case statusNow = "status_now"
        case isSale = "is_sale"
        case rate
        case countRate = "count_rate"
        case foodType = "food_type"
        case city, country, attatchment, category, jobs, package
    }
}

// MARK: - Attatchment
struct AttatchmentUser: Codable {
    let id: Int?
    let userID: String?
    let image: String?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

// MARK: - Category
struct CategoryUser: Codable {
    let id: Int?
    let logo: String?
    let status, title: String?
}

// MARK: - City
struct CityU: Codable {
    let id: Int?
    let parent: String?
    let flag: String?
    let currency, status, name: String?
}

// MARK: - FoodType
struct FoodTypeUser: Codable {
    let id: Int?
    let name: String?
}
