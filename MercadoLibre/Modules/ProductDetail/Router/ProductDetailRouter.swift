//
//  ProductDetailRouter.swift
//  MercadoLibre
//
//  Created by Juan on 22/06/22.
//

import UIKit

final class ProductDetailRouter: ProductDetailRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModule(productId: String) -> UIViewController {
        let view = ProductDetailViewController()
        let presenter: ProductDetailPresenterProtocol & ProductDetailInteractorOutputProtocol = ProductDetailPresenter()
        let interactor: ProductDetailInteractorInputProtocol = ProductDetailInteractor(ProductsClientNetworking())
        let router: ProductDetailRouterProtocol = ProductDetailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.productId = productId
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
