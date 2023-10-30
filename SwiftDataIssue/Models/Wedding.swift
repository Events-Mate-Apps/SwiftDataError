//
//  Wedding.swift
//  WeddMate
//
//  Created by Robin Kment on 11/24/21.
//

import Foundation
import CoreLocation
import SwiftData
import SimpleCodable
d
@Codable
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
@Codable
final class LocationPoint: Codable {
    let type: String
    let coordinates: [Double]
    
    init(longitude: Double, latitude: Double) {
        type = "Point"
        coordinates = [longitude, latitude]
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
