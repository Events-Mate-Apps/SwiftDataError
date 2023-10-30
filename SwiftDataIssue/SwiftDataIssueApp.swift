//
//  SwiftDataIssueApp.swift
//  SwiftDataIssue
//
//  Created by Robin Kment on 28.09.2023.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataIssueApp: App {
    let sharedModelContainer: ModelContainer
    
    init() {
        sharedModelContainer = SwiftDataProvider.shared.container
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
