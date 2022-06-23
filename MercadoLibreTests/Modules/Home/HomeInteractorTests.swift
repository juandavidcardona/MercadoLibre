//
//  HomeInteractorTests.swift
//  MercadoLibreTests
//
//  Created by Juan on 22/06/22.
//

import XCTest
@testable import MercadoLibre

class HomeInteractorTests: XCTestCase {
    
    var view: HomeViewMock?
    var interactor: HomeInteractor?
    var presenter = HomePresenterMock()
    var networkMock = ProductNetworkingMock()
    
    override func setUp() {
        interactor = HomeInteractor(networkMock)
        interactor?.presenter = presenter
    }
    
    func testGetProductsSuccess() {
        // Given
        networkMock.configureNetworking(statusCode: 200, jsonFileName: "getProducts200")
        // When
        interactor?.getProducts(text: "Hi", searchType: .relevant, offset: .zero)
        // Then
        XCTAssert(presenter.presentProducsCalled)
    }
    
    func testGetProductsFailed() {
        // Given
        networkMock.configureNetworking(statusCode: 500, jsonFileName: "")
        // When
        interactor?.getProducts(text: "Hi", searchType: .relevant, offset: .zero)
        // Then
        XCTAssert(presenter.presentServiceErrorCalled)
    }
}
