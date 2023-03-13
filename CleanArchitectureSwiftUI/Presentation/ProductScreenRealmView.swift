//
//  ProductScreenRealmView.swift
//  CleanArchitectureSwiftUI
//
//  Created by Mindaugas Balakauskas on 05/02/2023.
//

import SwiftUI
import RealmSwift

struct ProductScreenRealmView: View {
    @StateObject var viewModel: ProductListViewModel
    @ObservedResults(ProductRealmEntity.self) var realmArray
    @State var isErrorOccured: Bool
    @Environment(\.managedObjectContext) var context
    var body: some View {
        NavigationStack{
            VStack {
                if realmArray.isEmpty {
                    ProgressView().alert(isPresented: $isErrorOccured) {
                        Alert (title: Text (viewModel.error?
                            .localizedDescription ?? "Ooops"), message:
                                Text ("Something Went Wrong"), dismissButton:.default (Text ("Okay" )))
                    }
                } else {
                    List{
                        ForEach(realmArray) {productEntity in
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
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Crash") {
                                          fatalError("Crash was triggered") //<--Crash button added to test crashalytics
                                        }
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

struct ProductScreenRealmView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(viewModel: ProductListViewModel(repository: ProductsListRepositoryImplemenation(networkManger: NetworkManger())), isErrorOccured: false)
    }
}
