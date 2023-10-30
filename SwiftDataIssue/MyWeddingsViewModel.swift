//
//  MyWeddingsViewModel.swift
//  SwiftDataIssue
//
//  Created by Robin Kment on 28.09.2023.
//

import Foundation

@Observable
final class MyWeddingsViewModel {    
    var myWeddings: [Wedding] = []
        
    func loadWeddings() {
        Task {
            let weddings = try await WeddingService().myWeddings
            await MainActor.run {
                do {
                    try SwiftDataProvider.shared.container.mainContext.save()
                    self.myWeddings = weddings
                } catch {
                    print("Error: \(error) - \(error.localizedDescription)")
                }
            }
        }
    }
}
