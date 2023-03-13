//
//  ProductsListUseCase.swift
//  CleanArchitectureSwiftUI
//
//  Created by Mindaugas Balakauskas on 01/02/2023.
//

import Foundation
import CoreData

protocol ProductListUseCase {
    func getDataForProducts(urlString: String, context: NSManagedObjectContext) async
}
