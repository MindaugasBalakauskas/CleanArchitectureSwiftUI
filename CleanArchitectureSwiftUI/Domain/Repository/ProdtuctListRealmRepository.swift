//
//  ProdtuctListRealmRepository.swift
//  CleanArchitectureSwiftUI
//
//  Created by Mindaugas Balakauskas on 05/02/2023.
//
///Realm similar to core data but its third party
///its is supported by other mobile. platforms as well. Android as well
////Alternative to SQlite and coredata
///
//////Adavantages
///1. Its more simpler to use
///2.Performace= Its faster than coredata
///
///Coredata uses sqlite
///Realm uses- BinaryFolamat

import Foundation

protocol ProdtuctListRealmRepository {
    
    func saveProductList(products: [Product]) async throws
    func getProductListFromDB () async throws -> [ProductEntity]
}
