//
//  ProductsListRepositoryImplementation.swift
//  CleanArchitectureSwiftUI
//
//  Created by Mindaugas Balakauskas on 01/02/2023.
//

import Foundation
import CoreData

final class ProductsListRepositoryImplemenation: ProductsListRepository {
    
        
        var networkManger: Networkable
        
        init (networkManger: Networkable){
            self.networkManger = networkManger
        }
        
        
    func getProducts(for url: URL) async throws -> ProductData {
        let data = try await self.networkManger.getDataFromAPI(url: url)
        let productData = try JSONDecoder().decode(ProductData.self, from: data)
        return productData

    }
    
}
    
    
    
