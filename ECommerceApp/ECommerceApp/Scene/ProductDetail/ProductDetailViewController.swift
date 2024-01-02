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
    
    private lazy var bagButton = CommonButtonView()
    
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
    }
}

// MARK: - UILayout
extension ProductDetailViewController {
    
    private func addSubviews() {
        addNavigationBar()
        addScrollView()
        addProductImageView()
        addInfoStackView()
        addBagButton()
    }
    
    private func addNavigationBar() {
//        configureNavBar()
        view.addSubview(navigationBar)
        navigationBar.edgesToSuperview(excluding: .bottom)
        navigationBar.height(48)
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.topToBottom(of: navigationBar)
        scrollView.edgesToSuperview(excluding: .top, usingSafeArea: true)
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
        scrollView.addSubview(bagButton)
        bagButton.topToBottom(of: infoStackView, offset: 20)
        bagButton.centerXToSuperview()
//        bagButton.size(.init(width: 120, height: 44))
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
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .colorGray
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.tintColor]
        navigationBar.standardAppearance = appearance
        let navigationItem = UINavigationItem(title: viewModel.model?.name ?? "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navigationRightItemButtonView)
        navigationBar.items = [navigationItem]
        
        // TODO: - navigationRightItemButtonView true-false 'a gore resmi degisecek
        navigationRightItemButtonView.backgroundImage = UIImage(systemName: "heart")
        navigationRightItemButtonView.addButtonAction = { [weak self] in
            guard let self = self else { return }
            print("Like Butonuna basildi")
        }
    }
    
    private func configureBagButton() {
        bagButton.buttonBackgroundColor = .colorBlack.withAlphaComponent(0.5)
        bagButton.buttonTitle = "Sepete Ekle"
        bagButton.buttonTitleColor = .tintColor
        bagButton.buttonCornerRadius = 12
        
        bagButton.addButtonAction = { [weak self] in
            guard let self = self else { return }
            print("Sepete Ekle Calisti")
        }
    }
    
    private func configureProductImageVie() {
        guard let model = viewModel.model else { return }
        productImageView.image = UIImage(named: model.imageName ?? "empty_image")
        nameLabel.text = model.name
        priceLabel.text = viewModel.getPriceAndCurrency()
        categoryLabel.text = model.category
    }
    
    private func configureColorView() {
        if let colorString = viewModel.model?.color {
            colorView.backgroundColor = UIColor(named: colorString)
        }
    }
}

// MARK: - SubscribeViewModel
extension ProductDetailViewController {
    
    private func subscribeViewModel() {
        
    }
}

// MARK: - Actions
extension ProductDetailViewController {
    

}
