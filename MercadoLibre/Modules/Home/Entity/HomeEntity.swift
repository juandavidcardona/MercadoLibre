//
//  HomeEntity.swift
//  MercadoLibre
//
//  Created by Juan on 17/06/22.
//

import Foundation

struct ProductModel {
    let id: String
    let name: String
    let thumbnailUrl: String
    let price: String
    let condition: Condition
    let currencyId: String
    let freeShipping: Bool
}

enum SearchType: Int {
    case relevant = 0
    case lowerPrice = 1
    case highterPrice = 2
    
    static func searchTypeFromInt(_ value: Int) -> SearchType {
        switch value {
        case 1: return .lowerPrice
        case 2: return .highterPrice
        default: return .relevant
        }
    }
}
