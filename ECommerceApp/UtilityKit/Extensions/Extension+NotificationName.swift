//
//  Extension+NotificationName.swift
//  UtilityKit
//
//  Created by Dikran Teymur on 1.01.2024.
//

import Foundation

public extension Notification.Name {
    
    static let setBagTotalNumber = Notification.Name("set_bag_total_number")
    static let decreaseBagTotalNumber = Notification.Name("decrease_bag_total_number")
    static let resetBagTotalNumber = Notification.Name("reset_bag_total_number")
    static let reloadProductModels = Notification.Name("reload_product_models")
}
