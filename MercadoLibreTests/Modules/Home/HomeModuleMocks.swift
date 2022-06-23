//
//  HomeModuleMocks.swift
//  MercadoLibreTests
//
//  Created by Juan on 22/06/22.
//

import XCTest
@testable import MercadoLibre

class HomeRouterMock: HomeRouterProtocol {
    var viewController: UIViewController?
    var createdModuleCalled = false
    var goToProductDetailCalled = false
    
    static func createModule() -> UIViewController {
        return UIViewController()
    }
    
    func goToProductDetail(productId: String) {
        goToProductDetailCalled = true
    }
}

class HomeInteractorMock: HomeInteractorInputProtocol {
    var presenter: HomeInteractorOutputProtocol?
    var getProductsCalled = false
    
    func getProducts(text: String, searchType: SearchType, offset: Int) {
        getProductsCalled = true
    }
}

class HomeViewMock: HomeViewProtocol {
    var presenter: HomePresenterProtocol?
    var displayProductsCalled = false
    var displayServiceErrorCalled = false
    var hideLoaderCalled = false
    
    func displayProducts(products: [ProductModel]) {
        displayProductsCalled = true
    }
    
    func displayServiceError() {
        displayServiceErrorCalled = true
    }
    
    func hideLoader() {
        hideLoaderCalled = true
    }
}

class HomePresenterMock: HomeInteractorOutputProtocol {
    var presentProducsCalled = false
    var presentServiceErrorCalled = false
    
    func presentProducs(products: [ProductModel], offset: Int, total: Int) {
        presentProducsCalled = true
    }
    
    func presentServiceError() {
        presentServiceErrorCalled = true
    }
}

struct HomeMockData {
    static let productModel = ProductModel(id: "MCO349813", name: "iPhone 13", thumbnailUrl: "", price: "123123", condition: .new, currencyId: "COP", freeShipping: true)
}
