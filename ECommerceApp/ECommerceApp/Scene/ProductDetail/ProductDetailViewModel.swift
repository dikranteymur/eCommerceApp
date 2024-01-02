//
//  ProductDetailViewModel.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 2.01.2024.
//

import Foundation
import NetworkKit

protocol ProductDetailViewModelEvents: AnyObject {
    
}

protocol ProductDetailViewModelDataSource: AnyObject {
    var model: ProductModel? { get }
    func getPriceAndCurrency() -> String
    func didload()
}

protocol ProductDetailViewModelProtocol: ProductDetailViewModelEvents, ProductDetailViewModelDataSource {}

final class ProductDetailViewModel: BaseViewModel, ProductDetailViewModelProtocol {
    
    var model: ProductModel?
    
    init(model: ProductModel? = nil) {
        self.model = model
    }
    
    func didload() {
        
    }
    
    func getPriceAndCurrency() -> String {
        let priceText = String(format: "%.2f", model?.price ?? 0)
        let currency = model?.currency ?? ""
        return "\(priceText) \(currency)"
    }
}
