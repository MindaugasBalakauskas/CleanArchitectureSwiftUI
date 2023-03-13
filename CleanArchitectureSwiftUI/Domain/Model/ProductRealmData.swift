//
//  ProductRealmData.swift
//  CleanArchitectureSwiftUI
//
//  Created by Mindaugas Balakauskas on 05/02/2023.
//

import Foundation
import RealmSwift

class ProductRealmEntity: Object, ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var price: Double?
    @Persisted var title: String?
    @Persisted var productDescription: String?
    @Persisted var brand: String?
    
}
