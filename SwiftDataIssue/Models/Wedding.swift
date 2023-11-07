//
//  Wedding.swift
//  WeddMate
//
//  Created by Robin Kment on 11/24/21.
//

import Foundation
import CoreLocation
import SwiftData

@Model
final class Wedding: Codable, Identifiable, Hashable {
    @Attribute(.unique) let id: UUID
    let name: String
    
    @Transient
    var location: LocationPoint = .prague
    var weddingDate: Date
    let createdAt: Date
    let updatedAt: Date
    let userId: UUID
    var guests: [Guest]
    var budget: Budget?
    var timelines: [Timeline]
    var checklist: [ChecklistCategory]
    
    var selectedVendors: [String]
    var shortlistedVendors: [String]
    var weddingVendors: [SmallVendor]
    
    let user: UserInfo
    
    var sharedWith: [Share]
    
    internal init(
        id: UUID,
        name: String,
        location: LocationPoint,
        weddingDate: Date,
        createdAt: Date,
        updatedAt: Date,
        userId: UUID,
        guests: [Guest],
        budget: Budget? = nil,
        timelines: [Timeline],
        checklist: [ChecklistCategory],
        selectedVendors: [String],
        shortlistedVendors: [String],
        weddingVendors: [SmallVendor],
        user: UserInfo,
        sharedWith: [Share]
    ) {
        self.id = id
        self.name = name
        self.location = location
        self.weddingDate = weddingDate
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.userId = userId
        self.guests = guests
        self.budget = budget
        self.timelines = timelines
        self.checklist = checklist
        self.selectedVendors = selectedVendors
        self.shortlistedVendors = shortlistedVendors
        self.weddingVendors = weddingVendors
        self.user = user
        self.sharedWith = sharedWith
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case location
        case weddingDate
        case createdAt
        case updatedAt
        case userId
        case guests
        case budget
        case timelines
        case checklist
        case selectedVendors
        case shortlistedVendors
        case weddingVendors
        case user
        case sharedWith
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.location = try container.decode(LocationPoint.self, forKey: .location)
        self.weddingDate = try container.decode(Date.self, forKey: .weddingDate)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.userId = try container.decode(UUID.self, forKey: .userId)
        self.guests = try container.decode([Guest].self, forKey: .guests)
        self.budget = try container.decodeIfPresent(Budget.self, forKey: .budget)
        self.timelines = try container.decode([Timeline].self, forKey: .timelines)
        self.checklist = try container.decode([ChecklistCategory].self, forKey: .checklist)
        self.selectedVendors = try container.decode([String].self, forKey: .selectedVendors)
        self.shortlistedVendors = try container.decode([String].self, forKey: .shortlistedVendors)
        self.weddingVendors = try container.decode([SmallVendor].self, forKey: .weddingVendors)
        self.user = try container.decode(UserInfo.self, forKey: .user)
        self.sharedWith = try container.decode([Share].self, forKey: .sharedWith)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(location, forKey: .location)
        try container.encode(weddingDate, forKey: .weddingDate)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(userId, forKey: .userId)
        try container.encode(guests, forKey: .guests)
        try container.encode(budget, forKey: .budget)
        try container.encode(timelines, forKey: .timelines)
        try container.encode(checklist, forKey: .checklist)
        try container.encode(selectedVendors, forKey: .selectedVendors)
        try container.encode(shortlistedVendors, forKey: .shortlistedVendors)
        try container.encode(weddingVendors, forKey: .weddingVendors)
        try container.encode(user, forKey: .user)
        try container.encode(sharedWith, forKey: .sharedWith)
    }
}

extension Wedding {
    static var mock: Wedding {
        Wedding(
            id: UUID(),
            name: "Perfect Wedding",
            location: .prague,
            weddingDate: Date(timeIntervalSinceNow: 180*24*60*60),
            createdAt: .now,
            updatedAt: .now,
            userId: UUID(),
            guests: [],
            budget: nil,
            timelines: [],
            checklist: [],
            selectedVendors: [],
            shortlistedVendors: [],
            weddingVendors: [],
            user: .mock,
            sharedWith: []
        )
    }
}

extension Wedding {
    struct Request: Codable {
        let name: String
        let location: LocationPoint
        let weddingDate: Date
    }
    
    struct Post: Codable {
        let id: UUID
        let name: String
        let location: LocationPoint
        let weddingDate: String
        let createdAt: Date
        let updatedAt: Date
        let guests: [Guest]
        let budget: Budget?
        let timelines: [Timeline]
        let checklist: [ChecklistCategory]?
        let shortlistedVendors: [String]
        let selectedVendors: [String]
        let language: String?
    }
    
    struct CreateResponse: Codable {
        let id: UUID
        let name: String
        let location: LocationPoint
        let weddingDate: Date
        let createdAt: Date
        let updatedAt: Date
        let userId: UUID
    }
}


struct UserInfo: Codable {
    let email: String
    let id: UUID
}

extension UserInfo {
    static var mock: UserInfo {
        UserInfo(email: "info@weddmate.com", id: UUID())
    }
}

@Model
final class LocationPoint: Codable {
    let type: String
    let coordinates: [Double]
    
    init(longitude: Double, latitude: Double) {
        type = "Point"
        coordinates = [longitude, latitude]
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case coordinates
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.coordinates = try container.decode([Double].self, forKey: .coordinates)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(coordinates, forKey: .coordinates)
    }
}

extension LocationPoint {
    var longitude: Double {
        coordinates.first ?? 0.0
    }
    
    var latitude: Double {
        coordinates.last ?? 0.0
    }
}

extension LocationPoint {
    static let prague = LocationPoint(longitude: MapLocations.prague.longitude, latitude: MapLocations.prague.latitude)
}

enum MapLocations {
    static let prague = CLLocationCoordinate2D(latitude: 50.039261, longitude: 14.422247)
    static let sanFrancisco = CLLocationCoordinate2D(latitude: 37.773972, longitude: -122.431297)
}
