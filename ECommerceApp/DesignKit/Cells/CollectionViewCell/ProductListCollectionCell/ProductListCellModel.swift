//
//  ProductListCellModel.swift
//  DesignKit
//
//  Created by Dikran Teymur on 1.01.2024.
//

import Foundation
import UtilityKit

public protocol ProductListCellModelEvents: AnyObject {
    
}

public protocol ProductListCellModelDataSource: AnyObject {
    var id: Int? { get }
    var imageString: String? { get }
    var name: String? { get }
    var price: Double? { get }
    var isLike: Bool? { get set }
    var count: Int? { get set }
    var currency: String? { get }
}

public protocol ProductListCellModelProtocol: ProductListCellModelEvents, ProductListCellModelDataSource { 
    func getPriceAndCurrency() -> String
}

public final class ProductListCellModel: ProductListCellModelProtocol {
    
    public var id: Int?
    public var imageString: String?
    public var name: String?
    public var price: Double?
    public var isLike: Bool?
    public var count: Int?
    public var currency: String?
    
    public init(id: Int? = nil,
                imageString: String? = nil,
                name: String? = nil,
                price: Double? = nil,
                isLike: Bool? = nil,
                currency: String? = nil, 
                count: Int? = nil) {
        self.id = id
        self.imageString = imageString
        self.name = name
        self.price = price
        self.isLike = isLike
        self.currency = currency
        self.count = count
    }
    
    public func getPriceAndCurrency() -> String {
        let priceText = String(format: "%.2f", price ?? 0)
        let currency = currency ?? ""
        return "\(priceText) \(currency)"
    }
}
