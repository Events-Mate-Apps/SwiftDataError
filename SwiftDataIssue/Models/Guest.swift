//
//  Guest.swift
//  WeddMate
//
//  Created by Robin Kment on 31.10.2020.
//

import Foundation
import SwiftData

@Model
public final class Guest: Codable, Identifiable {
    @Attribute(.unique) public let id: UUID
    let weddingId: UUID = UUID()
    
    @Relationship(deleteRule: .nullify, inverse: \Wedding.guests)
    var weddingGuest: Wedding?
    let createdAt: Date = Date.now
    let updatedAt: Date = Date.now
    let email: String?
    let notes: String?
    let seat: String?
    let messageFromGuest: String?
    let firstName: String = ""
    let lastName: String = ""
    let phone: String?
    let address: Address?
    let postalAddress: String?
    let latitude: Double?
    let longitude: Double?
    let allergens: [String]?
    let diets: [String]?
    var age: GuestAge = GuestAge.adult
    var status: InvitationStatus = InvitationStatus.noResponse
    var needHotel: Bool = false
    let plusOneOptions: Int = 0
    
    internal init(
        id: UUID,
        weddingId: UUID,
        createdAt: Date,
        updatedAt: Date,
        email: String? = nil,
        notes: String? = nil,
        seat: String? = nil,
        messageFromGuest: String? = nil,
        firstName: String,
        lastName: String,
        phone: String? = nil,
        address: Address? = nil,
        postalAddress: String? = nil,
        latitude: Double? = nil,
        longitude: Double? = nil,
        allergens: [String]? = nil,
        diets: [String]? = nil,
        age: GuestAge,
        status: InvitationStatus,
        needHotel: Bool,
        plusOneOptions: Int
    ) {
        self.id = id
        self.weddingId = weddingId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.email = email
        self.notes = notes
        self.seat = seat
        self.messageFromGuest = messageFromGuest
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.address = address
        self.postalAddress = postalAddress
        self.latitude = latitude
        self.longitude = longitude
        self.allergens = allergens
        self.diets = diets
        self.age = age
        self.status = status
        self.needHotel = needHotel
        self.plusOneOptions = plusOneOptions
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case weddingId
        case weddingGuest
        case createdAt
        case updatedAt
        case email
        case notes
        case seat
        case messageFromGuest
        case firstName
        case lastName
        case phone
        case address
        case postalAddress
        case latitude
        case longitude
        case allergens
        case diets
        case age
        case status
        case needHotel
        case plusOneOptions
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.weddingId = try container.decode(UUID.self, forKey: .weddingId)
        self.weddingGuest = try container.decodeIfPresent(Wedding.self, forKey: .weddingGuest)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.notes = try container.decodeIfPresent(String.self, forKey: .notes)
        self.seat = try container.decodeIfPresent(String.self, forKey: .seat)
        self.messageFromGuest = try container.decodeIfPresent(String.self, forKey: .messageFromGuest)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        self.address = try container.decodeIfPresent(Address.self, forKey: .address)
        self.postalAddress = try container.decodeIfPresent(String.self, forKey: .postalAddress)
        self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        self.allergens = try container.decodeIfPresent([String].self, forKey: .allergens)
        self.diets = try container.decodeIfPresent([String].self, forKey: .diets)
        self.age = try container.decode(GuestAge.self, forKey: .age)
        self.status = try container.decode(InvitationStatus.self, forKey: .status)
        self.needHotel = try container.decode(Bool.self, forKey: .needHotel)
        self.plusOneOptions = try container.decode(Int.self, forKey: .plusOneOptions)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(weddingId, forKey: .weddingId)
        try container.encode(weddingGuest, forKey: .weddingGuest)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(email, forKey: .email)
        try container.encode(notes, forKey: .notes)
        try container.encode(seat, forKey: .seat)
        try container.encode(messageFromGuest, forKey: .messageFromGuest)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(phone, forKey: .phone)
        try container.encode(address, forKey: .address)
        try container.encode(postalAddress, forKey: .postalAddress)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(allergens, forKey: .allergens)
        try container.encode(diets, forKey: .diets)
        try container.encode(age, forKey: .age)
        try container.encode(status, forKey: .status)
        try container.encode(needHotel, forKey: .needHotel)
        try container.encode(plusOneOptions, forKey: .plusOneOptions)
    }
}

