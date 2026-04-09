//
//  ContentView.swift
//  A2_iOS_eric_100556934
//
//  Created by Eric Laudrum on 4/9/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    
    // Fetch all products
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productName, ascending: true)], animation: .default)
    
    private var products: FetchedResults<Product>
    
    var body: some View {
        NavigationStack{
            
            List{
                ForEach(products) { product in
                    NavigationLink{
                        ProductDetailView(product: product) // TBD
                    } label: {
                        VStack(){
                            Text(product.productName ?? "product")
                                .font(.headline)
                        }
                        
                
                    }
                }
            }
        }
    
    }
}

#Preview {
    ContentView()
}
