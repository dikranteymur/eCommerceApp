//
//  ProductListCollectionCellModel.swift
//  DesignKit
//
//  Created by Dikran Teymur on 1.01.2024.
//

import Foundation
import UtilityKit

public protocol ProductListCollectionCellModelEvents: AnyObject {
    var addBagAction: VoidClosure? { get }
}

public protocol ProductListCollectionCellModelDataSource: AnyObject {
    var imageString: String? { get }
    var name: String? { get }
    var price: String? { get }
    var isLike: Bool? { get }
}

public protocol ProductListCollectionCellModelProtocol: ProductListCollectionCellModelEvents, ProductListCollectionCellModelDataSource { }

public final class ProductListCollectionCellModel: ProductListCollectionCellModelProtocol {
    
    public var addBagAction: VoidClosure?
    
    public var imageString: String?
    public var name: String?
    public var price: String?
    public var isLike: Bool?
    
    init(imageString: String? = nil, name: String? = nil, price: String? = nil, isLike: Bool? = nil) {
        self.imageString = imageString
        self.name = name
        self.price = price
        self.isLike = isLike
    }
}

