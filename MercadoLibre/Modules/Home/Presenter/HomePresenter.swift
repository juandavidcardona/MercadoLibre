//
//  HomePresenter.swift
//  MercadoLibre
//
//  Created by Juan on 17/06/22.
//

import Foundation

final class HomePresenter: HomePresenterProtocol {
    
    var interactor: HomeInteractorInputProtocol?
    weak var view: HomeViewProtocol?
    var router: HomeRouterProtocol?
    var products: [ProductModel] = []

    private var loadingProducts = false
    private var totalProducts: Int = .zero

    func searchProduct(text: String, type: SearchType, firstTime: Bool) {
        guard !loadingProducts, firstTime || products.count < totalProducts else {
            view?.hideLoader()
            return
        }
        loadingProducts = true
        interactor?.getProducts(
            text: text,
            searchType: type,
            offset: firstTime ? .zero : products.count)
    }
    
    func goToProductDetail(index: Int) {
        router?.goToProductDetail(productId: products[index].id)
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func presentProducs(products: [ProductModel], offset: Int, total: Int) {
        totalProducts = total
        loadingProducts = false
        if offset == .zero {
            self.products = products
        } else {
            self.products.append(contentsOf: products)
        }
        view?.displayProducts(products: self.products)
    }
    
    func presentServiceError() {
        loadingProducts = false
        view?.displayServiceError()
    }
}
