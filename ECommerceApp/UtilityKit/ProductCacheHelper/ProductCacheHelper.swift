//
//  ProductCacheHelper.swift
//  UtilityKit
//
//  Created by Dikran Teymur on 2.01.2024.
//

import NetworkKit

public struct ProductCacheHelper {
    
    private enum CacheKeys: String {
        case forProductCache = "forProductCache"
        case forCartCache = "forCartCache"
        case forProductCacheIsSaved = "forProductCacheIsSaved"
    }
    
    // For Product Items
    @discardableResult
    public static func saveAllProductModels(value: [ProductModel]) -> [ProductModel] {
        saveData(model: value, forKey: .forProductCache)
        UserDefaults.standard.set(true, forKey: CacheKeys.forProductCacheIsSaved.rawValue)
        return getAllProductModels()
    }
    
    public static func getAllProductModels() -> [ProductModel] {
        return sort(items: getData(model: ProductModel.self, forKey: .forProductCache))
    }
    
    public static func getProductModelFrom(id: Int) -> ProductModel? {
        return getAllProductModels().first(where: { $0.id == id })
    }
    
    public static func handleIsLikeStatus(id: Int, isLike: Bool) {
        var tempProductModels = getAllProductModels()
        if let index = tempProductModels.firstIndex(where: { $0.id == id }){
            tempProductModels[index].isLike = isLike
        }
        saveData(model: tempProductModels, forKey: .forProductCache)
    }
    
    public static func isSavedProductList() -> Bool {
        return UserDefaults.standard.bool(forKey: CacheKeys.forProductCacheIsSaved.rawValue)
    }
    
    // TODO: - Deneme amacli tum product'lar silinecek
    public static func resetProductList() {
        UserDefaults.standard.set(false, forKey: CacheKeys.forProductCacheIsSaved.rawValue)
    }
    
    // For Cart Items
    public static func getCart() -> [ProductModel] {
        return sort(items: getData(model: ProductModel.self, forKey: .forCartCache))
    }
    
    @discardableResult
    public static func saveCart(value: [ProductModel]) -> [ProductModel] {
        saveData(model: value, forKey: .forCartCache)
        return getCart()
    }
    
    public static func addToCart(id: Int) {
        var cartItems = getCart()
        if let index = cartItems.firstIndex(where: { $0.id == id }) {
            if let count = cartItems[index].count {
                cartItems[index].count = count + 1
            } else {
                cartItems[index].count = 1
            }
        } else {
            if let model = getProductModelFrom(id: id) {
                var tempModel = model
                tempModel.count = 1
                cartItems.append(tempModel)
            }
        }
        saveData(model: cartItems, forKey: .forCartCache)
    }
    
    public static func removeFromCart(id: Int) {
        var cartItems = getCart()
        if let index = cartItems.firstIndex(where: { $0.id == id }) {
            if let count = cartItems[index].count, count > 1 {
                cartItems[index].count = count - 1
            } else {
                cartItems.remove(at: index)
            }
        }
        saveData(model: cartItems, forKey: .forCartCache)
    }

    public static func removeProductIsSaved() {
        UserDefaults.standard.removeObject(forKey: CacheKeys.forProductCacheIsSaved.rawValue)
    }
    
    public static func removeCart() {
        UserDefaults.standard.removeObject(forKey: CacheKeys.forCartCache.rawValue)
    }
    
    public static func removeAll() {
        UserDefaults.standard.removeObject(forKey: CacheKeys.forProductCache.rawValue)
        UserDefaults.standard.removeObject(forKey: CacheKeys.forProductCacheIsSaved.rawValue)
        UserDefaults.standard.removeObject(forKey: CacheKeys.forCartCache.rawValue)
    }
}

// MARK: - Helpers
extension ProductCacheHelper {
    
    private static func saveData<T: Encodable>(model: T, forKey: CacheKeys) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(model), forKey: forKey.rawValue)
    }
    
    private static func getData<T: Decodable>(model: T.Type, forKey: CacheKeys) -> [T] {
        guard let data = UserDefaults.standard.value(forKey: forKey.rawValue) as? Data,
              let models = try? PropertyListDecoder().decode([T].self, from: data) else { return [] }
        return models
    }
    
    private static func sort(items: [ProductModel]) -> [ProductModel] {
        return items.sorted { firstItem, secondItem in
            guard let firstPrice = firstItem.price, let secondPrice = secondItem.price else { return false }
            return firstPrice < secondPrice
        }
    }
}
