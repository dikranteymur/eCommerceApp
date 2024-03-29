//
//  NetworkKit.swift
//  NetworkKit
//
//  Created by Dikran Teymur on 1.01.2024.
//

import Foundation

public protocol NetworkKitProtocol {
    func fetchProductItems<T: Decodable>(model: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

public class NetworkKit: NetworkKitProtocol {
    
    public init() {}
    
    public func fetchProductItems<T: Decodable>(model: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        if let url = Bundle.main.url(forResource: "Products", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
