//
//  Budget.swift
//  WeddMate
//
//  Created by Robin Kment on 26.01.2023.
//

import Foundation
import SwiftData
import SimpleCodable

@Model
@Codable
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
}

@Model
@Codable
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
