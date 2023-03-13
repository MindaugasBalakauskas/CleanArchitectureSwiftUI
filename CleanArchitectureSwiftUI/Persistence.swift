//
//  Persistence.swift
//  CleanArchitectureSwiftUI
//
//  Created by Mindaugas Balakauskas on 03/02/2023.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController ()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
//        for
//            in 0..<10 {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date ()
//        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unsolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    let container: NSPersistentContainer
    init(inMemory: Bool = false) {
        container = NSPersistentContainer (name: "CoreDataDemo")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores (completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
