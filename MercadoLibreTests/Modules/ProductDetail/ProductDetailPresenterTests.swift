//
//  ProductDetailPresenterTests.swift
//  MercadoLibreTests
//
//  Created by Juan on 23/06/22.
//

import XCTest
@testable import MercadoLibre

class ProductDetailPresenterTests: XCTestCase {

    var presenter: ProductDetailPresenter!
    var view = ProductDetailViewMock()
    var interactor = ProductDetailInteractorMock()
    var router = ProductDetailRouterMock()
    
    override func tearDown() {
        presenter = nil
    }
    
    override func setUp() {
        presenter = ProductDetailPresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter
        interactor.presenter = presenter
    }
    
    func testViewDidLoad() {
        // Given
        presenter.productId = "MCO234234"
        // When
        presenter.viewDidLoad()
        // Then
        XCTAssert(interactor.getProductDetailItemCalled)
    }
    
    func testPresentProductDetailItem() {
        // Given When
        presenter.presentProductDetailItem(product: ProductDetailMockData.productItem)
        // Then
        XCTAssert(view.displayProductItemInfoCalled)
    }
    
    func testPresentServiceError() {
        // Given When
        presenter.presentServiceError()
        // Then
        XCTAssert(view.displayServiceErrorCalled)
    }
}
