//
//  ChecklistCategory.swift
//  WeddMate
//
//  Created by Robin Kment on 20.02.2023.
//

import Foundation
import SwiftData

@Model
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc
        case category
        case createdAt
        case updatedAt
        case budgetEstimate
        case isDone
        case isPinned
        case estimatedCost
        case position
        case image
        case weddingId
        case weddingCategory
        case tasks
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.desc = try container.decodeIfPresent(String.self, forKey: .desc)
        self.category = try container.decode(String.self, forKey: .category)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.budgetEstimate = try container.decodeIfPresent(Double.self, forKey: .budgetEstimate)
        self.isDone = try container.decode(Bool.self, forKey: .isDone)
        self.isPinned = try container.decode(Bool.self, forKey: .isPinned)
        self.estimatedCost = try container.decodeIfPresent(Double.self, forKey: .estimatedCost)
        self.position = try container.decode(Int.self, forKey: .position)
        self.image = try container.decode(HashImage.self, forKey: .image)
        self.weddingId = try container.decode(UUID.self, forKey: .weddingId)
        self.weddingCategory = try container.decodeIfPresent(Wedding.self, forKey: .weddingCategory)
        self.tasks = try container.decode([ChecklistItem].self, forKey: .tasks)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(desc, forKey: .desc)
        try container.encode(category, forKey: .category)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(budgetEstimate, forKey: .budgetEstimate)
        try container.encode(isDone, forKey: .isDone)
        try container.encode(isPinned, forKey: .isPinned)
        try container.encode(estimatedCost, forKey: .estimatedCost)
        try container.encode(position, forKey: .position)
        try container.encode(image, forKey: .image)
        try container.encode(weddingId, forKey: .weddingId)
        try container.encode(weddingCategory, forKey: .weddingCategory)
        try container.encode(tasks, forKey: .tasks)
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc
        case createdAt
        case openedAt
        case updatedAt
        case finishAt
        case isDone
        case isPinned
        case notes
        case percentInPlanning
        case position
        case action
        case vendors
        case categoryId
        case category
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.desc = try container.decodeIfPresent(String.self, forKey: .desc)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.openedAt = try container.decode(Date.self, forKey: .openedAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.finishAt = try container.decode(Date.self, forKey: .finishAt)
        self.isDone = try container.decode(Bool.self, forKey: .isDone)
        self.isPinned = try container.decode(Bool.self, forKey: .isPinned)
        self.notes = try container.decodeIfPresent(String.self, forKey: .notes)
        self.percentInPlanning = try container.decode(Double.self, forKey: .percentInPlanning)
        self.position = try container.decode(Int.self, forKey: .position)
        self.action = try container.decode(String.self, forKey: .action)
        self.vendors = try container.decodeIfPresent([String].self, forKey: .vendors)
        self.categoryId = try container.decode(UUID.self, forKey: .categoryId)
        self.category = try container.decodeIfPresent(ChecklistCategory.self, forKey: .category)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(desc, forKey: .desc)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(openedAt, forKey: .openedAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(finishAt, forKey: .finishAt)
        try container.encode(isDone, forKey: .isDone)
        try container.encode(isPinned, forKey: .isPinned)
        try container.encode(notes, forKey: .notes)
        try container.encode(percentInPlanning, forKey: .percentInPlanning)
        try container.encode(position, forKey: .position)
        try container.encode(action, forKey: .action)
        try container.encode(vendors, forKey: .vendors)
        try container.encode(categoryId, forKey: .categoryId)
        try container.encode(category, forKey: .category)
    }
}

extension ChecklistItem {
    static var mock: ChecklistItem {
        ChecklistItem(name: "Hello")
    }
}

@Model
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
    
    enum CodingKeys: String, CodingKey {
        case src
        case hash
        case position
        case alt
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.src = try container.decode(URL.self, forKey: .src)
        self.hash = try container.decode(String.self, forKey: .hash)
        self.position = try container.decodeIfPresent(Int.self, forKey: .position)
        self.alt = try container.decodeIfPresent(String.self, forKey: .alt)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(src, forKey: .src)
        try container.encode(hash, forKey: .hash)
        try container.encode(position, forKey: .position)
        try container.encode(alt, forKey: .alt)
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
