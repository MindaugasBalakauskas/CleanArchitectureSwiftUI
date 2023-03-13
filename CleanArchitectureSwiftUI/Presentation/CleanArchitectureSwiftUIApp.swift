//
//  CleanArchitectureSwiftUIApp.swift
//  CleanArchitectureSwiftUI
//
//  Created by Mindaugas Balakauskas on 01/02/2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //initailized our firebase app
        FirebaseApp.configure()
        return true
    }
}
@main
struct CleanArchitectureSwiftUIApp: App {
    let persistenceController = PersistenceController.shared
 
// another option with less contorll
//    init(){
//        FirebaseApp.configure()
//    }
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            //            ProductListView(viewModel:ProductListViewModel(repository: ProductsListRepositoryImplemenation(networkManger:NetworkManger())), isErrorOccured: false)
            //                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            ProductScreenRealmView(viewModel:ProductListViewModel(repository: ProductsListRepositoryImplemenation(networkManger:NetworkManger())), isErrorOccured: false)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
