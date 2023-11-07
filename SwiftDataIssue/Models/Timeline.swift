//
//  Timeline.swift
//  WeddMate
//
//  Created by Robin Kment on 26.01.2023.
//

import Foundation
import SwiftData

@Model
final class Timeline: Codable, Identifiable {
    @Attribute(.unique) let id: UUID
    let weddingId: UUID
    
    @Relationship(deleteRule: .nullify, inverse: \Wedding.timelines)
    var weddingTimeline: Wedding?
    let title: String
    let date: Date
    let createdAt: Date
    let updatedAt: Date
    var events: [TimelineEvent]
    
    internal init(
        id: UUID,
        weddingId: UUID,
        title: String,
        date: Date,
        createdAt: Date,
        updatedAt: Date,
        events: [TimelineEvent]
    ) {
        self.id = id
        self.weddingId = weddingId
        self.title = title
        self.date = date
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.events = events
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case weddingId
        case weddingTimeline
        case title
        case date
        case createdAt
        case updatedAt
        case events
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.weddingId = try container.decode(UUID.self, forKey: .weddingId)
        self.weddingTimeline = try container.decodeIfPresent(Wedding.self, forKey: .weddingTimeline)
        self.title = try container.decode(String.self, forKey: .title)
        self.date = try container.decode(Date.self, forKey: .date)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.events = try container.decode([TimelineEvent].self, forKey: .events)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(weddingId, forKey: .weddingId)
        try container.encode(weddingTimeline, forKey: .weddingTimeline)
        try container.encode(title, forKey: .title)
        try container.encode(date, forKey: .date)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(events, forKey: .events)
    }
}

extension Timeline {
    static var mock: Timeline {
        Timeline(id: UUID(), weddingId: UUID(), title: "hello", date: .now, createdAt: .now, updatedAt: .now, events: [])
    }
}

@Model
final class TimelineEvent: Codable, Identifiable  {
    @Attribute(.unique) let id: UUID
    let timelineId: UUID
    let hexColor: String
    let note: String
    let title: String
    let startAt: Date
    let endAt: Date
    let createdAt: Date
    let updatedAt: Date
    
    @Relationship(deleteRule: .nullify, inverse: \Timeline.events)
    var timeline: Timeline?
    
    internal init(
        id: UUID,
        timelineId: UUID,
        hexColor: String,
        note: String,
        title: String,
        startAt: Date,
        endAt: Date,
        createdAt: Date,
        updatedAt: Date
    ) {
        self.id = id
        self.timelineId = timelineId
        self.hexColor = hexColor
        self.note = note
        self.title = title
        self.startAt = startAt
        self.endAt = endAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case timelineId
        case hexColor
        case note
        case title
        case startAt
        case endAt
        case createdAt
        case updatedAt
        case timeline
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.timelineId = try container.decode(UUID.self, forKey: .timelineId)
        self.hexColor = try container.decode(String.self, forKey: .hexColor)
        self.note = try container.decode(String.self, forKey: .note)
        self.title = try container.decode(String.self, forKey: .title)
        self.startAt = try container.decode(Date.self, forKey: .startAt)
        self.endAt = try container.decode(Date.self, forKey: .endAt)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.timeline = try container.decodeIfPresent(Timeline.self, forKey: .timeline)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(timelineId, forKey: .timelineId)
        try container.encode(hexColor, forKey: .hexColor)
        try container.encode(note, forKey: .note)
        try container.encode(title, forKey: .title)
        try container.encode(startAt, forKey: .startAt)
        try container.encode(endAt, forKey: .endAt)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(timeline, forKey: .timeline)
    }
}

extension TimelineEvent {
    static var mock: TimelineEvent {
        TimelineEvent(
            id: UUID(),
            timelineId: UUID(),
            hexColor: "jfgh",
            note: "helo",
            title: "trrr",
            startAt: .now,
            endAt: .now.addingTimeInterval(360),
            createdAt: .now,
            updatedAt: .now
        )
    }
}

