//
//  CustomButtonView.swift
//  DesignKit
//
//  Created by Dikran Teymur on 2.01.2024.
//

import UIKit
import TinyConstraints
import UtilityKit

public final class CommonButtonView: UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }
    
    public var buttonAction: VoidClosure?
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

// MARK: - ConfigureContents
extension CommonButtonView {
    
    private func configureContents() {
        addTarget(self, action: #selector(commonButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions
extension CommonButtonView {
    
    @objc
    private func commonButtonTapped() {
        buttonAction?()
    }
}
