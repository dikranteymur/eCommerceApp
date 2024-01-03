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
    var cartTotalItems: IntClosure? { get }
    var cartInfoModel: AnyClosure<CartInfoModel>? { get }
}

protocol ProductListViewModelDataSource: AnyObject {
    var numberOfItemsInSection: Int { get }
    func didLoad()
    func cellForItemAt(indexPath: IndexPath) -> ProductListCellModelProtocol?
    func productItemModelAt(indexPath: IndexPath) -> ProductModel?
    func handleIsLike(id: Int, isLike: Bool)
    func addToCart(id: Int)
    func reloadProductModels()
    func getCartInfoModel() -> CartInfoModel
}

protocol ProductListViewModelProtocol: ProductListViewModelEvents, ProductListViewModelDataSource {}

final class ProductListViewModel: BaseViewModel, ProductListViewModelProtocol {
    
    // Privates
    private var productItemList: [ProductListCellModelProtocol] = []
    private var productModels: [ProductModel] = []
    
    // Events
    var reloadData: BoolClosure?
    var cartInfoModel: AnyClosure<CartInfoModel>?
    var numberOfItemsInSection: Int {
        return productItemList.count
    }
    
    var cartTotalItems: IntClosure?
    
    func didLoad() {
        fetchProductList()
        cartInfoModel?(getCartInfoModel())
    }
    
    func cellForItemAt(indexPath: IndexPath) -> ProductListCellModelProtocol? {
        return productItemList[indexPath.row]
    }
    
    func productItemModelAt(indexPath: IndexPath) -> ProductModel? {
        return productModels[indexPath.row]
    }

    private func fetchProductList() {
        network.fetchProductItems(model: [ProductModel].self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                if ProductCacheHelper.isSavedProductList() {
                    self.configureCellItems(result: ProductCacheHelper.getAllProductModels())
                } else {
                    ProductCacheHelper.saveAllProductModels(value: result)
                    self.configureCellItems(result: result)
                }
            case .failure(let error):
                print(error)
            }
            reloadData?(productItemList.isEmpty)
        }
    }
    
    func getCartInfoModel() -> CartInfoModel {
        let cart: [ProductModel] = ProductCacheHelper.getCart()
        var totalAmount: Double = 0
        cart.forEach({ totalAmount += $0.price ?? 0})
        return CartInfoModel(totalItems: cart.count, totalAmount: totalAmount)
    }
    
    func handleIsLike(id: Int, isLike: Bool) {
        ProductCacheHelper.handleIsLikeStatus(id: id, isLike: isLike)
//        productModels = ProductCacheHelper.getAllProductModels()
//        reloadData?(productModels.isEmpty)
    }
    
    func addToCart(id: Int) {
        ProductCacheHelper.addToCart(id: id)
        cartInfoModel?(getCartInfoModel())
    }
    
    func reloadProductModels() {
//        configureCellItems(result: ProductCacheHelper.getAllProductModels())
//        reloadData?(productModels.isEmpty)
    }
}

// MARK: - Configure
extension ProductListViewModel {
    
    private func configureCellItems(result: [ProductModel]) {
        let sortedResult = result.sorted { firstItem, secondItem in
            guard let firstPrice = firstItem.price, let secondPrice = secondItem.price else { return false }
            return firstPrice < secondPrice
        }
        productItemList.append(contentsOf: sortedResult.map({ ProductListCellModel(model: $0) }))
        productModels = sortedResult
    }
}
