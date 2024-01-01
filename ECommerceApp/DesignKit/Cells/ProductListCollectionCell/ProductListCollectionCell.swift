//
//  ProductListCollectionCell.swift
//  DesignKit
//
//  Created by Dikran Teymur on 1.01.2024.
//

import UIKit
import TinyConstraints

public final class ProductListCollectionCell: UICollectionViewCell {
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .tintColor
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.layer.cornerRadius = 22
        button.clipsToBounds = true
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
    
    weak var viewModel: ProductListCollectionCellModelProtocol?
    
    public func setCell(viewModel: ProductListCollectionCellModelProtocol?) {
        self.viewModel = viewModel
        configureContents()
    }
}

// MARK: - UILayout
extension ProductListCollectionCell {
    
    private func addSubviews() {
        
    }
}

// MARK: - ConfigureContents
extension ProductListCollectionCell {
    
    private func configureContents() {
        
    }
}

