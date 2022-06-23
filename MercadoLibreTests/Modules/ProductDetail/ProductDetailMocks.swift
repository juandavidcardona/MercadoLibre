//
//  ProductDetailMocks.swift
//  MercadoLibreTests
//
//  Created by Juan on 23/06/22.
//


import XCTest
@testable import MercadoLibre

class ProductDetailViewMock: ProductDetailViewProtocol {
    var presenter: ProductDetailPresenterProtocol?
    var displayProductItemInfoCalled = false
    var displayServiceErrorCalled = false
    
    func displayProductItemInfo(product: ProductDetailModel) {
        displayProductItemInfoCalled = true
    }
    
    func displayServiceError() {
        displayServiceErrorCalled = true
    }
}

class ProductDetailInteractorMock: ProductDetailInteractorInputProtocol {
    var presenter: ProductDetailInteractorOutputProtocol?
    var getProductDetailItemCalled = false
    
    func getProductDetailItem(productId: String) {
        getProductDetailItemCalled = true
    }
}

class ProductDetailPresenterMock: ProductDetailInteractorOutputProtocol {
    
    var presentProductDetailItemCalled = false
    var presentServiceErrorCalled = false
    
    func presentProductDetailItem(product: ProductDetailModel) {
        presentProductDetailItemCalled = true
    }
    
    func presentServiceError() {
        presentServiceErrorCalled = true
    }
    
}

class ProductDetailRouterMock: ProductDetailRouterProtocol {
    var viewController: UIViewController?
    
    static func createModule(productId: String) -> UIViewController {
        return UIViewController()
    }
}

struct ProductDetailMockData {
    static let productItem = ProductDetailModel(title: "Iphone x", imagesUrl: [], description: "", price: "3450222", freeShipping: true, currencyId: "COP", condition: .new, address: "Bogota")
}
