//
//  Extension+ShoppingBagCellModel.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 3.01.2024.
//

import DesignKit
import NetworkKit

extension ShoppingBagCellModel {
    
    convenience init(model: ProductModel) {
        self.init(id: model.id, 
                  imageString: model.imageName,
                  name: model.name,
                  price: model.price,
                  currency: model.currency,
                  count: model.count)
    }
}
