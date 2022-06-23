//
//  ProductDetailEntity.swift
//  MercadoLibre
//
//  Created by Juan on 22/06/22.
//

import Foundation

struct ProductDetailModel {
    let title: String
    let imagesUrl: [String]
    let description: String
    let price: String
    let freeShipping: Bool
    let currencyId: String
    let condition: Condition
    let address: String
}
