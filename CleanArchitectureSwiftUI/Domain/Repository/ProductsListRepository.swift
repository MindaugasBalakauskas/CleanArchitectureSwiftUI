//
//  ProductsListRepository.swift
//  CleanArchitectureSwiftUI
//
//  Created by Mindaugas Balakauskas on 01/02/2023.
//

import Foundation
import CoreData

protocol ProductsListRepository {
    func getProducts(for url:URL) async throws -> ProductData
}
