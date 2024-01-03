//
//  Extension+UIFont.swift
//  DesignKit
//
//  Created by Dikran Teymur on 1.01.2024.
//

import UIKit

public extension UIFont {
    
    private enum FontNames: String {
        case thin = "Raleway-Thin"
        case regular = "Raleway-Regular"
        case semiBold = "Raleway-SemiBold"
    }
    
    // Thin font: 12
    class var fontThin12: UIFont {
        return UIFont(name: FontNames.thin.rawValue, size: 12) ?? .systemFont(ofSize: 12)
    }
    
    class var fontRegular12: UIFont {
        return UIFont(name: FontNames.regular.rawValue, size: 12) ?? .systemFont(ofSize: 12)
    }
    
    class var fontSemiBold12: UIFont {
        return UIFont(name: FontNames.semiBold.rawValue, size: 12) ?? .systemFont(ofSize: 12)
    }
    
    // Thin font: 14
    class var fontThin14: UIFont {
        return UIFont(name: FontNames.thin.rawValue, size: 14) ?? .systemFont(ofSize: 14)
    }
    
    class var fontRegular14: UIFont {
        return UIFont(name: FontNames.regular.rawValue, size: 14) ?? .systemFont(ofSize: 14)
    }
    
    class var fontSemiBold14: UIFont {
        return UIFont(name: FontNames.semiBold.rawValue, size: 14) ?? .systemFont(ofSize: 14)
    }

    // Thin font: 16
    class var fontThin16: UIFont {
        return UIFont(name: FontNames.thin.rawValue, size: 16) ?? .systemFont(ofSize: 16)
    }
    
    class var fontRegular16: UIFont {
        return UIFont(name: FontNames.regular.rawValue, size: 16) ?? .systemFont(ofSize: 16)
    }
    
    class var fontSemiBold16: UIFont {
        return UIFont(name: FontNames.semiBold.rawValue, size: 16) ?? .boldSystemFont(ofSize: 16)
    }
    
    
    // Thin font: 20
    class var fontThin20: UIFont {
        return UIFont(name: FontNames.thin.rawValue, size: 20) ?? .systemFont(ofSize: 20)
    }
    
    class var fontRegular20: UIFont {
        return UIFont(name: FontNames.regular.rawValue, size: 20) ?? .systemFont(ofSize: 20)
    }
    
    class var fontSemiBold20: UIFont {
        return UIFont(name: FontNames.semiBold.rawValue, size: 20) ?? .boldSystemFont(ofSize: 20)
    }
}
