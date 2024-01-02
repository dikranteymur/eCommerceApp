//
//  CustomButtonView.swift
//  DesignKit
//
//  Created by Dikran Teymur on 2.01.2024.
//

import UIKit
import TinyConstraints
import UtilityKit

public final class CommonButtonView: UIView {
    
    private var titlePaddingConstraints: Constraints?
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var commonButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureContents()
        subscribeViewModel()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public var addButtonAction: VoidClosure?
    
    public var buttonTitle: String? {
        didSet {
            commonButton.setTitle(buttonTitle, for: .normal)
        }
    }
    
    public var buttonTitleColor: UIColor? {
        didSet {
            commonButton.setTitleColor(buttonTitleColor, for: .normal)
        }
    }
    
    public var buttonBackgroundColor: UIColor? {
        didSet {
            backgroundView.backgroundColor = buttonBackgroundColor?.withAlphaComponent(0.85)
        }
    }
    
    public var buttonCornerRadius: CGFloat = 0 {
        didSet {
            backgroundView.layer.cornerRadius = buttonCornerRadius
            backgroundView.clipsToBounds = true
        }
    }
}

// MARK: - UILayout
extension CommonButtonView {
    
    private func addSubviews() {
        addBackgroundView()
        addCommonButton()
    }
    
    private func addBackgroundView() {
        addSubview(backgroundView)
        backgroundView.edgesToSuperview()
    }
    
    private func addCommonButton() {
        backgroundView.addSubview(commonButton)
        commonButton.horizontalToSuperview(insets: .horizontal(8))
        commonButton.verticalToSuperview(insets: .vertical(4))
    }
}

// MARK: - ConfigureContents
extension CommonButtonView {
    
    private func configureContents() {
        backgroundColor = .clear
        commonButton.addTarget(self, action: #selector(commonButtonTapped), for: .touchUpInside)
    }
}

// MARK: - SubscribeViewModel
extension CommonButtonView {
    
    private func subscribeViewModel() {
        
    }
}

// MARK: - Actions
extension CommonButtonView {
    
    @objc
    private func commonButtonTapped() {
        addButtonAction?()
    }
}
