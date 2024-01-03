//
//  CustomAlertView.swift
//  DesignKit
//
//  Created by Dikran Teymur on 3.01.2024.
//

import UIKit
import UtilityKit

public final class CustomAlertView: UIView {
    
    public weak var viewModel: CustomAlertViewModelProtocol?
    
    public var cancelButtonAction: VoidClosure?
    public var doneButtonAction: VoidClosure?
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .colorWhite
        view.layer.cornerRadius = 12
        view.addShadow()
        return view
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 12
        return stackView
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .fontSemiBold16
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .fontRegular12
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Vazgec", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tamam", for: .normal)
        button.setTitleColor(.colorBlack, for: .normal)
        return button
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureContents()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func set(viewModel: CustomAlertViewModelProtocol?) {
        self.viewModel = viewModel
        configureContents()
        configureButtons()
    }
}

// MARK: - UILayout
extension CustomAlertView {
    
    private func addSubviews() {
        addMainStackView()
        addButtonsStackView()
    }
    
    private func addMainStackView() {
        addSubview(mainStackView)
        mainStackView.edgesToSuperview(insets: .uniform(12))
        mainStackView.addArrangedSubview(headerLabel)
        mainStackView.addArrangedSubview(messageLabel)
    }
    
    private func addButtonsStackView() {
        mainStackView.addArrangedSubview(buttonsStackView)
        switch viewModel?.type {
        case .oneButton:
            buttonsStackView.addArrangedSubview(doneButton)
        case .twoButton:
            buttonsStackView.addArrangedSubview(cancelButton)
            buttonsStackView.addArrangedSubview(doneButton)
        default:
            return
        }
        doneButton.height(44)
        cancelButton.height(44)
    }
}

// MARK: - ConfigureContents
extension CustomAlertView {
    
    private func configureContents() {
        backgroundColor = .colorWhite
        layer.cornerRadius = 12
        addShadow()
        headerLabel.text = viewModel?.header
        messageLabel.text = viewModel?.message
    }
    
    private func configureButtons() {
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        addButtonsStackView()
    }
}

// MARK: - Actions
extension CustomAlertView {
    
    @objc
    private func cancelButtonTapped() {
        removeFromSuperview()
        cancelButtonAction?()
    }
    
    @objc
    private func doneButtonTapped() {
        removeFromSuperview()
        doneButtonAction?()
    }
}
