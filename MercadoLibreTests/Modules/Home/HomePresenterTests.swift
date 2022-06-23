//
//  HomePresenterTests.swift
//  MercadoLibreTests
//
//  Created by Juan on 22/06/22.
//

import XCTest
@testable import MercadoLibre

class HomePresenterTests: XCTestCase {

    var presenter: HomePresenter!
    var view = HomeViewMock()
    var interactor = HomeInteractorMock()
    var router = HomeRouterMock()
    
    override func tearDown() {
        presenter = nil
    }
    
    override func setUp() {
        presenter = HomePresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
        interactor.presenter = presenter
    }
    
    func testSearchProductNoFetch() {
        // Given When
        presenter.searchProduct(text: "Hi", type: .relevant, firstTime: false)
        // Then
        XCTAssert(view.hideLoaderCalled)
    }
    
    func testSearchProduct() {
        // Given When
        presenter.searchProduct(text: "Hi", type: .relevant, firstTime: true)
        // Then
        XCTAssert(interactor.getProductsCalled)
    }
    
    func testGoToProductDetail() {
        // Given
        presenter.presentProducs(products: [HomeMockData.productModel], offset: .zero, total: 500)
        // When
        presenter.goToProductDetail(index: .zero)
        // Then
        XCTAssert(router.goToProductDetailCalled)
        XCTAssert(view.displayProductsCalled)
    }
    
    func testPresentAppendProducts() {
        // Given When
        presenter.presentProducs(products: [HomeMockData.productModel], offset: 50, total: 500)
        // Then
        XCTAssert(view.displayProductsCalled)
        XCTAssert(presenter.products.contains(where: {$0.id == HomeMockData.productModel.id}))
    }
    
    func testPresentReplacingProducts() {
        // Given When
        presenter.presentProducs(products: [HomeMockData.productModel], offset: 0, total: 500)
        // Then
        XCTAssert(view.displayProductsCalled)
        XCTAssert(presenter.products.first?.id == HomeMockData.productModel.id)
    }
    
    func testPresentServiceError() {
        // Given When
        presenter.presentServiceError()
        // Then
        XCTAssert(view.displayServiceErrorCalled)
    }
}
