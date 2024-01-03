//
//  ProductDetailViewModel.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 2.01.2024.
//

import Foundation
import NetworkKit
import UtilityKit

protocol ProductDetailViewModelEvents: AnyObject {
    var updateLikeButton: BoolClosure? { get }
}

protocol ProductDetailViewModelDataSource: AnyObject {
    var model: ProductModel? { get }
    var isLike: Bool? { get }
    func didload()
    func getPriceAndCurrency() -> String
    func addToCart()
    func handleLikeButtonTapped()
}

protocol ProductDetailViewModelProtocol: ProductDetailViewModelEvents, ProductDetailViewModelDataSource {}

final class ProductDetailViewModel: BaseViewModel, ProductDetailViewModelProtocol {
    
    // Events
    var updateLikeButton: BoolClosure?
    
    // DataSource
    var model: ProductModel?
    var isLike: Bool? {
        return model?.isLike
    }
    
    init(model: ProductModel? = nil) {
        self.model = model
    }
    
    func didload() {
        guard let model = model, let isLike = model.isLike else {
            updateLikeButton?(false)
            return
        }
        updateLikeButton?(isLike)
    }
    
    func getPriceAndCurrency() -> String {
        let priceText = String(format: "%.2f", model?.price ?? 0)
        let currency = model?.currency ?? ""
        return "\(priceText) \(currency)"
    }
    
    func handleLikeButtonTapped() {
        guard let id = model?.id, let isLike = model?.isLike else { return }
        ProductCacheHelper.handleIsLikeStatus(id: id, isLike: !isLike)
        model = ProductCacheHelper.getProductModelFrom(id: id)
        updateLikeButton?(!isLike)
    }
    
    func addToCart() {
        guard let id = model?.id else { return }
        ProductCacheHelper.addToCart(id: id)
    }
}
