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
        self.init(imageString: model.imageName, name: model.name, price: String(model.price ?? 0).appending(model.currency ?? ""), isLike: model.isLike)
    }
}
