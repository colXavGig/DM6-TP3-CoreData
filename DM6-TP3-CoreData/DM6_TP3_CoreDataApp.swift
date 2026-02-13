//
//  DM6_TP3_CoreDataApp.swift
//  DM6-TP3-CoreData
//
//  Created by Xavier Giguerre on 2026-02-12.
//

import SwiftUI

@main
struct DM6_TP3_CoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
