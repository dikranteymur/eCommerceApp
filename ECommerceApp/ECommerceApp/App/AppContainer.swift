//
//  AppContainer.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 1.01.2024.
//

import Foundation
import NetworkKit

let app = AppContainer()

final class AppContainer {
    let router = AppRouter()
    let network = NetworkKit()
}
