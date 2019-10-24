//
//  Struct.swift
//  Karam
//
//  Created by Musbah on 2/7/19.
//  Copyright © 2019 Musbah. All rights reserved.
//

import UIKit
import Foundation

struct CurrentUser  {
    
    static var userInfo : UserStruct?  {
        set {
            guard newValue != nil else {
                UserDefaults.standard.removeObject(forKey: "CurrentUser");
                return;
            }
            let encodedData = try? PropertyListEncoder().encode(newValue)
            UserDefaults.standard.set(encodedData, forKey:"CurrentUser")
            UserDefaults.standard.synchronize();
        }
        get {
            if let data = UserDefaults.standard.value(forKey:"CurrentUser") as? Data {
                return try? PropertyListDecoder().decode(UserStruct.self, from:data)
                
            }
            return nil
        }
    }
    
}


struct CurrentSettings  {
    
    static var settingsInfo : SettingsStruct?  {
        set {
            guard newValue != nil else {
                UserDefaults.standard.removeObject(forKey: "CurrentSettings");
                return;
            }
            let encodedData = try? PropertyListEncoder().encode(newValue)
            UserDefaults.standard.set(encodedData, forKey:"CurrentSettings")
            UserDefaults.standard.synchronize();
        }
        get {
            if let data = UserDefaults.standard.value(forKey:"CurrentSettings") as? Data {
                return try? PropertyListDecoder().decode(SettingsStruct.self, from:data)
            }
            return nil
        }
    }
}



// MARK: - User Object
struct UserObject: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: UserStruct?
}
struct UserStruct: Codable {
    let id: Int?
    let name_en, name_ar , email, mobile, status: String?
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
    let addressDeliveryUser: AddressDeliveryUser?
    let isFavourite: Int?
    let statusNow: String?
    let isSale, rate, countRate: Int?
    let foodType: [FoodType]?
    let city, country: CityUser?
    let attatchment: [Attatchment]?
    let category: Category?
    let jobs: [String]?
    let package: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name_en, name_ar, email, mobile, status, gender
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
        case addressDeliveryUser = "addrCategoryy_user"
        case isFavourite = "is_favourite"
        case statusNow = "status_now"
        case isSale = "is_sale"
        case rate
        case countRate = "count_rate"
        case foodType = "food_type"
        case city, country, attatchment, category, jobs, package
    }
}
struct LogisticsStruct: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [LogisticItem]?
}

// MARK: - Item
struct LogisticItem: Codable {
    let id: Int?
    let image,description: String?
    let status, type, name: String?
    let category: Category?
    enum CodingKeys: String, CodingKey {
        case id
        case description
        case image = "profile_image"
        case status
        case type
        case name
        case category
    }
}
// MARK: - Attatchment
struct Attatchment: Codable {
    let id: Int?
    let userID: String?
    let image: String?
    let createdAt, updatedAt: String?
    let deletedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case image = "profile_image"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int?
    let logo: String?
    let status, title: String?
}

// MARK: - City
struct CityUser: Codable {
    let id: Int?
    let parent: String?
    let flag: String?
    let currency, status, name: String?
}

// MARK: - FoodType
struct FoodType: Codable {
    let id: Int?
    let name: String?
}


struct AddressDeliveryUser: Codable {
    let id: Int?
    let userId, addressName, countryId, cityId: String?
    let block, street, buildingNumber, apartmentNumber: String?
    let isDefault, lat, lan, address: String?
    let status: String?
    let city: RestaurantsCity?
    let country: RestaurantsCity?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case addressName = "address_name"
        case countryId = "country_id"
        case cityId = "city_id"
        case block, street
        case buildingNumber = "building_number"
        case apartmentNumber = "apartment_number"
        case isDefault = "is_default"
        case lat, lan, address, status, city, country
    }
}


// MARK: - Settings Object
struct SettingsObject: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: SettingsStruct?
}

// MARK: - Items
struct SettingsStruct: Codable {
    let id: Int?
    let url: String?
    let logo: String?
    let adminEmail: String?
    let appStoreURL, playStoreURL: String?
    let infoEmail, mobile, phone: String?
    let facebook, twitter, linkedIn, instagram: String?
    let googlePlus: String?
    let paginate, latitude, longitude: String?
    let image: String?
    let vedio, joinUs, note, coloredPrice: String?
    let blackWhitePrice, createdAt, updatedAt: String?
    let aboutUs, privacy, terms: AboutUs?
    let title, joinDescription, itemsDescription, address: String?
    let keyWords: String?
    
