//
//  DM6_TP3_CoreDataApp.swift
//  DM6-TP3-CoreData
//
//  Created by Xavier Giguerre on 2026-02-12.
//

import SwiftUI
import SwiftData

@main
struct DM6_TP3_CoreDataApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
