//
//  Budget.swift
//  WeddMate
//
//  Created by Robin Kment on 26.01.2023.
//

import Foundation
import SwiftData

@Model
final class Budget: Codable, Identifiable {
    @Attribute(.unique) let id: UUID
    let createdAt: Date
    let updatedAt: Date
    let totalAmount: Double
    var estimatedAmount: Double
    let currency: String
    let weddingId: UUID
    
    @Relationship(deleteRule: .nullify, inverse: \Wedding.budget)
    var weddingBudget: Wedding?
    
    var items: [BudgetItem]
    
    internal init(
        id: UUID,
        createdAt: Date,
        updatedAt: Date,
        totalAmount: Double,
        estimatedAmount: Double,
        currency: String,
        weddingId: UUID,
        items: [BudgetItem]
    ) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.totalAmount = totalAmount
        self.estimatedAmount = estimatedAmount
        self.currency = currency
        self.weddingId = weddingId
        self.items = items
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case updatedAt
        case totalAmount
        case estimatedAmount
        case currency
        case weddingId
        case weddingBudget
        case items
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.totalAmount = try container.decode(Double.self, forKey: .totalAmount)
        self.estimatedAmount = try container.decode(Double.self, forKey: .estimatedAmount)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.weddingId = try container.decode(UUID.self, forKey: .weddingId)
        self.weddingBudget = try container.decodeIfPresent(Wedding.self, forKey: .weddingBudget)
        self.items = try container.decode([BudgetItem].self, forKey: .items)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(totalAmount, forKey: .totalAmount)
        try container.encode(estimatedAmount, forKey: .estimatedAmount)
        try container.encode(currency, forKey: .currency)
        try container.encode(weddingId, forKey: .weddingId)
        try container.encode(weddingBudget, forKey: .weddingBudget)
        try container.encode(items, forKey: .items)
    }
}

@Model
final class BudgetItem: Codable, Identifiable {
    @Attribute(.unique) let id: UUID
    let createdAt: Date
    let updatedAt: Date
    var name: String
    var category: String
    var amount: Double
    let currency: String
    var dueDate: Date
    var paidAt: Date?
    var payer: String?
    var notes: String?
    var paymentType: PaymentType
    var paymentStatus: PaymentStatus
    let budgetId: UUID
    
    @Relationship(deleteRule: .nullify, inverse: \Budget.items)
    var budget: Budget?
    
    internal init(
        id: UUID,
        createdAt: Date,
        updatedAt: Date,
        name: String,
        category: String,
        amount: Double,
        currency: String,
        dueDate: Date,
        paidAt: Date? = nil,
        payer: String? = nil,
        notes: String? = nil,
        paymentType: PaymentType,
        paymentStatus: PaymentStatus,
        budgetId: UUID
    ) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.name = name
        self.category = category
        self.amount = amount
        self.currency = currency
        self.dueDate = dueDate
        self.paidAt = paidAt
        self.payer = payer
        self.notes = notes
        self.paymentType = paymentType
        self.paymentStatus = paymentStatus
        self.budgetId = budgetId
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt
        case updatedAt
        case name
        case category
        case amount
        case currency
        case dueDate
        case paidAt
        case payer
        case notes
        case paymentType
        case paymentStatus
        case budgetId
        case budget
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = try container.decode(String.self, forKey: .category)
        self.amount = try container.decode(Double.self, forKey: .amount)
        self.currency = try container.decode(String.self, forKey: .currency)
        self.dueDate = try container.decode(Date.self, forKey: .dueDate)
        self.paidAt = try container.decodeIfPresent(Date.self, forKey: .paidAt)
        self.payer = try container.decodeIfPresent(String.self, forKey: .payer)
        self.notes = try container.decodeIfPresent(String.self, forKey: .notes)
        self.paymentType = try container.decode(PaymentType.self, forKey: .paymentType)
        self.paymentStatus = try container.decode(PaymentStatus.self, forKey: .paymentStatus)
        self.budgetId = try container.decode(UUID.self, forKey: .budgetId)
        self.budget = try container.decodeIfPresent(Budget.self, forKey: .budget)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
        try container.encode(name, forKey: .name)
        try container.encode(category, forKey: .category)
        try container.encode(amount, forKey: .amount)
        try container.encode(currency, forKey: .currency)
        try container.encode(dueDate, forKey: .dueDate)
        try container.encode(paidAt, forKey: .paidAt)
        try container.encode(payer, forKey: .payer)
        try container.encode(notes, forKey: .notes)
        try container.encode(paymentType, forKey: .paymentType)
        try container.encode(paymentStatus, forKey: .paymentStatus)
        try container.encode(budgetId, forKey: .budgetId)
        try container.encode(budget, forKey: .budget)
    }
}

enum PaymentType: String, CaseIterable, Identifiable, Codable {
    case deposit = "deposit"
    case final = "final"
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .deposit:
            return "Deposit"
        case .final:
            return "Final"
        }
    }
}

enum PaymentStatus: String, CaseIterable, Identifiable, Codable {
    case pending = "pending"
    case paid = "paid"
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .pending:
            return "Pending"
        case .paid:
            return "Paid"
        }
    }
}

extension Budget {
    static func mock(in wedding: UUID) -> Budget {
        Budget(
            id: UUID(),
            createdAt: .now,
            updatedAt: .now,
            totalAmount: 150_000,
            estimatedAmount: 150_000,
            currency: Locale.current.currency?.identifier ?? "CZK",
            weddingId: wedding,
            items: []
        )
    }
    static var mock: Budget {
        Budget(
            id: UUID(),
            createdAt: .now,
            updatedAt: .now,
            totalAmount: 150000,
            estimatedAmount: 150000,
            currency: "CZK",
            weddingId: UUID(),
            items: [.mock]
        )
    }
}

extension BudgetItem {
    static var mock: BudgetItem {
        BudgetItem(
            id: UUID(),
            createdAt: .now,
            updatedAt: .now,
            name: "Dress",
            category: "dress",
            amount: 9686,
            currency: "CZK",
            dueDate: .now,
            paidAt: .now,
            payer: "bride",
            notes: "None",
            paymentType: .final,
            paymentStatus: .paid,
            budgetId: UUID()
        )
    }
}
