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
    
    
    var body: some View {
        NavigationStack{
            
            List{
                ForEach(products) { product in
                    NavigationLink{
                        ProductDetailView(product: product)
                    } label: {
                        VStack(){
                            Text(product.productName ?? "product")
                                .font(.headline)
                        }
                        
                
                    }
                }
            }
            .navigationTitle("Products")
        }
    
    }
}

struct ProductDetailView: View{
    let product: Product
    
    var body: some View{
        List {
                    Section(header: Text("Product Info")) {
                        Text(product.productName ?? "No Name")
                            .font(.title)
                        Text("Provider: \(product.productProvider ?? "N/A")")

                        Text("Price: $\(product.productPrice, specifier: "$.2f")")
                    }
                    
                    Section(header: Text("Description")) {
                        Text(product.productDescription ?? "No description provided.")
                    }
                }
                .navigationTitle("Details")
        
            }
        }


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}