    enum CodingKeys: String, CodingKey {
        case id, url, logo
        case adminEmail = "admin_email"
        case appStoreURL = "app_store_url"
        case playStoreURL = "play_store_url"
        case infoEmail = "info_email"
        case mobile, phone, facebook, twitter
        case linkedIn = "linked_in"
        case instagram
        case googlePlus = "google_plus"
        case paginate, latitude, longitude, image, vedio
        case joinUs = "join_us"
        case note
        case coloredPrice = "colored_price"
        case blackWhitePrice = "blackWhite_price"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case aboutUs, privacy, terms, title
        case joinDescription = "join_description"
        case itemsDescription = "description"
        case address
        case keyWords = "key_words"
    }
}

struct AboutUs: Codable {
    let id: Int?
    let image: String?
    let views, createdAt, updatedAt, deletedAt: String?
    let title, slug, aboutUsDescription, keyWords: String?
    
    enum CodingKeys: String, CodingKey {
        case id, image, views
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case title, slug
        case aboutUsDescription = "description"
        case keyWords = "key_words"
    }
}





// MARK: - CountryObject
struct CountryObject: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [CountryStruct]?
}

struct CountryStruct: Codable {
    let id: Int?
    let parent: String?
    let flag: String?
    let name: String?
}









// MARK: - FoodsObject
struct FoodsObject: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [FoodsStruct]?
}

struct FoodsStruct: Codable {
    let id: Int?
    let image, name: String?
}






// MARK: - AllCategoryObject
struct AllCategoryObject: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [AllCategoryStruct]?
}

// MARK: - Item
struct AllCategoryStruct: Codable {
    let id: Int?
    let logo: String?
    let status, title: String?
}







// MARK: - AdsObject
struct AdsObject: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [AdsStruct]?
}

struct AdsStruct: Codable {
    let id: Int?
    let image: String?
    let link: String?
    let type, position, orderBy, typeFor: String?
    let descriptions: String?
    
    enum CodingKeys: String, CodingKey {
        case id, image, link, type, position
        case orderBy = "order_by"
        case typeFor = "type_for"
        case descriptions
    }
}


// MARK: - SliderObject
struct SliderObject: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [SliderStruct]?
}

struct SliderStruct: Codable {
    let id: Int?
    let type, status: String?
    let image: String?
    let order: String?
    let link: String?
    let title: String?
}



// MARK: - RestaurantDetailsObject
struct RestaurantDetailsObject: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: RestaurantsStruct?
}

// MARK: - RestaurantsObject
struct RestaurantsObject: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [RestaurantsStruct]?
}

struct RestaurantsStruct: Codable {
    let id: Int?
    let name,name_ar, email, mobile, status: String?
    let gender, promotionalUser, promotionalCode, itemDescription: String?
    let restaurantType, timeFrom, timeTo, countryID: String?
    let cityID, address, lat, lan: String?
    let foodTypeID, delivery, deliveryCost: String?
    let video: String?
    let typeUser, typeServiceProvider, packageID: String?
    let profileImage: String?
    let instagram, twitter, facebook, minimumOrderPrice: String?
    let eatingPlace, deliveryTime, paymentMethod, createdAt: String?
    let distance, addressDeliveryUser: String?
    let isFavourite: Int?
    let statusNow: String?
    let isSale, countRate: Int?
    let rate: Double?
    let foodType: [RestaurantsFoodType]?
    let city, country: RestaurantsCity?
    let attatchment: [RestaurantsAttatchment]?
    
    enum CodingKeys: String, CodingKey {
        case id, name,name_ar, email, mobile, status, gender
        case promotionalUser = "promotional_user"
        case promotionalCode = "promotional_code"
        case itemDescription = "description"
        case restaurantType, timeFrom, timeTo
        case countryID = "country_id"
        case cityID = "city_id"
        case address, lat, lan
        case foodTypeID = "foodType_id"
        case delivery, deliveryCost, video, typeUser, typeServiceProvider
        case packageID = "package_id"
        case profileImage = "profile_image"
        case instagram, twitter, facebook, minimumOrderPrice, eatingPlace, deliveryTime
        case paymentMethod = "payment_method"
        case createdAt = "created_at"
        case distance
        case addressDeliveryUser = "address_delivery_user"
        case isFavourite = "is_favourite"
        case statusNow = "status_now"
        case isSale = "is_sale"
        case rate
        case countRate = "count_rate"
        case foodType = "food_type"
        case city, country, attatchment
    }
}

struct RestaurantsAttatchment: Codable {
    let id: Int?
    let userID: String?
    let image: String?
    let createdAt, updatedAt, deletedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

struct RestaurantsCity: Codable {
    let id: Int?
    let parent: String?
    let flag: String?
    let currency, name: String?
}

struct RestaurantsFoodType: Codable {
    let id: Int?
    let image, name: String?
}









// MARK: - ProductsObject
struct ProductsCategoryObject: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [ProductItemStruct]?
}


