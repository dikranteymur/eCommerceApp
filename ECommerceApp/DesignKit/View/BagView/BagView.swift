//
//  BagView.swift
//  DesignKit
//
//  Created by Dikran Teymur on 1.01.2024.
//

import UIKit

public protocol BagViewDelegate: AnyObject {
    func handleBagButtonForNavigation()
}

public final class BagView: UIView {
    
    public weak var delegate: BagViewDelegate?
    private weak var viewModel: BagViewModelProtocol?
    
    private lazy var bagButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "bag"), for: .normal)
        button.tintColor = .tintColor
        return button
    }()
    
    private lazy var bagTotalLabel: UILabel = {
        let label = UILabel()
        label.font = .fontRegular20
        label.textAlignment = .center
        label.textColor = .colorBlack
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureContens()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public var bagTotalNumber: Int = 0 {
        didSet {
            bagTotalLabel.text = adjustBagTotalLabelWith(bagTotalNumber: bagTotalNumber)
        }
    }
    
    public func setView(viewModel: BagViewModelProtocol?) {
        self.viewModel = viewModel
        configureBagTotalLabel()
    }
    
    #if DEBUG
    deinit {
        debugPrint("deinit \(self)")
    }
    #endif
}

// MARK: - UILayout
extension BagView {
    
    private func addSubviews() {
        addBagButton()
        addBagTotalLabel()
    }
    
    private func addBagButton() {
        addSubview(bagButton)
        bagButton.edgesToSuperview()
        bagButton.size(.init(width: 44, height: 44))
    }
    
    private func addBagTotalLabel() {
        bagButton.addSubview(bagTotalLabel)
        bagTotalLabel.centerInSuperview()
    }
}

// MARK: - ConfigureContens
extension BagView {
    
    private func configureContens() {
        configureBagButton()
        configureBagTotalLabel()
    }
    
    private func configureBagButton() {
        bagButton.addTarget(self, action: #selector(bagButtonTapped), for: .touchUpInside)
    }
    
    private func configureBagTotalLabel() {
        guard let bagTotalNumber = viewModel?.bagTotalNumber else { return }
        bagTotalLabel.text = adjustBagTotalLabelWith(bagTotalNumber: bagTotalNumber)
    }
}

// MARK: - Actions
extension BagView {
    
    @objc
    private func bagButtonTapped() {
        delegate?.handleBagButtonForNavigation()
    }
    
    @objc
    private func handleBagTotalNumber(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        if let number = userInfo["bagTotalNumber"] as? Int {
            bagTotalNumber = number
        }
    }
}

// MARK: - Helpers
extension BagView {
    
    private func adjustBagTotalLabelWith(bagTotalNumber: Int) -> String {
        switch bagTotalNumber {
        case 10...:
            return "+9"
        case 1...9:
            return String(bagTotalNumber)
        default:
            return ""
        }
    }
}
