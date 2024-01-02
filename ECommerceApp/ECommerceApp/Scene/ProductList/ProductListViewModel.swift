//
//  ProductListViewModel.swift
//  ECommerceApp
//
//  Created by Dikran Teymur on 1.01.2024.
//

import Foundation
import UtilityKit
import NetworkKit
import DesignKit

protocol ProductListViewModelEvents: AnyObject {
    var reloadData: BoolClosure? { get }
}

protocol ProductListViewModelDataSource: AnyObject {
    var numberOfItemsInSection: Int { get }
    func cellForItemAt(indexPath: IndexPath) -> ProductListCellModelProtocol?
    func didLoad()
}

protocol ProductListViewModelProtocol: ProductListViewModelEvents, ProductListViewModelDataSource {}

final class ProductListViewModel: BaseViewModel, ProductListViewModelProtocol {
    
    // Privates
    private var productItemList: [ProductListCellModelProtocol] = []
    
    // Events
    var reloadData: BoolClosure?
    var numberOfItemsInSection: Int {
        return productItemList.count
    }
    
    func didLoad() {
        fetchProductList()
    }
    
    func cellForItemAt(indexPath: IndexPath) -> ProductListCellModelProtocol? {
        return productItemList[indexPath.row]
    }

    private func fetchProductList() {
        network.fetchProductItems(model: [ProductModel].self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.configureCellItems(result: result)
            case .failure(let error):
                print(error)
            }
            reloadData?(productItemList.isEmpty)
        }
    }
}

// MARK: - Configure
extension ProductListViewModel {
    
    private func configureCellItems(result: [ProductModel]) {
        productItemList.append(contentsOf: result.map({ ProductListCellModel(model: $0) }))
//        reloadData?(productItemList.isEmpty)
    }
}