// MARK: - ProductsObject
struct ProductsObject: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [ProductsStruct]?
}

struct ProductStruct: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: ProductItemStruct?
}

struct ProductsStruct: Codable {
    let id: Int?
    let logo: String?
    let status, title: String?
    let product: [ProductItemStruct]?
}


struct ProductItemStruct: Codable {
    let id: Int?
    let userID, categoryID, categoryName, price, priceAfterOffer: String?
    let delete: String?
    let coverImage: String?
    let video: String?
    let start, offerFrom, offerTo, status: String?
    let discount, dealDay, dealDayDate, countSale: String?
    let likeCount, isFavourite, isLike, views: Int?
    let inCart: Int?
    let shareLink: String?
    let quantity, rate: Int?
    let deliveryTime, restaurantName: String?
    let restaurantLogo: String?
    let name, description,name_ar,name_en,description_ar,description_en: String?
    let favourite: Int?
    let productImage: [ProductImage]?
    let addition: [ProductAddition]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case categoryID = "category_id"
        case categoryName = "category_name"
        case price
        case priceAfterOffer = "price_after_offer"
        case delete
        case coverImage = "cover_image"
        case video, start ,name_ar,name_en,description_ar,description_en
        case offerFrom = "offer_from"
        case offerTo = "offer_to"
        case status, discount, dealDay
        case dealDayDate = "dealDay_date"
        case countSale = "count_sale"
        case likeCount = "like_count"
        case isFavourite = "is_favourite"
        case isLike = "is_like"
        case views
        case inCart = "in_cart"
        case shareLink = "share_link"
        case quantity, rate
        case deliveryTime = "delivery_time"
        case restaurantName = "restaurant_name"
        case restaurantLogo = "restaurant_logo"
        case name, description
        case favourite
        case productImage = "product_image"
        case addition
    }
}

struct ProductAddition: Codable {
    let id: Int?
    let price, productID, name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, price
        case productID = "product_id"
        case name
    }
}

/*
 
 struct ProductAddition: Codable {
 let id: Int?
 let price, productID, name,spatialRequest,additionId: String?
 var AdditionCount: Int?
 enum CodingKeys: String, CodingKey {
 case id, price
 case productID = "product_id"
 case spatialRequest = "spatial_request"
 case name
 case AdditionCount = "quantity"
 case additionId = "addition_id"
 
 }
 init(from decoder: Decoder) throws {
 let container = try decoder.container(keyedBy: CodingKeys.self)
 self.id = try container.decodeIfPresent(Int.self, forKey: .id)
 self.additionId = try container.decodeIfPresent(String.self, forKey: .additionId)
 self.price = try container.decodeIfPresent(String.self, forKey: .price)
 self.spatialRequest = try container.decodeIfPresent(String.self, forKey: .spatialRequest)
 self.productID = try container.decodeIfPresent(String.self, forKey: .productID)
 self.name = try container.decodeIfPresent(String.self, forKey: .name)
 if let value = try? container.decode(String.self, forKey: .AdditionCount) {
 self.AdditionCount = Int(value)
 } else {
 self.AdditionCount = try container.decodeIfPresent(Int.self, forKey: .AdditionCount) ?? 0
 }
 }
 }
 
 
 */
struct ProductImage: Codable {
    let id: Int?
    let productID: String?
    let image: String?
    let createdAt, updatedAt, deletedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}



struct OrderDetailStruct: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let OrderItems: OrderItems?
    enum CodingKeys: String, CodingKey {
        case status,code,message
        case OrderItems = "items"
    }
}


// MARK: - MyOrderStruct
struct MyOrderStruct: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let OrderItems: [OrderItems]?
    enum CodingKeys: String, CodingKey {
        case status,code,message
        case OrderItems = "items"
    }
}

// MARK: - Item
struct OrderItems: Codable {
    let id: Int?
    let userId, storeId, deliveryCompanyId, totalPrice: String?
    let deliveryAddress, deliveryMethod, paymentMethod, productCost: String?
    let status, deliveryCost: String?
    let time: String?
    let createdAt, changeStatus, storeName, customerName: String?
    let customerMobile: String?
    let customerCity: CustomerCity?
    let products: [ProductElement]?
    let additions: [AdditionElement]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case storeId = "store_id"
        case deliveryCompanyId = "delivery_company_id"
        case totalPrice = "total_price"
        case deliveryAddress = "delivery_address"
        case deliveryMethod = "delivery_method"
        case paymentMethod = "payment_method"
        case productCost = "product_cost"
        case status
        case deliveryCost = "delivery_cost"
        case time
        case createdAt = "created_at"
        case changeStatus = "change_Status"
        case storeName = "store_name"
        case customerName = "customer_name"
        case customerMobile = "customer_mobile"
        case customerCity = "customer_city"
        case products
        case additions
    }
}

