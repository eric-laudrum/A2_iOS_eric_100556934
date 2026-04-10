//
//  AddProductView.swift
//  A2_iOS_eric_100556934
//
//  Created by Eric Laudrum on 4/9/26.
//

import SwiftUI
import CoreData


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
