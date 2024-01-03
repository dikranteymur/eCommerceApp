//
//  CartInfoModel.swift
//  NetworkKit
//
//  Created by Dikran Teymur on 3.01.2024.
//

public struct CartInfoModel {
    public var totalItems: Int?
    public var totalAmount: Double?
    public var currency: String?
    
    public init(totalItems: Int? = nil, totalAmount: Double? = nil, currency: String? = "USD") {
        self.totalItems = totalItems
        self.totalAmount = totalAmount
        self.currency = currency
    }
}
