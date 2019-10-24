//
//  StructDelayMeals.swift
//  Karam
//
//  Created by ramez adnan on 09/07/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import Foundation
struct StructDelayMeals: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [DelayMealsData]?
}

// MARK: - Item
struct DelayMealsData: Codable {
    let id: Int?
    let productID, userID, price,name_ar,name_en,description_ar,description_en, discount: String?
    let dealsDate, status, name,image ,itemDescription: String?
    let user: User?
    let product: Product?
    
    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case userID = "user_id"
        case price, discount
        case dealsDate = "deals_date"
        case status, name ,image,name_ar,name_en,description_ar,description_en
        case itemDescription = "description"
        case user, product
    }
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let userID, categoryID, price: String?
    let priceAfterOffer: String?
    let delete: String?
    let coverImage: String?
    let video, start: String?
    let offerFrom, offerTo: String?
    let status: String?
    let discount: String?
    let countSale, statusOffer, deletedOffer, shareNumber: String?
    let likeCount: Int?
    let categoryName: String?
    let isFavourite, isLike, views, inCart: Int?
    let shareLink: String?
    let quantity, rate: Int?
    let deliveryTime: String?
    let restaurantName: String?
    let restaurantLogo: String?
    let nameAr, nameEn, descriptionAr, descriptionEn: String?
    let name, productDescription: String?
    let titleOffer, favourite: String?
    let productImage: [ProductImageDeal]?
    let addition: [Addition]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case categoryID = "category_id"
        case price
        case priceAfterOffer = "price_after_offer"
        case delete
        case coverImage = "cover_image"
        case video, start
        case offerFrom = "offer_from"
        case offerTo = "offer_to"
        case status, discount
        case countSale = "count_sale"
        case statusOffer = "status_offer"
        case deletedOffer
        case shareNumber = "share_number"
        case likeCount = "like_count"
        case categoryName = "category_name"
        case isFavourite = "is_favourite"
        case isLike = "is_like"
        case views
        case inCart = "in_cart"
        case shareLink = "share_link"
        case quantity, rate
        case deliveryTime = "delivery_time"
        case restaurantName = "restaurant_name"
        case restaurantLogo = "restaurant_logo"
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case descriptionAr = "description_ar"
        case descriptionEn = "description_en"
        case name
        case productDescription = "description"
        case titleOffer, favourite
        case productImage = "product_image"
        case addition
    }
}

// MARK: - Addition
struct Addition: Codable {
    let id: Int?
    let price, productID, nameAr, nameEn: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, price
        case productID = "product_id"
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case name
    }
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let name, email, mobile, status: String?
    let gender, promotionalUser, promotionalCode, userDescription: String?
    let restaurantType: String?
    let timeFrom, timeTo, countryID, cityID: String?
    let address, lat, lan: String?
    let delivery, deliveryCost, typeUser: String?
    let typeServiceProvider: String?
    let packageID: String?
    let profileImage: String?
    let instagram, twitter, facebook, youtube: String?
    let minimumOrderPrice, eatingPlace, deliveryTime, paymentMethod: String?
    let isAvailable: String?
    let categoryID: String?
    let closed, distance: String?
    let point: String?
    let video: String?
    let createdAt: String?
    let addressDeliveryUser: String?
    let isFavourite: Int?
    let statusNow: String?
    let isSale, rate, countRate: Int?
    let foodType: [FoodTypeDay]?
    let city, country: CityDeal?
    let attatchment: [AttatchmentDay]?
   // let category: String?
    let jobs: [String]?
    let package: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, mobile, status, gender
        case promotionalUser = "promotional_user"
        case promotionalCode = "promotional_code"
        case userDescription = "description"
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
        case addressDeliveryUser = "address_delivery_user"
        case isFavourite = "is_favourite"
        case statusNow = "status_now"
        case isSale = "is_sale"
        case rate
        case countRate = "count_rate"
        case foodType = "food_type"
        case city, country, attatchment, jobs, package
    }
}
// MARK: - ProductImage
struct ProductImageDeal: Codable {
    let id: Int?
    let productID: String?
    let image: String?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    let userID: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case userID = "user_id"
    }
}

// MARK: - Attatchment
struct AttatchmentDay: Codable {
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

// MARK: - City
struct CityDeal: Codable {
    let id: Int?
    let parent: String?
    let flag: String?
    let currency, status, name: String?
}

// MARK: - FoodType
struct FoodTypeDay: Codable {
    let id: Int?
    let name: String?
}
