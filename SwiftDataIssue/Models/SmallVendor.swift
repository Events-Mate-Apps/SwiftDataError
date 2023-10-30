//
//  SmallVendor.swift
//  WeddMate
//
//  Created by Robin Kment on 02.04.2023.
//

import Foundation
import SwiftData
import SimpleCodable

@Model
@Codable
final class SmallVendor: Codable, Identifiable {
    @Attribute(.unique) let id: UUID
    let createdAt: Date
    let updatedAt: Date
    let name: String
    let categories: [String]
    let email: String?
    let phone: String?
    let userId: String
    var weddingId: String
    
    @Relationship(deleteRule: .nullify, inverse: \Wedding.weddingVendors)
    var weddingVendor: Wedding?
    let imageUrl: String?
    let address: String?
    let webURL: String?
    
    internal init(
        id: UUID,
        createdAt: Date,
        updatedAt: Date,
        name: String,
        categories: [String],
        email: String? = nil,
        phone: String? = nil,
        userId: String,
        weddingId: String,
        imageUrl: String? = nil,
        address: String? = nil,
        webURL: String? = nil
    ) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.name = name
        self.categories = categories
        self.email = email
        self.phone = phone
        self.userId = userId
        self.weddingId = weddingId
        self.imageUrl = imageUrl
        self.address = address
        self.webURL = webURL
    }
}

extension SmallVendor {
    static var mock: SmallVendor {
        SmallVendor(
            id: UUID(),
            createdAt: .now,
            updatedAt: .now,
            name: "Villa Richter",
            categories: [String](),
            email: "info@villarichter.cz",
            phone: "777 777 777",
            userId: "",
            weddingId: "",
            imageUrl: nil,
            address: nil,
            webURL: nil
        )
    }
}
