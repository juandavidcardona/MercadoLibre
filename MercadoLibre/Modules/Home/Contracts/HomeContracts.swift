//
//  HomeContracts.swift
//  MercadoLibre
//
//  Created by Juan on 17/06/22.
//

import Foundation
import UIKit

protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? {get set}
    func displayProducts(products: [ProductModel])
    func displayServiceError()
    func hideLoader()
}

protocol HomeInteractorInputProtocol: AnyObject {
    var presenter: HomeInteractorOutputProtocol? {get set}
    func getProducts(text: String, searchType: SearchType, offset: Int)
}

protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? {get set}
    var interactor: HomeInteractorInputProtocol? {get set}
    var router: HomeRouterProtocol? {get set}
    func searchProduct(text: String, type: SearchType, firstTime: Bool)
    func goToProductDetail(index: Int)
}

protocol HomeRouterProtocol: AnyObject {
    var viewController: UIViewController? {get set}
    static func createModule()-> UIViewController
    func goToProductDetail(productId: String)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func presentProducs(products: [ProductModel], offset: Int, total: Int)
    func presentServiceError()
}
