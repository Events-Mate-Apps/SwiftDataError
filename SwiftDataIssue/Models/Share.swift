//
//  Share.swift
//  WeddMate
//
//  Created by Robin Kment on 12.02.2023.
//

import Foundation
import SwiftData

@Model
final class Share: Codable, Identifiable {
    @Attribute(.unique) let id: UUID
    let email: String
    var budgetPermission: Permission
    var checklistPermission: Permission
    var guestsPermission: Permission
    var timelinesPermission: Permission
    var vendorsPermission: Permission
    let status: Status
    let weddingId: String
    
    @Relationship(deleteRule: .nullify, inverse: \Wedding.sharedWith)
    var weddingShare: Wedding?
    let userId: String?
    let createdAt: Date
    let updatedAt: Date
    
    internal init(
        id: UUID,
        email: String,
        budgetPermission: Permission,
        checklistPermission: Permission,
        guestsPermission: Permission,
        timelinesPermission: Permission,
        vendorsPermission: Permission,
        status: Status,
        weddingId: String,
        userId: String? = nil,
        createdAt: Date,
        updatedAt: Date
    ) {
        self.id = id
        self.email = email
        self.budgetPermission = budgetPermission
        self.checklistPermission = checklistPermission
        self.guestsPermission = guestsPermission
        self.timelinesPermission = timelinesPermission
        self.vendorsPermission = vendorsPermission
        self.status = status
        self.weddingId = weddingId
        self.userId = userId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case budgetPermission
        case checklistPermission
        case guestsPermission
        case timelinesPermission
        case vendorsPermission
        case status
        case weddingId
        case weddingShare
        case userId
        case createdAt
        case updatedAt
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.budgetPermission = try container.decode(Permission.self, forKey: .budgetPermission)
        self.checklistPermission = try container.decode(Permission.self, forKey: .checklistPermission)
        self.guestsPermission = try container.decode(Permission.self, forKey: .guestsPermission)
        self.timelinesPermission = try container.decode(Permission.self, forKey: .timelinesPermission)
        self.vendorsPermission = try container.decode(Permission.self, forKey: .vendorsPermission)
        self.status = try container.decode(Status.self, forKey: .status)
        self.weddingId = try container.decode(String.self, forKey: .weddingId)
        self.weddingShare = try container.decodeIfPresent(Wedding.self, forKey: .weddingShare)
        self.userId = try container.decodeIfPresent(String.self, forKey: .userId)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(email, forKey: .email)
        try container.encode(budgetPermission, forKey: .budgetPermission)
        try container.encode(checklistPermission, forKey: .checklistPermission)
        try container.encode(guestsPermission, forKey: .guestsPermission)
        try container.encode(timelinesPermission, forKey: .timelinesPermission)
        try container.encode(vendorsPermission, forKey: .vendorsPermission)
        try container.encode(status, forKey: .status)
        try container.encode(weddingId, forKey: .weddingId)
        try container.encode(weddingShare, forKey: .weddingShare)
        try container.encode(userId, forKey: .userId)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
    }
}

extension Share {
    static var mock: Share {
        let weddingId = UUID()
        return Share(
            id: UUID(),
            email: "info@weddmate.com",
            budgetPermission: .none,
            checklistPermission: .view,
            guestsPermission: .view,
            timelinesPermission: .view,
            vendorsPermission: .edit,
            status: .invited,
            weddingId: weddingId.uuidString,
            userId: nil,
            createdAt: .now,
            updatedAt: .now
        )
    }
}

enum Permission: String, Codable, CaseIterable {
    case view = "VIEW"
    case edit = "EDIT"
    case none = "NONE"
    
    var localized: String {
        self.rawValue.lowercased()
    }
}

enum Status: String, Codable, CaseIterable {
    case invited = "INVITED"
    case accepted = "ACCEPTED"
    case denied = "DENIED"
    
    var localized: String {
        self.rawValue.lowercased()
    }
}
