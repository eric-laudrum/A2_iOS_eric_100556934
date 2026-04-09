//
//  A2_iOS_eric_100556934App.swift
//  A2_iOS_eric_100556934
//
//  Created by Eric Laudrum on 4/9/26.
//

import SwiftUI
import CoreData

@main
struct A2_iOS_eric_100556934App: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
