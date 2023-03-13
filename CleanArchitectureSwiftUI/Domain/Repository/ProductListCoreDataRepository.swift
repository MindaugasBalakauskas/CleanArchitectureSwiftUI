//
//  ProductListCoreDataRepository.swift
//  CleanArchitectureSwiftUI
//
//  Created by Mindaugas Balakauskas on 03/02/2023.
//

import Foundation

protocol ProductListCoreDataRepository {
    func saveProductList (products: [Product]) async throws
    func getProductListFromDB () async throws -> [ProductEntity]
}
