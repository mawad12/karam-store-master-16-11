//
//  StructMyOffer.swift
//  Karam
//
//  Created by ramez adnan on 09/07/2019.
//  Copyright © 2019 musbah. All rights reserved.
//

import Foundation
struct StructMyOffer: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [MyOfferData]?
}

// MARK: - Item
struct MyOfferData: Codable {
    let id: Int?
    let userID, categoryID, price, priceAfterOffer: String?
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
    let deliveryTime, restaurantName: String?
    let restaurantLogo: String?
    let nameAr, nameEn, descriptionAr, descriptionEn: String?
    let name, itemDescription: String?
    let titleOffer, favourite: String?
    let productImage, addition: [ProductnameImage]?
    
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
        case itemDescription = "description"
        case titleOffer, favourite
        case productImage = "product_image"
        case addition
    }
}
