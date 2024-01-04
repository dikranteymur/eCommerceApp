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
    func updateCartInfoModel() -> CartInfoModel?
    func getRowIndex(id: Int) -> IndexPath?
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
        return String("Adet: \(totalItems)")
    }
    
    func getCartTotalAmount() -> String? {
        guard let totalAmount = cartInfoModel?.totalAmount else { return "" }
        let amount = String(format: "%.2f", totalAmount)
        return "Toplam: \(amount) \(cartInfoModel?.currency ?? "")"
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
        ProductCacheHelper.removeFromCart(id: id)
        cartItems = ProductCacheHelper.getCart()
        reloadData?(cartItems.isEmpty)
    }
    
    func productModelForNavigate(id: Int) -> ProductModel? {
        return cartItems.first(where: { $0.id == id })
    }
    
    @discardableResult
    func updateCartInfoModel() -> CartInfoModel? {
        let cartItems = ProductCacheHelper.getCart()
        var totalItems: Int = 0
        var totalAmount: Double = 0
        cartItems.forEach { item in
            if let price = item.price, let count = item.count {
                totalAmount += Double(count) * price
            }
            if let count = item.count {
                totalItems += count
            }
        }
        cartInfoModel = CartInfoModel(totalItems: totalItems, totalAmount: totalAmount)
        return cartInfoModel
    }
    
    func getRowIndex(id: Int) -> IndexPath? {
        cartItems = ProductCacheHelper.getCart()
        if let index = cartItems.firstIndex(where: { $0.id == id }) {
            return IndexPath(row: index, section: 0)
        }
        return nil
    }
}
