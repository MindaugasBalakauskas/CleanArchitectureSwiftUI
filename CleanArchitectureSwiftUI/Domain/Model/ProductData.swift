//
//  ProductData.swift
//  CleanArchitectureSwiftUI
//
//  Created by Mindaugas Balakauskas on 01/02/2023.
//

import Foundation

struct ProductData: Codable{
    
    let products: [Product]
}

struct Product: Codable, Identifiable{
    
    let id, price:Int
    let title, description, brand:String
}
