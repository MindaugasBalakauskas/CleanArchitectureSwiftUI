//
//  ProductListCoreDataRepositoryImplemataion.swift
//  CleanArchitectureSwiftUI
//
//  Created by Mindaugas Balakauskas on 03/02/2023.
//

import Foundation
import CoreData

final class ProductListCoreDataRepositoryImplemataion:
    ProductListCoreDataRepository{
    
    var context: NSManagedObjectContext
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    func saveProductList(products: [Product]) async throws {
        products.forEach{ product in
            let entity = ProductEntity (context: self.context)
            entity.title = product.title
            entity.productDescription = product.description
            entity.price = Double (product.price)
            entity.brand = product.brand
        }
        do {
            try context.save()
        } catch let error{
            print(error.localizedDescription)
            throw CoreDataError.savingError
        }
        
    }
    
    func getProductListFromDB() async throws -> [ProductEntity] {
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        do{
           let productsFromDB = try context.fetch(fetchRequest)
            print(productsFromDB)
            return productsFromDB
        } catch let error {
            print(error.localizedDescription)
            throw CoreDataError.gettingError
        }
        
    }
    
    
}
