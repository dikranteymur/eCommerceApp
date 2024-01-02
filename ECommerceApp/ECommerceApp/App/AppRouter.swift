//
//  AppRouter.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 1.01.2024.
//

import UIKit
import UtilityKit

final class AppRouter {
    let window: UIWindow
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window.overrideUserInterfaceStyle = .light
    }
    
    func startWith(viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func restartApp() {
        ProductCacheHelper.removeAll()
        let viewController = ProductListBuilder.make()
        let navigationController = UINavigationController(rootViewController: viewController)
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        guard let window = windowScene?.keyWindow, let rootViewController = window.rootViewController else { return }
        navigationController.view.frame = rootViewController.view.frame
        navigationController.view.layoutIfNeeded()
        UIView.transition(with: window, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.window.rootViewController = navigationController
        })
    }
}
