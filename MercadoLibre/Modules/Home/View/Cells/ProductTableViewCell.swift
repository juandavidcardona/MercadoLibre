//
//  ProductTableViewCell.swift
//  MercadoLibre
//
//  Created by Juan on 17/06/22.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var freeShippingLabel: UILabel!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var conditionLabel: UILabel!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var freeShippingContainer: UIStackView!
    @IBOutlet private weak var freeShippingImageView: UIImageView!
    
    @IBOutlet weak var mainView: UIView!
    
    static let identifier = "ProductTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    override func prepareForReuse() {
        setupCell()
    }

    private func setupCell() {
        backgroundColor = UIColor.clear
        selectionStyle = .none
        freeShippingContainer.isHidden = true
        freeShippingImageView.image = Icons.freeShipping.icon
        productNameLabel.text = Constants.emptyString
        priceLabel.text = Constants.emptyString
        conditionLabel.text = Constants.emptyString
        productImage.image = nil
        mainView.layer.cornerRadius = Constants.CornerRadius.medium.rawValue
        productImage.layer.cornerRadius = Constants.CornerRadius.medium.rawValue
        freeShippingLabel.text = Strings.generalFreeShipping.localized
    }
    
    func setupCell(_ model: ProductModel) {
        priceLabel.text = "\(model.currencyId) \(model.price)"
        productNameLabel.text = model.name
        productImage.download(from: model.thumbnailUrl)
        conditionLabel.text = model.condition.description
        freeShippingContainer.isHidden = !model.freeShipping
    }
}
