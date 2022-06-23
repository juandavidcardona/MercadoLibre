//
//  HomeViewController.swift
//  MercadoLibre
//
//  Created by Juan on 17/06/22.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var searchBarView: UISearchBar!
    @IBOutlet private weak var searchTitleLabel: UILabel!
    @IBOutlet private weak var productsTableView: UITableView!
    @IBOutlet private weak var welcomeMessageLabel: UILabel!
    
    private var activityIndicator = UIActivityIndicatorView()
    private let segmentControlView = UISegmentedControl(items: [
        Strings.sortRelevant.localized,
        Strings.sortLowerPrice.localized,
        Strings.sortHeighterPrice.localized])
    private let activityIndicatorHeight: CGFloat = 60
    private let segmentControlHeight: CGFloat = 40

    private var searchActive = false
    private var products: [ProductModel] = []
    var presenter: HomePresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func onSearchButtonTapped(_ sender: Any) {
        searchProductsByText(searchBarView.text)
    }
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl!) {
        searchProductsByText(searchBarView.text)
        segmentControlView.selectedSegmentIndex = sender.selectedSegmentIndex
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        segmentControlView.selectedSegmentIndex = .zero
        searchButton.layer.cornerRadius = Constants.CornerRadius.large.rawValue
        welcomeMessageLabel.text = Strings.welcomeMessage.localized
        hideKeyboardWhenTappedAround()
        setupSearchBar()
        setupTableView()
    }
    
    private func setupTableView() {
        productsTableView.backgroundColor = UIColor.clear
        productsTableView.separatorStyle = .none
        productsTableView.register(
            UINib(nibName: ProductTableViewCell.identifier, bundle: Bundle.main),
            forCellReuseIdentifier: ProductTableViewCell.identifier)
        productsTableView.delegate = self
        productsTableView.dataSource = self
    }
    
    private func setupSearchBar() {
        searchBarView.delegate = self
        searchBarView.searchTextField.leftView = nil
        searchBarView.placeholder = Strings.searchPlaceholder.localized
        searchBarView.layer.borderColor = UIColor.lightGray.cgColor
        searchBarView.layer.borderWidth = Constants.BorderWidth.small.rawValue
        searchBarView.layer.cornerRadius = Constants.CornerRadius.medium.rawValue
        searchBarView.clipsToBounds = true
        searchBarView.searchTextField.backgroundColor = UIColor.clear
    }
    
    private func changeTitleAndButtonVisibility(_ visible: Bool) {
        UIView.animate(withDuration: Constants.Animation.generalAnimateDuration.rawValue) {
            self.searchTitleLabel.isHidden = !visible
        }
    }
    
    private func searchProductsByText(_ value: String?, clearProducts: Bool = true) {
        guard let text = value , text != Constants.emptyString else { return }
        if clearProducts {
            clearTableView()
        }
        activityIndicator.startAnimating()
        presenter?.searchProduct(
            text: text,
            type: SearchType.searchTypeFromInt(segmentControlView.selectedSegmentIndex),
            firstTime: true)
        changeTitleAndButtonVisibility(false)
        view.endEditing(true)
    }
    
    private func getMoreProducts() {
        guard let text = searchBarView.text , text != Constants.emptyString else { return }
        activityIndicator.startAnimating()
        presenter?.searchProduct(
            text: text ,
            type: SearchType.searchTypeFromInt(segmentControlView.selectedSegmentIndex),
            firstTime: false)
    }
    
    private func clearTableView() {
        products.removeAll()
        productsTableView.reloadData()
    }
}

// MARK: - HomeViewProtocol extension
extension HomeViewController: HomeViewProtocol {
    func displayProducts(products: [ProductModel]) {
        searchActive = true
        activityIndicator.stopAnimating()
        self.products = products
        productsTableView.reloadData()
        if productsTableView.cellForRow(at: IndexPath(row: .zero, section: .zero)) != nil {
            productsTableView.scrollToRow(
                at: IndexPath(row: .zero, section: .zero),
                at: .top, animated: true)
        }
    }
    
    func displayServiceError() {
        showAlert(
            title: Strings.generalErrorTitle.localized,
            message: Strings.generalErrorMessage.localized)
    }
    
    func hideLoader() {
        activityIndicator.stopAnimating()
    }
}

// MARK: - UISearchBarDelegate extension
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchProductsByText(searchBarView.text)
    }
}

// MARK: - UITableViewDataSource extension
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == (products.count - 2) {
            getMoreProducts()
        }
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductTableViewCell.identifier,
            for: indexPath) as? ProductTableViewCell else { return UITableViewCell()}
        cell.setupCell(products[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate extension
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToProductDetail(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return activityIndicator
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return activityIndicatorHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return searchActive ? segmentControlHeight : .zero
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        segmentControlView.backgroundColor = UIColor.systemGray6
        segmentControlView.addTarget(
            self,
            action: #selector(self.segmentedValueChanged(_:)), for: .valueChanged)
        let stackContainerView = UIStackView(arrangedSubviews: [
            segmentControlView, UIView()])
        stackContainerView.axis = .vertical
        return stackContainerView
    }
}
