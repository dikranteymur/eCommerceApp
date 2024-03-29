//
//  ProductModel.swift
//  NetworkKit
//
//  Created by Dikran Teymur on 1.01.2024.
//

public struct ProductModel: Codable {
    public let id: Int?
    public let price: Double?
    public let name: String?
    public let category: String?
    public let currency: String?
    public let imageName: String?
    public let color: String?
    public var isLike: Bool? = false
    public var count: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case price
        case name
        case category
        case currency
        case imageName = "image_name"
        case color
        case isLike = "is_like"
        case count
    }
}
