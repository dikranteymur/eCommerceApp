//
//  ProductListBuilder.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 2.01.2024.
//

import UIKit

final class ProductListBuilder {
    
    static func make() -> ProductListViewController {
        let viewModel = ProductListViewModel()
        let viewController = ProductListViewController(viewModel: viewModel)
        return viewController
    }
}
