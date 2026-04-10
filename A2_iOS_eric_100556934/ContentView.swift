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



struct AddProductView: View{
    @Environment(\.managedObjectContext) private var viewContext
        @Environment(\.dismiss) var dismiss

        @State private var name = ""
        @State private var description = ""
        @State private var price = ""
        @State private var provider = ""
    
    var body: some View{
        NavigationStack{
            Form{
                TextField("Product Name", text: $name)
                TextField("Description", text: $description)
                TextField("Price", text: $price)
                    .keyboardType(.decimalPad)
                TextField("Provider", text: $provider)
            }
            .navigationTitle("New Product")
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        let newProduct = Product(context: viewContext)
                        newProduct.productId = UUID()
                        newProduct.productName = name
                        newProduct.productDescription = description
                        newProduct.productPrice = Double(price) ?? 0.0
                        newProduct.productProvider = provider
                        
                        try? viewContext.save()
                        dismiss()
                        
                    }
                }
                
                ToolbarItem( placement: .cancellationAction){
                    Button("Cancel"){ dismiss() }
                }
            }
        }
    }
    
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}


