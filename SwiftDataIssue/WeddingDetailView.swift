//
//  WeddingDetailView.swift
//  SwiftDataIssue
//
//  Created by Robin Kment on 28.09.2023.
//

import SwiftUI

struct WeddingDetailView: View {
    var wedding: Wedding
    
    var body: some View {
        VStack {
            Text(wedding.createdAt, format: Date.FormatStyle(date: .numeric, time: .standard))
            Text(wedding.name)
            Text(String(wedding.guests.count))
            Text(String(wedding.budget?.estimatedAmount ?? 0))
        }
    }
}

#Preview {
    WeddingDetailView(wedding: Wedding(id: UUID(), name: "Hell", location: .init(longitude: 0, latitude: 0), weddingDate: .now, createdAt: .now, updatedAt: .now, userId: UUID(), guests: [], budget: nil, timelines: [], checklist: [], selectedVendors: [], shortlistedVendors: [], weddingVendors: [], user: .init(email: "", id: UUID()), sharedWith: []))
}
