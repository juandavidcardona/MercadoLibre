//
//  ProductDetailContracts.swift
//  MercadoLibre
//
//  Created by Juan on 22/06/22.
//

import Foundation
import UIKit

protocol ProductDetailViewProtocol: AnyObject {
    var presenter: ProductDetailPresenterProtocol? {get set}
    func displayProductItemInfo(product: ProductDetailModel)
    func displayServiceError()
}

protocol ProductDetailInteractorInputProtocol: AnyObject {
    var presenter: ProductDetailInteractorOutputProtocol? {get set}
    func getProductDetailItem(productId: String)
}

protocol ProductDetailPresenterProtocol: AnyObject {
    var productId: String? {get set}
    var view: ProductDetailViewProtocol? {get set}
    var interactor: ProductDetailInteractorInputProtocol? {get set}
    var router: ProductDetailRouterProtocol? {get set}
    func viewDidLoad()
}

protocol ProductDetailRouterProtocol: AnyObject {
    var viewController: UIViewController? {get set}
    static func createModule(productId: String) -> UIViewController
}

protocol ProductDetailInteractorOutputProtocol: AnyObject {
    func presentProductDetailItem(product: ProductDetailModel)
    func presentServiceError()
}
