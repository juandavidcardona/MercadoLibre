//
//  ProductClientNetworkingMock.swift
//  MercadoLibreTests
//
//  Created by Juan on 23/06/22.
//

import XCTest
@testable import MercadoLibre

class ProductNetworkingMock: NetworkingMock, ProductsClientNetworkingProtocol {
    
    private var statusCode = 200
    private var jsonFileName = ""
    
    func configureNetworking(statusCode: Int, jsonFileName: String) {
        self.statusCode = statusCode
        self.jsonFileName = jsonFileName
    }
    
    func getProducts(text: String, searchType: SearchType, offset: Int, completionHandler: @escaping (ProductsResponse?, NetworkServiceStatus) -> Void) {
        callService(statusCode: statusCode, jsonFileName: jsonFileName, modelType: ProductsResponse.self) { status, response in
            completionHandler(response, status)
        }
    }
    
    func getProductItem(productId: String, completionHandler: @escaping (ProductItemResponse?, NetworkServiceStatus) -> Void) {
        callService(statusCode: statusCode, jsonFileName: jsonFileName, modelType: ProductItemResponse.self) { status, response in
            completionHandler(response, status)
        }
    }
}

class NetworkingMock {
    func callService<T:Codable>(statusCode: Int, jsonFileName: String, modelType: T.Type, completionHandler: @escaping NetworkServiceCompletion<T>) {
        
        switch statusCode {
        case 200:
            do {
                guard let path = Bundle.main.url(forResource: jsonFileName, withExtension: "json"),
                      let data = try? Data(contentsOf: path) else { return }
                let decodedData = try JSONDecoder().decode(modelType.self, from: data)
                completionHandler(.success, decodedData)
            } catch {
                completionHandler(.fail, nil)
            }
        default: completionHandler(.fail, nil)

        }
    }
}

