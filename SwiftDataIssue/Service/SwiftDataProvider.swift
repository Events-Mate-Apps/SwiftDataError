//
//  SwiftDataProvider.swift
//  SwiftDataIssue
//
//  Created by Robin Kment on 28.09.2023.
//

import Foundation
import SwiftData

actor SwiftDataProvider {
    private let schema = Schema(
        [
            Wedding.self,
            LocationPoint.self,
            Budget.self,
            BudgetItem.self,
            ChecklistCategory.self,
            ChecklistItem.self,
            Timeline.self,
            TimelineEvent.self,
            SmallVendor.self,
            Guest.self
        ]
    )
    
    @MainActor
    static let shared = SwiftDataProvider()
    
    private let inMemory: Bool
    
    init(inMemory: Bool = false) {
        self.inMemory = inMemory
        
        if inMemory {
            Guest.mocks.forEach { item in
                Task {
                    await MainActor.run {
                        container.mainContext.insert(item)
                    }
                }
            }
        }
    }
    
    @MainActor
    public lazy var container: ModelContainer = {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: inMemory)
            let container = try ModelContainer(for: schema, configurations: [configuration])
            return container
        } catch {
            fatalError("Error with SwiftData:\n \(error)\n\(error.localizedDescription)")
        }
    }()
}
 
actor BackgroundPersistence: ModelActor {
    nonisolated public  let modelContainer: ModelContainer
    nonisolated public let modelExecutor: any ModelExecutor
    nonisolated public let modelContext: ModelContext
    
    init(container: ModelContainer) {
        let context = ModelContext(container)
        modelExecutor = DefaultSerialModelExecutor(modelContext: context)
        modelContainer = container
        modelContext = context
    }

    func store(data: any PersistentModel) throws {
        modelContext.insert(data)
        try modelContext.save()
    }
}

