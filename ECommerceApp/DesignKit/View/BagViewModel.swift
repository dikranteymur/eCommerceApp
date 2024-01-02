//
//  BagViewModel.swift
//  DesignKit
//
//  Created by Dikran Teymur on 1.01.2024.
//

import Foundation
import UtilityKit

public protocol BagViewModelDataSource: AnyObject {
    var bagTotalNumber: Int { get set }
}

public protocol BagViewModelProtocol: BagViewModelDataSource {}

public final class BagViewModel: BagViewModelProtocol {
    
    public var bagTotalNumber: Int = 0
}
