//
//  BaseViewModel.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 1.01.2024.
//

import Foundation
import NetworkKit

protocol BaseViewModelProtocol {
    
}

class BaseViewModel: BaseViewModelProtocol {
    
    private let network: NetworkKitProtocol
    
    init(network: NetworkKitProtocol = app.network) {
        self.network = network
    }
    
    #if DEBUG
    deinit {
        debugPrint("deinit \(self)")
    }
    #endif
}
