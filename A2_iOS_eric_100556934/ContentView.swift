//
//  ContentView.swift
//  A2_iOS_eric_100556934
//
//  Created by Eric Laudrum on 4/9/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    // Database context
    @Environment(\.managedObjectContext) private var viewContext
    
    // Fetch all products
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)], animation: .default)
    
    private var products: FetchedResults<Product>
    
    
    @State private var searchText = ""
    @State private var showingAddSheet = false
    
    var filteredProducts: [ Product ]{
        if searchText.isEmpty{
            return Array(products)
        } else{
            return products.filter {
                ($0.productName?.localizedCaseInsensitiveContains(searchText) ?? false) ||
                ($0.productDescription?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
    }
    
    
    var body: some View {
        NavigationStack{
            
            List{
                
                // Display first product in list
                if let firstProduct = products.first, searchText.isEmpty{
                    Section(header: Text("Feature")){
                        NavigationLink(destination: ProductDetailView(product: firstProduct)){
                            
                            VStack(alignment: .leading){
                                Text(firstProduct.productName ?? "product")
                                    .font(.headline)
                                Text(firstProduct.productDescription ?? "")
                                    .font(.subheadline)
                                    .lineLimit(2)
                            }
                        }
                    }
                }
                Section(header: Text("All Products")){
                    
                    ForEach(filteredProducts) { product in
                        NavigationLink{
                            ProductDetailView(product: product)
                        } label: {
                            VStack(alignment: .leading){
                                Text(product.productName ?? "product")
                                    .font(.headline)
                                Text(product.productDescription ?? "")
                                    .font(.subheadline)
                                    .lineLimit(2)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Sampler & Sequencers")
            
            .toolbar{
                ToolbarItem( placement: .navigationBarTrailing){
                    Button( action : {
                        showingAddSheet = true
                    }){
                        Image(systemName: "plus")
                    }
                }
            }
            
            .sheet(isPresented: $showingAddSheet){
                AddProductView()
            }
            .searchable(text: $searchText, prompt: "Search Products")
        }
    }
}



#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}


