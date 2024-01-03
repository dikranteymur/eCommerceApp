//
//  BaseViewController.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 1.01.2024.
//

import UIKit
import DesignKit
import UtilityKit

class BaseViewController<T: BaseViewModelProtocol>: UIViewController {
    
    var viewModel: T
    
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = setBackgroundColor()
    }
    
    func setBackgroundColor() -> UIColor {
        return .white
    }
    
    func showAlert(header: String?,
                   message: String?,
                   type: CustomAlertType = .oneButton,
                   cancelButtonAction: VoidClosure? = nil,
                   doneButtonAction: VoidClosure? = nil) {
        let alert = CustomAlertView()
        alert.set(viewModel: CustomAlertViewModel(header: header, message: message, type: type))
        alert.cancelButtonAction = cancelButtonAction
        alert.doneButtonAction = doneButtonAction
        view.addSubview(alert)
        alert.centerInSuperview()
        alert.horizontalToSuperview(insets: .horizontal(40))
    }
    
    #if DEBUG
    deinit {
        debugPrint("deinit \(self)")
    }
    #endif
}
