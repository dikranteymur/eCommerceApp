//
//  Extension+UITableViewController.swift
//  DesignKit
//
//  Created by Dikran Teymur on 3.01.2024.
//

import UIKit
import UtilityKit

public extension UITableView {
    
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Cell not found: \(String(describing: T.self))")
        }
        return cell
    }
    
    func removeBacgroundView() {
        backgroundView = nil
    }
}

