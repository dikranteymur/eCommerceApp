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
    
    func setCustomEmptyView(header: String,
                            info: String?,
                            buttontitle: String?,
                            buttonBackgroundColor: UIColor = .tintColor,
                            buttonTintColor: UIColor = .colorGray,
                            action: VoidClosure?) {
        let emptyView = EmptyView()
        emptyView.addImage = UIImage(systemName: "photo.fill.on.rectangle.fill")
        emptyView.headerText = header
        emptyView.infoText = info
        emptyView.buttonTitle = buttontitle
        emptyView.buttonBackgroundColor = buttonBackgroundColor
        emptyView.buttonTitleColor = .colorGray
        emptyView.addButtonAction = action
        backgroundView = emptyView
    }
    
    func removeBacgroundView() {
        backgroundView = nil
    }
}

