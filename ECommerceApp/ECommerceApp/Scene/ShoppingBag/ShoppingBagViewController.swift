//
//  ShoppingBagViewController.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 2.01.2024.
//

import UIKit
import DesignKit

final class ShoppingBagViewController: BaseViewController<ShoppingBagViewModel> {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(ShoppingBagCell.self)
        return tableView
    }()
    
    private let miniCartView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorWhite
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let totalItemCountLabel: UILabel = {
        let label = UILabel()
        label.font = .fontRegular12
        label.textColor = .colorGray
        return label
    }()
    
    private let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .fontRegular12
        label.textColor = .colorBlack
        return label
    }()
    
    private let miniCartLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let orderConfirmationButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .tintColor
        button.setTitleColor(.colorWhite, for: .normal)
        button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        button.layer.cornerRadius = 12
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContents()
        subscribeViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.didLoad()
    }
}

// MARK: - UILayout
extension ShoppingBagViewController {
    
    private func addSubviews() {
        addOrderConfirmationButton()
        addMiniCartView()
        addMiniCartLabelStackView()
        addCartTableView()
    }
    
    private func addCartTableView() {
        view.addSubview(tableView)
        tableView.topToSuperview(usingSafeArea: true)
        tableView.horizontalToSuperview(insets: .horizontal(20))
        tableView.bottomToTop(of: miniCartView)
    }
    
    private func addMiniCartView() {
        view.addSubview(miniCartView)
        miniCartView.horizontalToSuperview(insets: .horizontal(20))
        miniCartView.bottomToTop(of: orderConfirmationButton)
    }
    
    private func addMiniCartLabelStackView() {
        miniCartView.addSubview(miniCartLabelStackView)
        miniCartLabelStackView.edgesToSuperview(insets: .uniform(10))
        [totalItemCountLabel, totalAmountLabel].forEach(miniCartLabelStackView.addArrangedSubview(_:))
    }
    
    private func addOrderConfirmationButton() {
        view.addSubview(orderConfirmationButton)
        orderConfirmationButton.horizontalToSuperview(insets: .horizontal(20))
        orderConfirmationButton.bottomToSuperview(usingSafeArea: true)
        orderConfirmationButton.height(44)
    }
}

// MARK: - ConfigureContents
extension ShoppingBagViewController {
    
    private func configureContents() {
        configureTableView()
        configureNavigationBar()
        configureMiniCartView()
        configureOrderConfirmationButton()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Sepetim"
    }
    
    private func configureMiniCartView() {
        totalItemCountLabel.text = viewModel.getCartTotalItems()
        totalAmountLabel.text = viewModel.getCartTotalAmount()
    }
    
    private func configureOrderConfirmationButton() {
        orderConfirmationButton.setTitle("Sepeti Onayla", for: .normal)
        orderConfirmationButton.addTarget(self, action: #selector(orderConfirmationButtonTapped), for: .touchUpInside)
    }
}

// MARK: - SubscribeViewModel
extension ShoppingBagViewController {
    
    private func subscribeViewModel() {
        
        viewModel.reloadData = { [weak self] isEmpty in
            guard let self = self else { return }
            if isEmpty {
                self.tableView.setCustomEmptyView(header: "Henuz sepetine urun eklemedin.",
                                                  info: "Urunleri sepetine eklemek icin gezinebilir ve sepetine her zaman urun ekleyebilirsin.",
                                                  buttontitle: "Devam Et") { [weak self] in
                    guard let self = self else { return }
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                tableView.removeBacgroundView()
            }
            self.tableView.reloadData()
        }
    }
}

// MARK: - Actions
extension ShoppingBagViewController {
  
    @objc
    private func orderConfirmationButtonTapped() {
        let cartInfoModel = viewModel.getCartInfoModel()
        if cartInfoModel.totalItems == 0 {
            showAlert(header: "Hata", message: "Sepetiniz bos oldugundan dolayi sepete onay veremezsiniz.")
        } else {
            app.router.navigateToOrderConfirmation(from: self, cartInfoModel: viewModel.getCartInfoModel())
        }
    }
}

// MARK: - UITableViewDelegate
extension ShoppingBagViewController: UITableViewDelegate {
    
    
}

// MARK: - UITableViewDataSource
extension ShoppingBagViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShoppingBagCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.setCell(viewModel: viewModel.cellForItemAt(indexPath: indexPath))
        cell.delegate = self
        return cell
    }
}

// MARK: - ShoppingBagCellDelegate
extension ShoppingBagViewController: ShoppingBagCellDelegate {
    
    func removeItemFromBag(id: Int) {
        viewModel.removeItemFor(id: id)
    }
    
    func navigateToProductDetail(id: Int) {
        if let model = viewModel.productModelForNavigate(id: id) {
            let viewController = ProductDetailBuilder.make(model: model)
            navigationController?.present(viewController, animated: true)
        }
    }
}
