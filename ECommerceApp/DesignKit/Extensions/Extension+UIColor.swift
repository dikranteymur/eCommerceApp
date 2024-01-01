//
//  Extension+UIColor.swift
//  DesignKit
//
//  Created by Dikran Teymur on 1.01.2024.
//

import UIKit

public extension UIColor {
    
    private enum ColorNames: String {
        case white = "White"
        case black = "Black"
        case blue = "Blue"
        case gray = "Gray"
    }
    
    class var colorWhite: UIColor {
        return UIColor(named: ColorNames.white.rawValue) ?? .white
    }
    
    class var colorBlack: UIColor {
        return UIColor(named: ColorNames.black.rawValue) ?? .black
    }
    
    class var colorBlue: UIColor {
        return UIColor(named: ColorNames.blue.rawValue) ?? .blue
    }
    
    class var colorGray: UIColor {
        return UIColor(named: ColorNames.gray.rawValue) ?? .gray
    }
}
