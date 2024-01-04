//
//  OrderConfirmationBuilder.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 3.01.2024.
//

import UIKit
import NetworkKit

final class OrderConfirmationBuilder {
    
    static func make(cartInfoModel: CartInfoModel?) -> OrderConfirmationViewController {
        let viewModel = OrderConfirmationViewModel(cartInfoModel: cartInfoModel)
        return OrderConfirmationViewController(viewModel: viewModel)
    }
}
