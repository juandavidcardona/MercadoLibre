//
//  HomeRouter.swift
//  MercadoLibre
//
//  Created by Juan on 17/06/22.
//

import UIKit

final class HomeRouter: HomeRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = HomeViewController()
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
        let interactor: HomeInteractorInputProtocol = HomeInteractor(ProductsClientNetworking())
        let router: HomeRouterProtocol = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func goToProductDetail(productId: String) {
        viewController?.present(
            ProductDetailRouter.createModule(productId: productId),
            animated: true,
            completion: nil)
    }
}
