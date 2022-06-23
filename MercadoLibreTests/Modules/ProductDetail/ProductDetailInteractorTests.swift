//
//  ProductDetailInteractorTests.swift
//  MercadoLibreTests
//
//  Created by Juan on 23/06/22.
//

import Foundation

import XCTest
@testable import MercadoLibre

class ProductDetailInteractorTests: XCTestCase {
    
    var view: ProductDetailViewMock?
    var interactor: ProductDetailInteractor?
    var presenter = ProductDetailPresenterMock()
    var networkMock = ProductNetworkingMock()
    
    override func setUp() {
        interactor = ProductDetailInteractor(networkMock)
        interactor?.presenter = presenter
    }
    
    func testGetProductItemSuccess() {
        // Given
        networkMock.configureNetworking(statusCode: 200, jsonFileName: "getProductItem200")
        //When
        interactor?.getProductDetailItem(productId: "MCO2342349")
        //Then
        XCTAssert(presenter.presentProductDetailItemCalled)
    }
    
    func testGetProductItemFailed() {
        // Given
        networkMock.configureNetworking(statusCode: 500, jsonFileName: "")
        //When
        interactor?.getProductDetailItem(productId: "MCO2342349")
        //Then
        XCTAssert(presenter.presentServiceErrorCalled)
    }
    
}
