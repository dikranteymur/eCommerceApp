//
//  CustomCollectionFlowLayout.swift
//  DesignKit
//
//  Created by Dikran Teymur on 1.01.2024.
//

import UIKit

public final class CustomCollectionFlowLayout: UICollectionViewFlowLayout {
    
    public override init() {
        super.init()
        configure()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func prepare() {
        guard let collectionView = collectionView else { return }
        let itemWidth = (collectionView.bounds.width - minimumInteritemSpacing) / 2
        let itemHeight = itemWidth * 1.35
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        super.prepare()
    }
}

// MARK: - Configure
extension CustomCollectionFlowLayout {
    
    private func configure() {
        minimumLineSpacing = 12
        minimumInteritemSpacing = 12
        scrollDirection = .vertical
    }
}
