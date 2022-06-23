//
//  ProductDetailViewController.swift
//  MercadoLibre
//
//  Created by Juan on 22/06/22.
//

import UIKit

final class ProductDetailViewController: UIViewController {

    @IBOutlet private weak var locationImageView: UIImageView!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var conditionLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var productImagesScrollView: UIScrollView!
    @IBOutlet private weak var productImagesStackView: UIStackView!
    @IBOutlet private weak var imagesPageControl: UIPageControl!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var freeShippingImage: UIImageView!
    @IBOutlet private weak var freeShippingContainer: UIView!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    @IBOutlet private weak var freeShippingLabel: UILabel!
    
    var presenter: ProductDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(nil)
        presenter?.viewDidLoad()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    // MARK: - Private methods
    private func setupView(_ model: ProductDetailModel?) {
        freeShippingLabel.text = Strings.generalFreeShipping.localized
        locationImageView.image = Icons.location.icon
        freeShippingImage.image = Icons.freeShipping.icon
        locationImageView.isHidden = model?.address == nil
        freeShippingContainer.isHidden = !(model?.freeShipping ?? false)
        productImagesScrollView.delegate = self
        descriptionLabel.text = model?.description ?? Constants.emptyString
        priceLabel.text = "\(model?.currencyId ?? Constants.emptyString) \(model?.price ?? Constants.emptyString)"
        titleLabel.text = model?.title ?? Constants.emptyString
        conditionLabel.text = model?.condition.description ?? Constants.emptyString
        locationLabel.text = model?.address ?? Constants.emptyString
    }
    
    private func configureProductImagesStack(product: ProductDetailModel) {
        imagesPageControl.numberOfPages = product.imagesUrl.count
        imagesPageControl.currentPage = .zero
        
        for imageUrl in product.imagesUrl {
            let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: .zero, height: productImagesScrollView.frame.height)))
            imageView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
            imageView.download(from: imageUrl)
            productImagesStackView.addArrangedSubview(imageView)
        }
    }
}

// MARK: - ProductDetailViewProtocol extension
extension ProductDetailViewController: ProductDetailViewProtocol {
    func displayProductItemInfo(product: ProductDetailModel) {
        loader.stopAnimating()
        setupView(product)
        configureProductImagesStack(product: product)
    }
    
    func displayServiceError() {
        showAlert(
            title: Strings.generalErrorTitle.localized,
            message: Strings.generalErrorMessage.localized)
    }
}

// MARK: - UIScrollViewDelegate extension
extension ProductDetailViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / view.frame.width
        imagesPageControl.currentPage = Int(round(pageNumber))
    }
}
