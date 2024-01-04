//
//  ProductDetailBuilder.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 2.01.2024.
//

import UIKit
import NetworkKit

final class ProductDetailBuilder {
    
    static func make(model: ProductModel) -> ProductDetailViewController {
        let viewModel = ProductDetailViewModel(model: model)
        return ProductDetailViewController(viewModel: viewModel)
    }
}
