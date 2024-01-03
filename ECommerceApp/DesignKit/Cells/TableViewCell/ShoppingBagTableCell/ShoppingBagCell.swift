//
//  ShoppingBagCell.swift
//  DesignKit
//
//  Created by Dikran Teymur on 3.01.2024.
//

import UIKit

public protocol ShoppingBagCellDelegate: AnyObject {
    func removeItemFromBag(id: Int)
    func navigateToProductDetail(id: Int)
}

public final class ShoppingBagCell: UITableViewCell {
    
    public var viewModel: ShoppingBagCellModelProtocol?
    public weak var delegate: ShoppingBagCellDelegate?
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.borderColor = UIColor.tintColor.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .fontRegular14
        label.textColor = .colorBlack
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .fontRegular12
        label.textColor = .colorGray
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = .tintColor
        return button
    }()
    
    private lazy var minusOrRemoveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        return button
    }()
    
    private lazy var itemCountLabel: UILabel = {
        let label = UILabel()
        label.font = .fontRegular16
        label.textColor = .colorGray
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .top
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func setCell(viewModel: ShoppingBagCellModelProtocol?) {
        self.viewModel = viewModel
        configureContents()
    }
}

// MARK: - UILayout
extension ShoppingBagCell {
    
    private func addSubviews() {
        addMainStackView()
        addLabelsStackView()
        addButtonsStackView()
    }
    
    private func addMainStackView() {
        contentView.addSubview(mainStackView)
        mainStackView.horizontalToSuperview()
        mainStackView.verticalToSuperview(insets: .vertical(10))
        mainStackView.addArrangedSubview(productImageView)
        mainStackView.addArrangedSubview(labelsStackView)
        mainStackView.addArrangedSubview(buttonsStackView)
        productImageView.size(.init(width: 84, height: 84))
        buttonsStackView.width(44)
    }
    
    private func addLabelsStackView() {
        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(priceLabel)
    }
    
    private func addButtonsStackView() {
        buttonsStackView.addArrangedSubview(plusButton)
        buttonsStackView.addArrangedSubview(itemCountLabel)
        buttonsStackView.addArrangedSubview(minusOrRemoveButton)
        plusButton.size(.init(width: 24, height: 24))
        minusOrRemoveButton.size(.init(width: 24, height: 24))
    }
}

// MARK: - ConfigureContents
extension ShoppingBagCell {
    
    private func configureContents() {
        selectionStyle = .none
        configureProductImageView()
        configureLabels()
        configurePlusButton()
        configureMinusOrRemoveButton()
    }
    
    private func configureProductImageView() {
        productImageView.image = UIImage(named: viewModel?.imageString ?? "photo.fill.on.rectangle.fill")
        productImageView.isUserInteractionEnabled = true
        productImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(productImageViewTapped)))
    }
    
    private func configureLabels() {
        nameLabel.text = viewModel?.name
        priceLabel.text = viewModel?.getPriceAndCurrency()
        itemCountLabel.text = viewModel?.getTotalItemCount()
        updateItemCountLabelAndButtons()
    }
    
    private func configurePlusButton() {
        plusButton.addTarget(self, action: #selector(pluseButtonTapped), for: .touchUpInside)
    }
    
    private func configureMinusOrRemoveButton() {
        minusOrRemoveButton.addTarget(self, action: #selector(minusOrRemoveButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension ShoppingBagCell {
    
    @objc
    private func pluseButtonTapped() {
        viewModel?.handlePlusButton()
        updateItemCountLabelAndButtons()
    }
    
    @objc
    private func minusOrRemoveButtonTapped() {
        viewModel?.handleMinusOrRemoveButton()
        updateItemCountLabelAndButtons()
    }
    
    @objc
    private func productImageViewTapped() {
        guard let id = viewModel?.id else { return }
        delegate?.navigateToProductDetail(id: id)
    }
}

// MARK: - Helpers
extension ShoppingBagCell {
    
    private func updateItemCountLabelAndButtons() {
        updateItemCountLabel()
        updateMinusOrRemoveButtonStatus()
    }
    
    private func updateItemCountLabel() {
        itemCountLabel.text = viewModel?.getTotalItemCount()
    }
    
    private func updateMinusOrRemoveButtonStatus() {
        switch viewModel?.minusOrRemoveButtonStatus() {
        case .trash:
            minusOrRemoveButton.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        case .minus:
            minusOrRemoveButton.setImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
        case .willRemove:
            guard let id = viewModel?.id else { return }
            delegate?.removeItemFromBag(id: id)
            return
        default:
            return
        }
    }
}
