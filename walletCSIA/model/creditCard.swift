//
//  creditCard.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/19.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class creditCard {
    @Attribute(.unique) var name: String
    var holder: String
    
    var color1: [Double]
    var color2: [Double]
    var cardProvider: String
    
    var defaultCurrency: Currency
    var cashbackRate: Double
    
    @Relationship(deleteRule: .cascade, inverse: \Expense.card)
    var expenses: [Expense]?
    
    init(name: String, holder: String, color1: Color, color2: Color, cardProvider: String, defaultCurrency: Currency, cashbackRate: Double) {
        self.name = name
        self.holder = holder
        self.color1 =  color1.asRGB()
        self.color2 = color2.asRGB()
        self.cardProvider = cardProvider
        self.defaultCurrency = defaultCurrency
        self.cashbackRate = cashbackRate
    }
    
    
    func expensesInCategory(category: Category) -> [Expense] {
            // Ensure expenses exist
            guard let expenses = expenses else { return [] }
            
            // Filter expenses by the given category
            return expenses.filter { $0.category == category }
    }
    func groupExpensesByDate() -> [[Expense]] {
        // Ensure expenses exist
        guard let expenses = expenses else { return [] }
        // Create a DateFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Format date to only include year, month, and day
        // Dictionary to hold grouped expenses
        var groupedExpenses = [String: [Expense]]()
        // Group expenses by date (normalized as a string)
        for expense in expenses {
            let dateKey = dateFormatter.string(from: expense.date)
            if groupedExpenses[dateKey] != nil {
                groupedExpenses[dateKey]?.append(expense)
            } else {
                groupedExpenses[dateKey] = [expense]
            }
        }   
        // Sort the dates and return arrays of expenses sorted by date
        let sortedKeys = groupedExpenses.keys.sorted()
        return sortedKeys.compactMap { groupedExpenses[$0] }
        }
}
