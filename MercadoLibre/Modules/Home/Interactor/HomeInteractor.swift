//
//  HomeInteractor.swift
//  MercadoLibre
//
//  Created by Juan on 17/06/22.
//

import Foundation

final class HomeInteractor: HomeInteractorInputProtocol {
    weak var presenter: HomeInteractorOutputProtocol?
    var networking: ProductsClientNetworkingProtocol?
    
    init(_ networking: ProductsClientNetworkingProtocol) {
        self.networking = networking
    }
    
    func getProducts(text: String, searchType: SearchType, offset: Int) {
        networking?.getProducts(text: text, searchType: searchType, offset: offset) { [weak self] products, responseType in
            switch responseType {
            case .success:
                let mappedProducts = products?.results?.compactMap({ product in
                    return ProductModel( id: product?.id ?? Constants.emptyString,name: product?.title ?? Constants.emptyString, thumbnailUrl: product?.thumbnail ?? Constants.emptyString, price: product?.price?.formatted() ?? Constants.emptyString, condition: product?.condition ?? .notSpecified, currencyId: product?.currencyID ?? Constants.emptyString,freeShipping: product?.shipping?.freeShipping ?? false)
                })
                self?.presenter?.presentProducs(products: mappedProducts ?? [],offset: offset,total: products?.paging?.total ?? mappedProducts?.count ?? .zero)
            default:
                self?.presenter?.presentServiceError()
            }
        }
    }
}
