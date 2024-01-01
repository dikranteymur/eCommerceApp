//
//  Extension+UICollectionView.swift
//  DesignKit
//
//  Created by Dikran Teymur on 1.01.2024.
//

import UIKit

public extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func removeBacgroundView() {
        backgroundView = nil
    }
}