struct CustomerCity: Codable {
    let id: Int?
    let userID, addressName, countryID, cityID: String?
    let block, street, buildingNumber, apartmentNumber: String?
    let isDefault, lat, lan, address: String?
    let status: String?
    let city, country: RestaurantsCity?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case addressName = "address_name"
        case countryID = "country_id"
        case cityID = "city_id"
        case block, street
        case buildingNumber = "building_number"
        case apartmentNumber = "apartment_number"
        case isDefault = "is_default"
        case lat, lan, address, status, city, country
    }
}


// MARK: - ProductElement
struct ProductElement: Codable {
    let id: Int?
    let orderId, productId, quantity, price: String?
    let product: ProductItemStruct?
    
    enum CodingKeys: String, CodingKey {
        case id
        case orderId = "order_id"
        case productId = "product_id"
        case quantity, price, product
    }
}











struct AdditionElement: Codable {
    let id: Int
    let orderID, additionID, quantity, price: String
    let spatialRequest: String
    let addition: AdditionAddition
    
    enum CodingKeys: String, CodingKey {
        case id
        case orderID = "order_id"
        case additionID = "addition_id"
        case quantity, price
        case spatialRequest = "spatial_request"
        case addition
    }
}

// MARK: - AdditionAddition
struct AdditionAddition: Codable {
    let id: Int
    let price, productID, status, nameAr: String
    let nameEn, productName, name: String
    
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















// MARK: - FQAObject
struct FQAObject: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [FQAStruct]?
}

// MARK: - Item
struct FQAStruct: Codable {
    let id: Int?
    let status, createdAt, updatedAt, deletedAt: String?
    let questions, answers: String?
    
    enum CodingKeys: String, CodingKey {
        case id, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
        case questions, answers
    }
}






// MARK: - LogisticDetailsObject
struct LogisticDetailsObject: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: LogisticDetailsStruct?
}

// MARK: - Items
struct LogisticDetailsStruct: Codable {
    let id: Int?
    let name, email, mobile, status: String?
    let gender, promotionalUser, promotionalCode, itemsDescription: String?
    let restaurantType, timeFrom, timeTo, countryID: String?
    let cityID, address, lat, lan: String?
    let delivery, deliveryCost, typeUser, typeServiceProvider: String?
    let packageID, profileImage, instagram, twitter: String?
    let facebook, youtube, minimumOrderPrice, eatingPlace: String?
    let deliveryTime, paymentMethod, isAvailable, categoryID: String?
    let closed, distance, point, video: String?
    let createdAt, addressDeliveryUser: String?
    let isFavourite: Int?
    let statusNow: String?
    let isSale, rate, countRate: Int?
    let foodType: [City]?
    let city, country: City?
    let attatchment: [City]?
    let category: Category?
    let jobs: [City]?
//    let package: String?
    
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
        case addressDeliveryUser = "address_delivery_user"
        case isFavourite = "is_favourite"
        case statusNow = "status_now"
        case isSale = "is_sale"
        case rate
        case countRate = "count_rate"
        case foodType = "food_type"
        case city, country, attatchment, category, jobs
    }
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let parent, flag, currency, status: String?
    let name: String?
}





// MARK: - ChatObject
struct AllChatObject: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [AllChatStruct]?
}

// MARK: - Item
struct AllChatStruct: Codable {
    let id: Int?
    let user1, user2, createdAt, lastMessage: String?
    let restaurantName, restaurantImage: String?
    let userName, userImage: String?
    
    enum CodingKeys: String, CodingKey {
        case id, user1, user2
        case createdAt = "created_at"
        case lastMessage = "last_message"
        case restaurantName = "restaurant_name"
        case restaurantImage = "restaurant_image"
        case userName = "user_name"
        case userImage = "user_image"
    }
}





// MARK: - MessagesObject
struct MessagesObject: Codable {
    let status: Bool?
    let code: Int?
    let message: String?
    let items: [MessagesStruct]?
}


struct MessagesStruct: Codable {
    let id: Int?
    let chatID, senderID, message, readAt: String?
    let type, createdAt: String?
    let userImage: String?
    let userName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case chatID = "chat_id"
        case senderID = "sender_id"
        case message
        case readAt = "read_at"
        case type
        case createdAt = "created_at"
        case userImage = "user_image"
        case userName = "user_name"
        
    }
}
