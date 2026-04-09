//  Persistence.swift
//  A2_iOS_eric_100556934
//
//  Created by Eric Laudrum on 4/9/26.
//

import CoreData

struct PersistenceController{
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer( name: "ProductModel")
        container.loadPersistentStores{
            (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error: \(error)")
            }
        }
    }
}

