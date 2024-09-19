//
//  creditCard.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/19.
//

import Foundation
import SwiftData

@Model
class creditCard {
    @Attribute(.unique) var name: String
    var holder: String
    
    var color1: String
    var color2: String
    var cardProvider: String
    
    var defaultCurrency: Currency
    var cashbackRate: Double?
    
    @Relationship(deleteRule: .cascade, inverse: \Expense.card)
    var expenses: [Expense]?
    
    init(name: String, holder: String, color1: String, color2: String, cardProvider: String, defaultCurrency: Currency) {
        self.name = name
        self.holder = holder
        self.color1 =  color1
        self.color2 = color2
        self.cardProvider = cardProvider
        self.defaultCurrency = defaultCurrency
    }
}
