//
//  ProductDetailView.swift
//  A2_iOS_eric_100556934
//
//  Created by Eric Laudrum on 4/9/26.
//

import SwiftUI


struct ProductDetailView: View{
    let product: Product
    
    var body: some View{
        List {
            Section(header: Text("Product Info")) {
                Text(product.productName ?? "No Name")
                    .font(.title)
                Text("Provider: \(product.productProvider ?? "N/A")")

                Text("Price: $\(product.productPrice, specifier: "%.2f")")
            }
            
            Section(header: Text("Description")) {
                Text(product.productDescription ?? "No description provided.")
            }
        }
        .navigationTitle("Details")
    }
}
