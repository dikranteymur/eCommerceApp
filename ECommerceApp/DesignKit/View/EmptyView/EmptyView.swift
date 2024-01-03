//
//  EmptyView.swift
//  DesignKit
//
//  Created by Dikran Teymur on 3.01.2024.
//

import UIKit
import UtilityKit

public class EmptyView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.addShadow()
        imageView.size(.init(width: 44, height: 44))
        return imageView
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = .fontSemiBold20
        label.textColor = .colorBlack
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .fontRegular14
        label.textColor = .colorGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .tintColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    public var addButtonAction: VoidClosure?
    
    public var addImage: UIImage? {
        didSet {
            imageView.image = addImage
        }
    }
    
    public var headerText: String? {
        didSet {
            headerLabel.text = headerText
        }
    }
    
    public var infoText: String? {
        didSet {
            infoLabel.text = infoText
        }
    }
    
    public var buttonTitle: String? {
        didSet {
            button.setTitle(buttonTitle, for: .normal)
        }
    }
    
    public var buttonBackgroundColor: UIColor? {
        didSet {
            button.backgroundColor = buttonBackgroundColor
        }
    }
    
    public var buttonTitleColor: UIColor? {
        didSet {
            button.setTitleColor(buttonTitleColor, for: .normal)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureContents()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

// MARK: - UILayout
extension EmptyView {
    
    private func addSubviews() {
        addStackView()
    }
    
    private func addStackView() {
        addSubview(stackView)
        stackView.centerInSuperview()
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(headerLabel)
        stackView.addArrangedSubview(infoLabel)
        if addButtonAction != nil {
            stackView.addArrangedSubview(button)            
        }
        stackView.horizontalToSuperview(insets: .horizontal(40), usingSafeArea: true)
        button.size(.init(width: 80, height: 44))
    }
}

// MARK: - ConfigureContents
extension EmptyView {
    
    private func configureContents() {
        button.layer.cornerRadius = 12
        button.addShadow()
        buttonBackgroundColor = .tintColor
        buttonTitleColor = .colorWhite
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
}

extension EmptyView {
    
    @objc
    private func buttonTapped() {
        addButtonAction?()
    }
}
