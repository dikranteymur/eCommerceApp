//
//  OrderConfirmationViewModel.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 3.01.2024.
//

import Foundation
import NetworkKit

protocol OrderConfirmationViewModelEvents: AnyObject {
    
}

protocol OrderConfirmationViewModelDataSource: AnyObject {
    var cartInfoModel: CartInfoModel? { get }
    func getCartTotalItems() -> String?
    func getCartTotalAmount() -> String?
}

protocol OrderConfirmationViewModelProtocol: OrderConfirmationViewModelEvents, OrderConfirmationViewModelDataSource {}

final class OrderConfirmationViewModel: BaseViewModel, OrderConfirmationViewModelProtocol {
    
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
}
