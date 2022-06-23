//
//  ProductsResponse.swift
//  MercadoLibre
//
//  Created by Juan on 17/06/22.
//

import Foundation

// MARK: - ProductsResponse
struct ProductsResponse: Codable {
    let results: [Result?]?
    let paging: Paging?

    enum CodingKeys: String, CodingKey {
        case paging
        case results
    }
}

// MARK: - Sort
struct Sort: Codable {
    let id, name: String?
}

// MARK: - Paging
struct Paging: Codable {
    let total, offset, limit: Int?

    enum CodingKeys: String, CodingKey {
        case total
        case offset, limit
    }
}

// MARK: - Result
struct Result: Codable {
    let id: String?
    let title: String?
    let thumbnail: String?
    let price: Int?
    let currencyID: String?
    let condition: Condition?
    let shipping: Shipping?

    enum CodingKeys: String, CodingKey {
        
        case title
        case price
        case thumbnail
        case shipping
        case id
        case currencyID = "currency_id"
        case condition
    }
}

enum Condition: String, Codable {
    case new = "new"
    case used = "used"
    case notSpecified = "not_specified"
    
    var description: String {
        switch self {
        case .new: return "Nuevo"
        case .used: return "Usado"
        default: return ""
        }
    }
}

// MARK: - SellerAddress
struct SellerAddress: Codable {
    let country, state, city: Sort?
    
    enum CodingKeys: String, CodingKey {
        case country, state, city
    }
}

// MARK: - Shipping
struct Shipping: Codable {
    let freeShipping: Bool?

    enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
    }
}
