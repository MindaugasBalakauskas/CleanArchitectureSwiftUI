//
//  ContentView.swift
//  CleanArchitectureSwiftUI
//
//  Created by Mindaugas Balakauskas on 01/02/2023.
///
///Clean architecture
/// Core - Core conatins different Utility classes/ utilities that can be used by diffrent modules or base structure. Also the definations of some extension.
///
/// Data - UI Model, Viewmodel,network response and entity classes. Data local- some dabase classes. data -remote- any class which contains network operation. data repository- contains the exposingidata to domain layer.
///
/// Domain - This layer mainly describes what ur app/project does. it will contain business logic of app. usescase- single action, e.g geting data from data base/ or doing login/ just fetcing one api.
///
/// Presentation - Anything related to UI, view, viewcontroller any common views, viewmodel.
///
///

import SwiftUI
import CoreData

struct ProductListView: View {
    @StateObject var viewModel: ProductListViewModel
    @State var isErrorOccured: Bool
    @Environment (\.managedObjectContext) var context
//    @FetchRequest(
//            sortDescriptors: [],
//            animation: .default)
//    private var dbProductArray: FetchedResults<ProductEntity>
    @FetchRequest(entity: ProductEntity.entity(), sortDescriptors: [])
    var dbProductArray: FetchedResults<ProductEntity>
    var fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
    
    var body: some View {
        NavigationStack{
            VStack {
                if dbProductArray.isEmpty {
                    ProgressView().alert(isPresented: $isErrorOccured) {
                        Alert (title: Text (viewModel.error?
                            .localizedDescription ?? "Ooops"), message:
                                Text ("Something Went Wrong"), dismissButton:.default (Text ("Okay" )))
                    }
                } else {
                    List{
                        ForEach(dbProductArray) {productEntity in
                            NavigationLink{
                                EmptyView()
                            } label: {
                                Text(productEntity.title ?? "")
                            }
                        }
                    }.padding()
                    .navigationTitle("Product List")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                viewModel.products.removeAll()
                                //dbProductArray.removeAll()
                            }, label: {
                                Image (systemName: "arrow.clockwise.circle")
                            })
                        }
                    }
                }
            }.task {
                await viewModel.getDataForProducts(urlString: APIEndPoint.apiProdutcs, context: context)
                if viewModel.error != nil {
                    isErrorOccured = true
                }
            }.refreshable {
                await viewModel.getDataForProducts(urlString: APIEndPoint.apiProdutcs, context: context)
                if viewModel.error != nil {
                    isErrorOccured = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(viewModel: ProductListViewModel(repository: ProductsListRepositoryImplemenation(networkManger: NetworkManger())), isErrorOccured: false)
    }
}
