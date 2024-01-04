//
//  OrderConfirmationViewController.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 3.01.2024.
//

import UIKit
import DesignKit

final class OrderConfirmationViewController: BaseViewController<OrderConfirmationViewModel> {
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .fontSemiBold20
        label.textColor = .colorGray
        label.addShadow()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
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
        label.font = .fontRegular14
        label.textColor = .colorGray
        return label
    }()
    
    private let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.font = .fontSemiBold16
        label.textColor = .colorBlack
        return label
    }()
    
    private let miniCartLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let closeButton: UIButton = {
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
    }
}

// MARK: - UILayout
extension OrderConfirmationViewController {
    
    private func addSubviews() {
        addCloseButton()
        addMiniCartView()
        addMiniCartLabelStackView()
        addMessageLabel()
    }
    
    private func addMessageLabel() {
        view.addSubview(messageLabel)
        messageLabel.horizontalToSuperview(insets: .horizontal(20))
        messageLabel.centerYToSuperview()
    }
    
    private func addMiniCartView() {
        view.addSubview(miniCartView)
        miniCartView.horizontalToSuperview(insets: .horizontal(20))
        miniCartView.bottomToTop(of: closeButton)
    }
    
    private func addMiniCartLabelStackView() {
        miniCartView.addSubview(miniCartLabelStackView)
        miniCartLabelStackView.edgesToSuperview(insets: .uniform(10))
        [totalItemCountLabel, totalAmountLabel].forEach(miniCartLabelStackView.addArrangedSubview(_:))
    }
    
    private func addCloseButton() {
        view.addSubview(closeButton)
        closeButton.horizontalToSuperview(insets: .horizontal(20))
        closeButton.bottomToSuperview(usingSafeArea: true)
        closeButton.height(44)
    }
}


// MARK: - ConfigureContents
extension OrderConfirmationViewController {
    
    private func configureContents() {
        configureNavigationBar()
        configureMessageLabel()
        configureMiniCartView()
        configureCloseButton()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Siparisiniz Onaylandi"
    }
    
    private func configureMessageLabel() {
        messageLabel.text = "Siparisiniz basarili bir sekilde gerceklesti!"
    }
    
    private func configureMiniCartView() {
        totalItemCountLabel.text = viewModel.getCartTotalItems()
        totalAmountLabel.text = viewModel.getCartTotalAmount()
    }
    
    private func configureCloseButton() {
        closeButton.setTitle("Kapat", for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension OrderConfirmationViewController {
    
    @objc
    private func closeButtonTapped() {
        app.router.restartApp()
    }
}
