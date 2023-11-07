//
//  SmallVendor.swift
//  WeddMate
//
//  Created by Robin Kment on 02.04.2023.
//

import Foundation
import SwiftData

@Model
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case updatedAt
        case name
        case categories
        case email
        case phone
        case userId
        case weddingId
        case weddingVendor
        case imageUrl
        case address
        case webURL
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.name = try container.decode(String.self, forKey: .name)
        self.categories = try container.decode([String].self, forKey: .categories)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.weddingId = try container.decode(String.self, forKey: .weddingId)
        self.weddingVendor = try container.decodeIfPresent(Wedding.self, forKey: .weddingVendor)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        self.address = try container.decodeIfPresent(String.self, forKey: .address)
        self.webURL = try container.decodeIfPresent(String.self, forKey: .webURL)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(name, forKey: .name)
        try container.encode(categories, forKey: .categories)
        try container.encode(email, forKey: .email)
        try container.encode(phone, forKey: .phone)
        try container.encode(userId, forKey: .userId)
        try container.encode(weddingId, forKey: .weddingId)
        try container.encode(weddingVendor, forKey: .weddingVendor)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(address, forKey: .address)
        try container.encode(webURL, forKey: .webURL)
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