extension Guest {
    static let mock = Guest(
        id: UUID(),
        weddingId: UUID(),
        createdAt: .now,
        updatedAt: .now,
        email: nil,
        notes: nil,
        seat: nil,
        messageFromGuest: nil,
        firstName: "Robin",
        lastName: "Kment",
        phone: nil,
        address: nil,
        postalAddress: nil,
        latitude: nil,
        longitude: nil,
        allergens: nil,
        diets: nil,
        age: .adult,
        status: .confirmed,
        needHotel: false,
        plusOneOptions: 0
    )
    
    static let mocks = [
        Guest.mock
    ]
}

extension Guest {
    var fullName: String {
        firstName + " " + lastName
    }
}

struct Address: Codable {
    var name: String? // eg. Apple Inc.

    var thoroughfare: String? // street name, eg. Infinite Loop

    var subThoroughfare: String? // eg. 1

    var locality: String? // city, eg. Cupertino

    var subLocality: String? // neighborhood, common name, eg. Mission District

    var administrativeArea: String? // state, eg. CA

    var subAdministrativeArea: String? // county, eg. Santa Clara

    var postalCode: String? // zip code, eg. 95014

    var isoCountryCode: String? // eg. US

    var country: String? // eg. United States

    var inlandWater: String? // eg. Lake Tahoe

    var ocean: String? // eg. Pacific Ocean

    var areasOfInterest: [String]? // eg. Golden Gate Park

    var postalAddress: String?

    var getAddress: String {
        var addressString: String = ""

        addressString += thoroughfare ?? "" + ", "
        
        if let subThoroughfare = self.subThoroughfare {
            addressString += subThoroughfare + ", "
        }

        if let subLocality = self.subLocality {
            addressString += subLocality + ", "
        }

        if let locality = self.locality {
            addressString += locality + ", "
        }

        if let country = self.country {
            addressString += country + ", "
        }

        if let postalCode = self.postalCode {
            addressString += postalCode + " "
        }
        return addressString
    }
}

struct GuestNew: Codable, Identifiable {
    var id: String
    var firstName: String
    var lastName: String
    var email: String?
    var phone: String?
    var address: Address?
    var allergens: [String]?
    var diets: [String]?
    var wedding: UUID
    var linkedWith: [UUID]?
    var linkedBy: UUID?
    var invitedTo: [String]?
    var status: Int
    var seat: String?
    var needHotel: Bool
    var age: Int
    var selectedMenu: String?
    var notes: String?
    var messageFromGuest: String?
    var invitedBy: String?
    var plusOneOptions: Int
    var createdAt: Date?
    var updatedAt: Date?
}

extension GuestNew {
    public static var empty: GuestNew {
        GuestNew(id: UUID().uuidString,
                 firstName: "",
                 lastName: "",
                 email: nil,
                 phone: nil,
                 address: nil,
                 allergens: nil,
                 diets: nil,
                 wedding: UUID(), invitedTo: nil,
                 status: InvitationStatus.noResponse.rawValue,
                 seat: nil,
                 needHotel: false,
                 age: 0,
                 notes: "",
                 plusOneOptions: 0)
    }
}

extension Guest {
    struct Response: Codable, Identifiable {
        var id: String
        var firstName: String
        var lastName: String
        var email: String?
        var phone: String?
        var address: Address?
        var allergens: [String]?
        var diets: [String]?
        var weddingId: UUID?
        var linkedWith: [UUID]?
        var linkedBy: UUID?
        var invitedTo: [String]?
        var status: Int
        var seat: String?
        var needHotel: Bool
        var age: Int
        var selectedMenu: String?
        var notes: String?
        var messageFromGuest: String?
        var invitedBy: String?
        var plusOneOptions: Int
        var createdAt: Date
        var updatedAt: Date
    }
}

struct WrappedId: Codable {
    var id: UUID
}

struct Allergen: Codable, Identifiable, Hashable {
    var id: UUID
    var name: String
    var code: String
    var info: String
}

struct Diet: Codable {
    var id: UUID
    var name: String
    var code: String
    var info: String
}

struct RSVP: Codable {
    var id: String
    var weddingId: String
    var numberOfGuests: Int
    var confirmedGuests: Int
    var declinedGuests: Int
    var guests: [Guest]
}


enum GuestAge: Int, Codable, CaseIterable, Identifiable {
    case adult = 0
    case child = 1
    case infant = 2
    
    var id: String {
        switch self {
        case .adult:
            return "adult"
        case .child:
            return "child"
        case .infant:
            return "infant"
        }
    }
    
    var title: String {
        self.id.lowercased()
    }
}

enum InvitationStatus: Int, CaseIterable, Identifiable, Codable {
    var id: UUID {
        UUID()
    }
    case noResponse = 0
    case confirmed = 1
    case declined = 2
    case maybe = 3
}
