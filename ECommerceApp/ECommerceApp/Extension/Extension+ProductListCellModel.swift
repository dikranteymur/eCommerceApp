//
//  Extension+ProductListCell.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 2.01.2024.
//

import DesignKit
import NetworkKit

extension ProductListCellModel {
    
    convenience init(model: ProductModel) {
        self.init(id: model.id, 
                  imageString: model.imageName,
                  name: model.name,
                  price: model.price,
                  isLike: model.isLike,
                  currency: model.currency,
                  count: model.count)
    }
}
