//
//  ProductDetailViewController.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 2.01.2024.
//

import UIKit
import DesignKit

final class ProductDetailViewController: BaseViewController<ProductDetailViewModel> {
    
    private lazy var navigationBar = UINavigationBar()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.addShadow()
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .fontSemiBold20
        label.textColor = .colorBlack
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .fontRegular16
        label.textColor = .colorBlack
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    private lazy var addToBagButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .colorBlack.withAlphaComponent(0.85)
        button.setTitle("Sepete Ekle", for: .normal)
        button.tintColor = .tintColor
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .fontRegular12
        return label
    }()
    
    private lazy var colorView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.colorBlack.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var navigationRightItemButtonView = ItemButtonView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureContens()
        subscribeViewModel()
        viewModel.didload()
    }
}

// MARK: - UILayout
extension ProductDetailViewController {
    
    private func addSubviews() {
        addScrollView()
        addProductImageView()
        addInfoStackView()
        addBagButton()
    }
    
    private func addNavigationBar() {
        view.addSubview(navigationBar)
        navigationBar.edgesToSuperview(excluding: .bottom)
        navigationBar.height(48)
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.topToSuperview(usingSafeArea: true)
        scrollView.horizontalToSuperview()
        scrollView.bottomToSuperview()
    }
    
    private func addProductImageView() {
        scrollView.addSubview(productImageView)
        productImageView.edgesToSuperview(excluding: .bottom, usingSafeArea: true)
        productImageView.widthToSuperview()
        productImageView.heightToWidth(of: scrollView, multiplier: 1.10)
    }
    
    private func addInfoStackView() {
        scrollView.addSubview(infoStackView)
        infoStackView.topToBottom(of: productImageView, offset: 20)
        infoStackView.horizontalToSuperview(insets: .uniform(20))
        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.addArrangedSubview(priceLabel)
        infoStackView.addArrangedSubview(categoryLabel)
        infoStackView.addArrangedSubview(colorView)
        colorView.size(.init(width: 44, height: 44))
    }
    
    private func addBagButton() {
        scrollView.addSubview(addToBagButton)
        addToBagButton.topToBottom(of: infoStackView, offset: 20)
        addToBagButton.centerXToSuperview()
        addToBagButton.size(.init(width: 140, height: 44))
    }
}

// MARK: - ConfigureContents
extension ProductDetailViewController {
    
    private func configureContens() {
        configureNavBar()
        configureBagButton()
        configureProductImageVie()
        configureColorView()
    }
    
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navigationRightItemButtonView)
        navigationItem.title = viewModel.getProductName()
        navigationRightItemButtonView.addButtonAction = { [weak self] in
            guard let self = self else { return }
            self.viewModel.handleLikeButtonTapped()
        }
    }
    
    private func configureBagButton() {
        addToBagButton.addTarget(self, action: #selector(bagButtonTapped), for: .touchUpInside)
    }
    
    private func configureProductImageVie() {
        guard let model = viewModel.model else { return }
        productImageView.image = UIImage(named: model.imageName ?? "photo.fill.on.rectangle.fill")
        nameLabel.text = model.name
        priceLabel.text = viewModel.getPriceAndCurrency()
        categoryLabel.text = model.category
    }
    
    private func configureColorView() {
        if let colorString = viewModel.model?.color {
            colorView.backgroundColor = UIColor(named: colorString)
        }
    }
    
    private func updateIsLikeButton(isLike: Bool) {
        if isLike {
            navigationRightItemButtonView.backgroundImage = UIImage(systemName: "heart.fill")
            navigationRightItemButtonView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        } else {
            navigationRightItemButtonView.backgroundImage = UIImage(systemName: "heart")
            navigationRightItemButtonView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}

// MARK: - SubscribeViewModel
extension ProductDetailViewController {
    
    private func subscribeViewModel() {
        viewModel.updateLikeButton = { [weak self] isLike in
            guard let self = self else { return }
            self.updateIsLikeButton(isLike: isLike)
        }
    }
}

// MARK: - Actions
extension ProductDetailViewController {
    
    @objc
    private func bagButtonTapped() {
        viewModel.addToCart()
    }
}
