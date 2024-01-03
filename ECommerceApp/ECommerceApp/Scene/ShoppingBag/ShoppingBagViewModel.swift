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
    var cartTotalItems: String? { get }
    var cartTotalAmount: Double { get }
    func didLoad()
    func cellForItemAt(indexPath: IndexPath) -> ShoppingBagCellModelProtocol?
    func removeItemFor(id: Int)
    func productModelForNavigate(id: Int) -> ProductModel?
}

protocol ShoppingBagViewModelProtocol: ShoppingBagViewModelEvents, ShoppingBagViewModelDataSource {}

final class ShoppingBagViewModel: BaseViewModel, ShoppingBagViewModelProtocol {
    
    // Events
    var reloadData: BoolClosure?
    
    // Privates
    private var cartItems: [ProductModel] = []
    
    // DataSource
    var cartTotalItems: String? {
        return String(cartItems.count)
    }
    
    var cartTotalAmount: Double {
        var sum: Double = 0
        cartItems.forEach { model in
            guard let price = model.price else { return }
            sum += price
        }
        return sum
    }
    
    func didLoad() {
        cartItems = ProductCacheHelper.getCart()
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
}
