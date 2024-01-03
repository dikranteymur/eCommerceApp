//
//  ShoppingBagCellModel.swift
//  DesignKit
//
//  Created by Dikran Teymur on 3.01.2024.
//

import Foundation
import UtilityKit

public enum RemoveButtonStatus {
    case trash
    case minus
    case willRemove
}

public protocol ShoppingBagCellModelEvents: AnyObject {
}

public protocol ShoppingBagCellModelDataSource: AnyObject {
    var id: Int? { get }
    var imageString: String? { get }
    var name: String? { get }
    var price: Double? { get }
    var currency: String? { get }
    var count: Int? { get set }
}

public protocol ShoppingBagCellModelProtocol: ShoppingBagCellModelEvents, ShoppingBagCellModelDataSource {
    func getPriceAndCurrency() -> String
    func getTotalItemCount() -> String
    func handlePlusButton()
    func handleMinusOrRemoveButton()
    func minusOrRemoveButtonStatus() -> RemoveButtonStatus
}

public final class ShoppingBagCellModel: ShoppingBagCellModelProtocol {
    
    // DataSource
    public var id: Int?
    public var imageString: String?
    public var name: String?
    public var price: Double?
    public var currency: String?
    public var count: Int?
    
    public init(id: Int? = nil,
                imageString: String? = nil,
                name: String? = nil,
                price: Double? = nil,
                currency: String? = nil,
                count: Int? = nil) {
        self.id = id
        self.imageString = imageString
        self.name = name
        self.price = price
        self.currency = currency
        self.count = count
    }
    
    public func getPriceAndCurrency() -> String {
        let priceText = String(format: "%.2f", price ?? 0)
        let currency = currency ?? ""
        return "\(priceText) \(currency)"
    }
    
    public func getTotalItemCount() -> String {
        guard let count = count else { return "-" }
        return String(count)
    }
    
    public func handlePlusButton() {
        if let count = count {
            self.count = count + 1
        }
    }
    
    public func handleMinusOrRemoveButton() {
        if let count = count {
            self.count = count - 1
        }
    }
    
    public func minusOrRemoveButtonStatus() -> RemoveButtonStatus {
        switch count {
        case 0:
            return .willRemove
        case 1:
            return .trash
        default:
            return .minus
        }
    }
}
