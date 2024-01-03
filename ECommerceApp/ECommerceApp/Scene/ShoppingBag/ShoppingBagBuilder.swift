//
//  ShoppingBagBuilder.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 2.01.2024.
//

import UIKit

final class ShoppingBagBuilder {
    
    static func make() -> ShoppingBagViewController {
        let viewModel = ShoppingBagViewModel()
        return ShoppingBagViewController(viewModel: viewModel)
    }
}
