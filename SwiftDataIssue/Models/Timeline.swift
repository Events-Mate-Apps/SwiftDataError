//
//  Timeline.swift
//  WeddMate
//
//  Created by Robin Kment on 26.01.2023.
//

import Foundation
import SwiftData
import SimpleCodable

@Model
@Codable
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
}

extension Timeline {
    static var mock: Timeline {
        Timeline(id: UUID(), weddingId: UUID(), title: "hello", date: .now, createdAt: .now, updatedAt: .now, events: [])
    }
}

@Model
@Codable
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

