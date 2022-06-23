//
//  ProductDetailPresenter.swift
//  MercadoLibre
//
//  Created by Juan on 22/06/22.
//

import Foundation

final class ProductDetailPresenter: ProductDetailPresenterProtocol {
    var productId: String?
    weak var view: ProductDetailViewProtocol?
    var interactor: ProductDetailInteractorInputProtocol?
    var router: ProductDetailRouterProtocol?
    private var product: ProductDetailModel?
    
    func viewDidLoad() {
        guard let productId = productId else { return }
        interactor?.getProductDetailItem(productId: productId)
    }
}

extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    func presentProductDetailItem(product: ProductDetailModel) {
        view?.displayProductItemInfo(product: product)
    }
    
    func presentServiceError() {
        view?.displayServiceError()
    }
}
