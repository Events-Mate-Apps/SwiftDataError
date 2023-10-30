//
//  ChecklistCategory.swift
//  WeddMate
//
//  Created by Robin Kment on 20.02.2023.
//

import Foundation
import SwiftData
import SimpleCodable

@Model
@Codable
final class ChecklistCategory: Codable, Identifiable {
    @Attribute(.unique) let id: UUID
    let name: String
    let desc: String?
    let category: String
    let createdAt: Date
    let updatedAt: Date
    let budgetEstimate: Double?
    let isDone: Bool
    let isPinned: Bool
    let estimatedCost: Double?
    var position: Int
    var image: HashImage
    let weddingId: UUID
    
    @Relationship(deleteRule: .cascade, inverse: \Wedding.checklist)
    var weddingCategory: Wedding?
    
    var tasks: [ChecklistItem]
    
    init(
        id: UUID,
        name: String,
        description: String,
        category: String,
        createdAt: Date,
        updatedAt: Date,
        budgetEstimate: Double?,
        estimatedCost: Double?,
        isDone: Bool,
        isPinned: Bool,
        position: Int,
        image: HashImage,
        tasks: [ChecklistItem],
        weddingId: UUID
    ) {
        self.id = id
        self.name = name
        self.desc = description
        self.category = category
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.budgetEstimate = budgetEstimate
        self.estimatedCost = estimatedCost
        self.position = position
        self.image = image
        self.tasks = tasks
        self.isDone = isDone
        self.isPinned = isPinned
        self.weddingId = weddingId
    }
}

extension ChecklistCategory {
    static var mock: ChecklistCategory {
        ChecklistCategory(
            id: UUID(),
            name: "",
            description: "",
            category: "",
            createdAt: .now,
            updatedAt: .now,
            budgetEstimate: nil,
            estimatedCost: nil,
            isDone: false,
            isPinned: false,
            position: 0,
            image: HashImage(src: URL(string: "")!, hash: "", position: 0),
            tasks: [],
            weddingId: UUID()
        )
    }
}

@Model
@Codable
final class ChecklistItem: Codable, Identifiable, Hashable {
    @Attribute(.unique) let id: UUID
    let name: String
    let desc: String?
    let createdAt: Date
    let openedAt: Date
    let updatedAt: Date
    var finishAt: Date
    var isDone: Bool
    var isPinned: Bool
    let notes: String?
    let percentInPlanning: Double
    var position: Int
    let action: String
    let vendors: [String]?
    let categoryId: UUID
    
    @Relationship(deleteRule: .nullify, inverse: \ChecklistCategory.tasks)
    var category: ChecklistCategory?
    
    internal init(
        id: UUID = UUID(),
        name: String,
        description: String = "",
        createdAt: Date = .now,
        updatedAt: Date = .now,
        openedAt: Date = .now,
        finishAt: Date = .now,
        vendors: [String]? = nil,
        isDone: Bool = false,
        isPinned: Bool = false,
        notes: String? = nil,
        percentInPlanning: Double = 10.5,
        position: Int = 0,
        action: String = "check",
        categoryId: UUID = UUID()
    )
    {
        self.id = id
        self.name = name
        self.desc = description
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.openedAt = openedAt
        self.finishAt = finishAt
        self.vendors = vendors
        self.percentInPlanning = percentInPlanning
        self.position = position
        self.action = action
        self.isDone = isDone
        self.isPinned = isPinned
        self.notes = notes
        self.categoryId = categoryId
    }
}

extension ChecklistItem {
    static var mock: ChecklistItem {
        ChecklistItem(name: "Hello")
    }
}

@Model
@Codable
public final class HashImage: Codable, Hashable {
    
    public let src: URL
    public let hash: String
    public let position: Int?
    public let alt: String?
        
    public init(src: URL, hash: String, position: Int, alt: String? = nil) {
        self.src = src
        self.hash = hash
        self.position = position
        self.alt = alt
    }
}

extension HashImage: Identifiable {
    public var id: String {
        src.absoluteString
    }
    static func mock(with src: String) -> HashImage {
        let hash = """
        /9j/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCAAEAAYDASIAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAAAAb/xAAfEAABAwMFAAAAAAAAAAAAAAABAAIDBBFBBQYSFCH/xAAVAQEBAAAAAAAAAAAAAAAAAAABBf/EABkRAAMAAwAAAAAAAAAAAAAAAAABEQIycf/aAAwDAQACEQMRAD8AntwsM9XpEE0kjouk54HIixDw3y2LYREUxuTgZ7M//9k=
        """
        let url = URL(string: src)!
        return HashImage(src: url, hash: hash, position: 0, alt: nil)
    }
}
