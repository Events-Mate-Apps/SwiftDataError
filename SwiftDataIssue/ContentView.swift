//
//  ContentView.swift
//  SwiftDataIssue
//
//  Created by Robin Kment on 28.09.2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    var viewModel = MyWeddingsViewModel()
    
    @Query private var items: [Wedding]
    
    var body: some View {
        NavigationSplitView {
            List {
                Text("Query number: \(items.count)")
                Text("VM number: \(viewModel.myWeddings.count)")

                ForEach(viewModel.myWeddings) { item in
                    NavigationLink {
                        WeddingDetailView(wedding: item)
                    } label: {
                        VStack {
                            Text(item.createdAt, format: Date.FormatStyle(date: .numeric, time: .standard))
                            Text(item.name)
                            Text(String(item.guests.count))
                        }
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        .refreshable {
            viewModel.loadWeddings()
        }
        .onAppear {
            viewModel.loadWeddings()
        }
    }

    private func getItems() {
        Task {
            do {
                let weddings = try await WeddingService().myWeddings
                
                for wedding in weddings {
                    modelContext.insert(wedding)
                }
                print(weddings)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Wedding.self, inMemory: true)
}
