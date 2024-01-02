//
//  Extension+NotificationCenter.swift
//  UtilityKit
//
//  Created by Dikran Teymur on 1.01.2024.
//

import Foundation

public extension NotificationCenter {

    static func addNotification(_ observer: Any, selector: Selector, name: Notification.Name?, object: Any? = nil) {
        self.default.addObserver(observer, selector: selector, name: name, object: object)
    }
    
    static func postNotification(name: Notification.Name, object: Any? = nil) {
        self.default.post(name: name, object: object)
    }
    
    static func removeNotification(_ observer: Any, name: Notification.Name, object: Any? = nil) {
        self.default.removeObserver(observer, name: name, object: object)
    }
}
