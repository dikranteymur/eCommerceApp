//
//  ShoppingBagViewModel.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 2.01.2024.
//

import Foundation
import UtilityKit
import NetworkKit
import DesignKit

protocol ShoppingBagViewModelEvents: AnyObject {
    var reloadData: BoolClosure? { get }
}

protocol ShoppingBagViewModelDataSource: AnyObject {
    var numberOfRowsInSection: Int? { get }
    var cartInfoModel: CartInfoModel? { get }
    func didLoad()
    func cellForItemAt(indexPath: IndexPath) -> ShoppingBagCellModelProtocol?
    func removeItemFor(id: Int)
    func productModelForNavigate(id: Int) -> ProductModel?
    func getCartInfoModel() -> CartInfoModel
}

protocol ShoppingBagViewModelProtocol: ShoppingBagViewModelEvents, ShoppingBagViewModelDataSource {}

final class ShoppingBagViewModel: BaseViewModel, ShoppingBagViewModelProtocol {
    
    // Events
    var reloadData: BoolClosure?
    
    // Privates
    private var cartItems: [ProductModel] = []
    
    // DataSource
    var cartInfoModel: CartInfoModel?
    
    init(cartInfoModel: CartInfoModel?) {
        self.cartInfoModel = cartInfoModel
    }
    
    func getCartTotalItems() -> String? {
        guard let totalItems = cartInfoModel?.totalItems else { return "" }
        return String(totalItems)
    }
    
    func getCartTotalAmount() -> String? {
        guard let totalAmount = cartInfoModel?.totalAmount else { return "" }
        let amount = String(format: "%.2f", totalAmount)
        return "\(amount) \(cartInfoModel?.currency ?? "")"
    }
    
    func didLoad() {
        cartItems = ProductCacheHelper.getCart()
        cartItems = cartItems.sorted { firstItem, secondItem in
            guard let firstPrice = firstItem.price, let secondPrice = secondItem.price else { return false }
            return firstPrice < secondPrice
        }
        reloadData?(cartItems.isEmpty)
    }
    
    var numberOfRowsInSection: Int? {
        return cartItems.count
    }
    
    func cellForItemAt(indexPath: IndexPath) -> ShoppingBagCellModelProtocol? {
        return ShoppingBagCellModel(model: cartItems[indexPath.row])
    }
    
    func removeItemFor(id: Int) {
        ProductCacheHelper.removeToCart(id: id)
        cartItems = ProductCacheHelper.getCart()
        reloadData?(cartItems.isEmpty)
    }
    
    func productModelForNavigate(id: Int) -> ProductModel? {
        return cartItems.first(where: { $0.id == id })
    }
    
    func getCartInfoModel() -> CartInfoModel {
        let cart: [ProductModel] = ProductCacheHelper.getCart()
        var totalAmount: Double = 0
        cart.forEach({ totalAmount += $0.price ?? 0})
        return CartInfoModel(totalItems: cart.count, totalAmount: totalAmount)
    }
}
