//
//  ProductListCell.swift
//  DesignKit
//
//  Created by Dikran Teymur on 1.01.2024.
//

import UIKit
import TinyConstraints

public final class ProductListCell: UICollectionViewCell {
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .colorGray
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 22
        button.clipsToBounds = true
        return button
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = .fontSemiBold16
        label.textColor = .colorBlack
        label.numberOfLines = 2
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .fontRegular12
        label.textColor = .colorBlack
        return label
    }()
    
    private let addToBagButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sepete Ekle", for: .normal)
        return button
    }()
    
    private let addToBagButtonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorBlack.withAlphaComponent(0.85)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureContents()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public weak var viewModel: ProductListCellModelProtocol?
    
    public func setCell(viewModel: ProductListCellModelProtocol?) {
        self.viewModel = viewModel
        configureContents()
    }
}

// MARK: - UILayout
extension ProductListCell {
    
    private func addSubviews() {
        addProductImageView()
        addLikeButton()
        addStackView()
    }
    
    private func addProductImageView() {
        contentView.addSubview(productImageView)
        productImageView.edgesToSuperview()
    }
    
    private func addStackView() {
        contentView.addSubview(stackView)
        stackView.bottomToSuperview(offset: -8)
        stackView.horizontalToSuperview(insets: .horizontal(8))
        stackView.addArrangedSubview(productNameLabel)
        stackView.addArrangedSubview(productPriceLabel)
        stackView.addArrangedSubview(addToBagButtonBackgroundView)
        addToBagButtonBackgroundView.addSubview(addToBagButton)
        addToBagButton.centerXToSuperview()
        addToBagButton.verticalToSuperview(insets: .vertical(4))
    }
    
    private func addLikeButton() {
        contentView.addSubview(likeButton)
        likeButton.topToSuperview()
        likeButton.trailingToSuperview()
        likeButton.size(.init(width: 44, height: 44))
    }
}

// MARK: - ConfigureContents
extension ProductListCell {
    
    private func configureContents() {
        productImageView.image = UIImage(named: viewModel?.imageString ?? "empty_view")
        productNameLabel.text = viewModel?.name
        productPriceLabel.text = viewModel?.price
        configureLikeButton()
    }
    
    private func configureLikeButton() {
        if let isLike = viewModel?.isLike, isLike {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension ProductListCell {
    
    @objc
    private func likeButtonTapped() {
        configureLikeButton()
    }
}

