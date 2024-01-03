//
//  CustomAlertViewModel.swift
//  DesignKit
//
//  Created by Dikran Teymur on 3.01.2024.
//

import Foundation

public enum CustomAlertType {
    case oneButton
    case twoButton
}

public protocol CustomAlertViewModelEvents: AnyObject {
    
}

public protocol CustomAlertViewModelDataSource: AnyObject {
    var header: String? { get }
    var message: String? { get }
    var type: CustomAlertType? { get }
}

public protocol CustomAlertViewModelProtocol: CustomAlertViewModelEvents, CustomAlertViewModelDataSource {}

public final class CustomAlertViewModel: CustomAlertViewModelProtocol {
    
    // DataSource
    public var header: String?
    public var message: String?
    public var type: CustomAlertType?
    
    public init(header: String? = nil, message: String? = nil, type: CustomAlertType? = .oneButton) {
        self.header = header
        self.message = message
        self.type = type
    }
}
