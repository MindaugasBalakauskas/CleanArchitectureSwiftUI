//
//  ProductListRealmRepositoryImplemantaion.swift
//  CleanArchitectureSwiftUI
//
//  Created by Mindaugas Balakauskas on 05/02/2023.
//

import Foundation
import RealmSwift

class ProductListRealmRepositoryImplemantaion: ProdtuctListRealmRepository {
    
    
    func saveProductList(products: [Product]) async throws {
        let realm = try! await Realm()
        DispatchQueue.main.async {
            products.forEach{ product in
                let entity = ProductRealmEntity ()
                entity.title = product.title
                entity.productDescription = product.description
                entity.price = Double(product.price)
                entity.brand = product.brand
                do {
                    try! realm.write{
                        realm.add(entity)
                    }
                } catch let error{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getProductListFromDB() async throws -> [ProductEntity] {
        return []
    }
    
}
