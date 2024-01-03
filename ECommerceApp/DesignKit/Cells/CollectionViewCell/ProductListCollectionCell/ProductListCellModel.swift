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
    var price: String? { get }
    var isLike: Bool? { get set }
    var count: Int? { get set }
}

public protocol ProductListCellModelProtocol: ProductListCellModelEvents, ProductListCellModelDataSource { }

public final class ProductListCellModel: ProductListCellModelProtocol {
    
    public var id: Int?
    public var imageString: String?
    public var name: String?
    public var price: String?
    public var isLike: Bool?
    public var count: Int?
    
    public init(id: Int? = nil,
                imageString: String? = nil,
                name: String? = nil,
                price: String? = nil,
                isLike: Bool? = nil,
                count: Int? = nil) {
        self.id = id
        self.imageString = imageString
        self.name = name
        self.price = price
        self.isLike = isLike
        self.count = count
    }
}
