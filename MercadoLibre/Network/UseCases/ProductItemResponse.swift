//
//  ProductItemResponse.swift
//  MercadoLibre
//
//  Created by Juan on 22/06/22.
//

import Foundation

typealias ProductsItemsResponse = [ProductItemResponseElement]

// MARK: - ProductItemResponseElement
struct ProductItemResponseElement: Codable {
    let code: Int?
    let body: ProductItemResponse?
}

// MARK: - Body
struct ProductItemResponse: Codable {
    let id, siteID, title: String?
//    let subtitle: JSONNull?
//    let sellerID: Int?
//    let categoryID: String?
//    let officialStoreID: JSONNull?
    let price: Int?
//    let originalPrice: JSONNull?
    let currencyID: String?
//    let initialQuantity, availableQuantity, soldQuantity: Int?
//    let saleTerms: [Attribute]?
//    let buyingMode, listingTypeID, startTime, stopTime: String?
    let condition: Condition?
//    let permalink: String?
//    let thumbnailID: String?
//    let thumbnail: String?
//    let secureThumbnail: String?
     let pictures: [Picture]?
//    let videoID: JSONNull?
//    let descriptions: [JSONAny]?
//    let acceptsMercadopago: Bool?
//    let nonMercadoPagoPaymentMethods: [JSONAny]?
    let shipping: Shipping?
//    let internationalDeliveryMode: String?
    let sellerAddress: SellerAddress?
//    let sellerContact: JSONNull?
//    let location: Location?
//    let coverageAreas: [JSONAny]?
//    let attributes: [Attribute]?
//    let warnings: [JSONAny]?
//    let listingSource: String?
//    let variations: [JSONAny]?
//    let status: String?
//    let subStatus, tags: [String]?
//    let warranty, catalogProductID, domainID: String?
//    let parentItemID, differentialPricing: JSONNull?
//    let dealIDS: [JSONAny]?
//    let automaticRelist: Bool?
//    let dateCreated, lastUpdated: String?
//    let health: JSONNull?
//    let catalogListing: Bool?
//    let channels: [String]?

    enum CodingKeys: String, CodingKey {
        case id
        case siteID = "site_id"
        case title
        //case subtitle
//        case sellerID = "seller_id"
//        case categoryID = "category_id"
//        case officialStoreID = "official_store_id"
        case price
//        case basePrice = "base_price"
//        case originalPrice = "original_price"
        case currencyID = "currency_id"
//        case initialQuantity = "initial_quantity"
//        case availableQuantity = "available_quantity"
//        case soldQuantity = "sold_quantity"
//        case saleTerms = "sale_terms"
//        case buyingMode = "buying_mode"
//        case listingTypeID = "listing_type_id"
//        case startTime = "start_time"
//        case stopTime = "stop_time"
        case condition
//        case permalink
//        case thumbnailID = "thumbnail_id"
//        case thumbnail
//        case secureThumbnail = "secure_thumbnail"
         case pictures
//        case videoID = "video_id"
//        case descriptions
//        case acceptsMercadopago = "accepts_mercadopago"
//        case nonMercadoPagoPaymentMethods = "non_mercado_pago_payment_methods"
        case shipping
//        case internationalDeliveryMode = "international_delivery_mode"
        case sellerAddress = "seller_address"
//        case sellerContact = "seller_contact"
//        case location
//        case coverageAreas = "coverage_areas"
//        case attributes, warnings
//        case listingSource = "listing_source"
//        case variations, status
//        case subStatus = "sub_status"
//        case tags, warranty
//        case catalogProductID = "catalog_product_id"
//        case domainID = "domain_id"
//        case parentItemID = "parent_item_id"
//        case differentialPricing = "differential_pricing"
//        case dealIDS = "deal_ids"
//        case automaticRelist = "automatic_relist"
//        case dateCreated = "date_created"
//        case lastUpdated = "last_updated"
//        case health
//        case catalogListing = "catalog_listing"
//        case channels
    }
}
//
//// MARK: - Location
//struct Location: Codable {
//}
//

// MARK: - Picture
struct Picture: Codable {
    let url: String?
//    let id: String?
//    let secureURL: String?
//    let size, maxSize, quality: String?

    enum CodingKeys: String, CodingKey {
        case url
//        case id
//        case secureURL = "secure_url"
//        case size
//        case maxSize = "max_size"
//        case quality
    }
}

//// MARK: - City
//struct City: Codable {
//    let id, name: String?
//}
//
//// MARK: - SearchLocation
//struct SearchLocation: Codable {
//    let city, state: City?
//}
