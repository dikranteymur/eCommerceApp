//
//  ProductListCell.swift
//  DesignKit
//
//  Created by Dikran Teymur on 1.01.2024.
//

import UIKit
import TinyConstraints

public protocol ProductListCellDelegate: AnyObject {
    func addToCart(id: Int)
    func handleIsLike(id: Int, isLike: Bool)
}

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
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        return button
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.font = .fontSemiBold16
        label.textColor = .tintColor
        label.numberOfLines = 2
        label.addShadow()
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .fontSemiBold12
        label.textColor = .tintColor
        label.addShadow()
        return label
    }()
    
    private let addToBagButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sepete Ekle", for: .normal)
        button.backgroundColor = .colorBlack.withAlphaComponent(0.85)
        button.layer.cornerRadius = 12
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
    public weak var delegate: ProductListCellDelegate?
    
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
        stackView.addArrangedSubview(addToBagButton)
        addToBagButton.height(44)
    }
    
    private func addLikeButton() {
        contentView.addSubview(likeButton)
        likeButton.topToSuperview()
        likeButton.trailingToSuperview()
        likeButton.size(.init(width: 32, height: 32))
    }
}

// MARK: - ConfigureContents
extension ProductListCell {
    
    private func configureContents() {
        productImageView.image = UIImage(named: viewModel?.imageString ?? "photo.fill.on.rectangle.fill")
        productNameLabel.text = viewModel?.name
        productPriceLabel.text = viewModel?.getPriceAndCurrency()
        addShadow()
        configureLikeButton()
        configureBagButton()
    }
    
    private func configureLikeButton() {
        if let isLike = viewModel?.isLike, isLike {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .tintColor
            likeButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = .colorGray
            likeButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    private func configureBagButton() {
        addToBagButton.addTarget(self, action: #selector(addToBagButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension ProductListCell {
    
    @objc
    private func likeButtonTapped() {
        guard let id = viewModel?.id, let isLike = viewModel?.isLike else { return }
        delegate?.handleIsLike(id: id, isLike: !isLike)
    }
    
    @objc
    private func addToBagButtonTapped() {
        guard let id = viewModel?.id else { return }
        delegate?.addToCart(id: id)
    }
}

