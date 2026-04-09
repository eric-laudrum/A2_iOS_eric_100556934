//  Persistence.swift
//  A2_iOS_eric_100556934
//
//  Created by Eric Laudrum on 4/9/26.
//

import CoreData

struct PersistenceController{
    
    // Database connection
    static let shared = PersistenceController()
    // Database file
    let container: NSPersistentContainer
    
    init(){
        // Point to ProductModel and prepare file for read/write
        container = NSPersistentContainer( name: "ProductModel")
        container.loadPersistentStores{
            (storeDescription, error) in
            
            // Handle database failure
            if let error = error as NSError? {
                fatalError("Error: \(error)")
            }
        }
        seedProductData()
    }
    
    func seedProductData(){
        let context = container.viewContext
        
        // Define fetch request
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        do{
            // Verify how many products already exist
            let productCount = try context.count(for: request)
            
            // Handle an empty catalogue (initial seeding)
            if productCount == 0{
                
                // Sample data
                let productSeedData = [
                    (
                        name: "MPC Sample",
                        description: "A portable, battery-powered sampler. It is designed as a budget-friendly competitor in the portable beatmaking market, often compared to the Roland SP-404 Mark II or Teenage Engineering KO2.",
                        price: 399.00,
                        provider: "Akai"
                    ),
                    (
                        name: "SP-404 MKII",
                        description: "The Legendary SP-404 Beat Maker with Some Serious Upgrades.",
                        price: 499.99,
                        provider: "Roland"
                    ),
                    (
                        name: "Maschine MK3",
                        description: "An industry-standard, USB-powered groove production system combining tactile hardware with powerful software.",
                        price: 599.99,
                        provider: "Native Instruments"
                    ),
                    (
                        name: "PO-33",
                        description: "A micro sampler with up to 40 sec sample memory and built-in microphone.",
                        price: 99.99,
                        provider: "Teenage Engineering"
                    ),
                    (
                        name: "OP-XY",
                        description: "The OP–XY is a powerful sequencer, synthesizer, and sampler. stack sounds on a 64-step grid, and create thousands of projects. tactile 24-key keyboard and a multi-out jack that lets you select one of four outputs.",
                        price: 2299.00,
                        provider: "Teenage Engineering"
                    ),
                    (
                        name: "OP-Z",
                        description: "OP–Z is an advanced fully portable 16-track sequencer and synthesizer, with a range of both sample based and synthesis based sounds. it's the world's first stand-alone sequencer of its kind, that lets you sequence music, visuals, lights and more.",
                        price: 499.00,
                        provider: "Teenage Engineering"
                    ),
                    (
                        name: "Octatrack MKII",
                        description: "Dynamic in name and nature: this is the ultimate sampler for recording sessions, creative kick-starts, and improvisational performances.",
                        price: 2299.00,
                        provider: "Elektron"
                    ),
                    (
                        name: "Maschine+",
                        description: "Standalone groovebox and sampler, combining an iconic workflow with premium sounds for production and performance.",
                        price: 999,
                        provider: "Native Instruments"
                    ),
                    (
                        name: "Maschine Mikro MK3",
                        description: "Meet MASCHINE MIKRO, your flexible, compact companion for making music with a laptop. Use it to tap out beats, play melodies, and build up tracks – fast, fun, and hands-on.",
                        price: 999,
                        provider: "Native Instruments"
                    ),
                    (
                        name: "Volca Sample",
                        description: "The volca sample is a sample sequencer that lets you edit and sequence up to 100 sample sounds in real time for powerful live performances.",
                        price: 2299.00,
                        provider: "Korg"
                    ),
                ]
                
                // Iterate through seed data and create products
                for item in productSeedData{
                    // Create a new product
                    let newProduct = Product(context: context)
                    
                    newProduct.productId = UUID()
                    newProduct.productName = item.name
                    newProduct.productDescription = item.description
                    newProduct.productPrice = item.price
                    newProduct.productProvider = item.provider
                }
                
                try context.save()
                print("Catalogue seeded with 10 products")
            }
        } catch{
            print("Error: \(error.localizedDescription)")
        }
    }

    
}


