//
//  expense.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/17.
//

import Foundation
import SwiftData

@Model
class Expense {
    var amount: Double
    var adjustedAmount: Double
    var date: Date
    var category: Category
    var card: creditCard
    var currency: Currency
    var note: String
    
    init(amount: Double, adjustedAmount: Double?, date: Date, category: Category, card: creditCard, currency: Currency, note: String) {
        self.amount = amount
        self.adjustedAmount = adjustedAmount ?? amount
        self.date = date
        self.category = category
        self.card = card
        self.currency = currency
        self.note = note
    }
}
