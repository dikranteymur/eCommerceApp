//
//  ProductModel.swift
//  NetworkKit
//
//  Created by Dikran Teymur on 1.01.2024.
//

import Foundation

public struct ProductModel: Decodable {
    var items: [ProductItemModel]?
}

public struct ProductItemModel: Decodable {
    var id: Int?
    var price: Double?
    var name: String?
    var category: String?
    var currency: String?
    var imageName: String?
    var color: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case price
        case name
        case category
        case currency
        case imageName = "image_name"
        case color
    }
}
