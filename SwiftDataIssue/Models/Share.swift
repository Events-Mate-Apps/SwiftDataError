//
//  Share.swift
//  WeddMate
//
//  Created by Robin Kment on 12.02.2023.
//

import Foundation
import SwiftData
import SimpleCodable

@Model
@Codable
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
