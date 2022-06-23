//
//  ProductDetailInteractor.swift
//  MercadoLibre
//
//  Created by Juan on 22/06/22.
//

import Foundation

final class ProductDetailInteractor: ProductDetailInteractorInputProtocol {
    weak var presenter: ProductDetailInteractorOutputProtocol?
    
    var networking: ProductsClientNetworkingProtocol?
    
    init(_ networking: ProductsClientNetworkingProtocol) {
        self.networking = networking
    }
    
    func getProductDetailItem(productId: String) {
        networking?.getProductItem(productId: productId) { [weak self] product, responseType in
            switch responseType {
            case .success:
                let model = ProductDetailModel(
                    title: product?.title ?? Constants.emptyString,
                    imagesUrl: product?.pictures?.compactMap({$0.url}) ?? [],
                    description: Constants.emptyString,
                    price: product?.price?.formatted() ?? Constants.emptyString,
                    freeShipping: product?.shipping?.freeShipping ?? false,
                    currencyId: product?.currencyID ?? Constants.emptyString,
                    condition: product?.condition ?? .notSpecified,
                    address: "\(product?.sellerAddress?.city?.name ?? Constants.emptyString), \(product?.sellerAddress?.state?.name ?? Constants.emptyString)")
                self?.presenter?.presentProductDetailItem(product: model)
            default:
                self?.presenter?.presentServiceError()
            }

        }
    }
}
