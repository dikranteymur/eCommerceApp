//
//  Extension+UIView.swift
//  DesignKit
//
//  Created by Dikran Teymur on 2.01.2024.
//

import UIKit
import UtilityKit

public extension UIView {
    
    func addShadow(_ color: UIColor = .colorBlack,
                   radius: CGFloat = 10,
                   offset: CGSize = CGSize(width: 0, height: 4), 
                   opacity: Float = 0.8) {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
    }
}
