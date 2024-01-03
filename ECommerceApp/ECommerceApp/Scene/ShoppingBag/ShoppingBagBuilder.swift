//
//  ShoppingBagBuilder.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 2.01.2024.
//

import UIKit
import NetworkKit

final class ShoppingBagBuilder {
    
    static func make(cartInfoModel: CartInfoModel?) -> ShoppingBagViewController {
        let viewModel = ShoppingBagViewModel(cartInfoModel: cartInfoModel)
        return ShoppingBagViewController(viewModel: viewModel)
    }
}
