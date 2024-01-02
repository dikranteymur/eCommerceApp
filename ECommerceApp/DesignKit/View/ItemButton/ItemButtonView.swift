//
//  ItemButtonView.swift
//  DesignKit
//
//  Created by Dikran Teymur on 2.01.2024.
//

import UIKit
import UtilityKit

public class ItemButtonView: UIView {
    
    private lazy var itemButton = UIButton(type: .system)
    
    public var backgroundImage: UIImage? {
        didSet {
            itemButton.setBackgroundImage(backgroundImage, for: .normal)
        }
    }
    
    // TODO: - Label ekle
    
    public var addButtonAction: VoidClosure?
    
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
extension ItemButtonView {
    
    private func addSubviews() {
        addItemButton()
    }
    
    private func addItemButton() {
        addSubview(itemButton)
        itemButton.edgesToSuperview()
    }
}

// MARK: - ConfigureContents
extension ItemButtonView {
    
    private func configureContents() {
        itemButton.addTarget(self, action: #selector(itemButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension ItemButtonView {
    
    @objc
    private func itemButtonTapped() {
        addButtonAction?()
    }
}
