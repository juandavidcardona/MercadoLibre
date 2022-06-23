//
//  ProductsClient.swift
//  MercadoLibre
//
//  Created by Juan on 17/06/22.
//

import Foundation

protocol ProductsClientNetworkingProtocol {
    func getProducts(text: String, searchType: SearchType, offset: Int, completionHandler: @escaping(_ products: ProductsResponse?, _ responseType: NetworkServiceStatus) -> Void)
    func getProductItem(productId: String, completionHandler: @escaping(_ product: ProductItemResponse?, _ responseType: NetworkServiceStatus) -> Void)
}

class ProductsClientNetworking: ProductsClientNetworkingProtocol {

    private let host = "api.mercadolibre.com"
    private let productsEndpoint = "/sites/MCO/search"
    
    func getProducts(text: String, searchType: SearchType, offset: Int, completionHandler: @escaping(_ products: ProductsResponse?, _ responseType: NetworkServiceStatus) -> Void) {
        let service = ServicesManager()
        service.method = .get
        service.host = host
        service.endpoint = productsEndpoint
        switch searchType {
        case .relevant:
            service.parameters = ["q" : text, "offset": offset]
        case .lowerPrice:
            service.parameters = ["q" : text, "sort": "price_asc", "offset": offset]
        case .highterPrice:
            service.parameters = ["q" : text, "sort": "price_desc", "offset": offset]
        }

        service.callCore(modelType: ProductsResponse.self) { (status, response) in
            if status == .success {
                completionHandler(response, status)
            } else {
                completionHandler(nil, status)
            }
        }
    }
    
    func getProductItem(productId: String, completionHandler: @escaping(_ product: ProductItemResponse?, _ responseType: NetworkServiceStatus) -> Void) {
        let service = ServicesManager()
        service.method = .get
        service.host = host
        service.endpoint = "/items/\(productId)"
        
        service.callCore(modelType: ProductItemResponse.self) { (status, response) in
            if status == .success {
                completionHandler(response, status)
            } else {
                completionHandler(nil, status)
            }
        }
    }
}
