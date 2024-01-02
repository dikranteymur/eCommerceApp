//
//  ProductModel.swift
//  NetworkKit
//
//  Created by Dikran Teymur on 1.01.2024.
//

import Foundation

public struct ProductModel: Decodable {
    public let id: Int?
    public let price: Double?
    public let name: String?
    public let category: String?
    public let currency: String?
    public let imageName: String?
    public let color: String?
    public var isLike: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case price
        case name
        case category
        case currency
        case imageName = "image_name"
        case color
        case isLike
    }
}
