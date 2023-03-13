//
//  ProductListViewModel.swift
//  CleanArchitectureSwiftUI
//
//  Created by Mindaugas Balakauskas on 01/02/2023.
//

import Foundation
import CoreData

@MainActor
class ProductListViewModel: ObservableObject{
    
    @Published var products: [Product] = []
    @Published var error: NetworkError?

    private let repository: ProductsListRepository
   
    init(repository: ProductsListRepository) {
        self.repository = repository
    }
    
   
    
    
}
extension ProductListViewModel: ProductListUseCase {
    
    func getDataForProducts(urlString: String, context: NSManagedObjectContext) async {
        guard let url = URL(string: urlString) else{
            DispatchQueue.main.async {
                self.error = .invalidURL
            }
            return
        }
        do {
            let productData = try await repository.getProducts(for: url)
            
                self.products = productData.products
                self.error = nil
            await self.saveDataIntoDB(context: context)
            
            
            
        }catch {
            DispatchQueue.main.async {
                self.error = NetworkError.dataNotFound
            }
        }
    }
    private func saveDataIntoDB(context: NSManagedObjectContext) async {
        //let coreDataRepository = ProductListCoreDataRepositoryImplemataion(context: context) //<- CoreData
        let realmRepository = ProductListRealmRepositoryImplemantaion()
        do {
            //try await coreDataRepository.saveProductList(products:products)
            try await realmRepository.saveProductList(products:products)
            //let result = try await coreDataRepository.getProductListFromDB()
            
            //print(result)
            print("DB save success")
        } catch {
            print("DB save failed")
        }
        
    }
}
