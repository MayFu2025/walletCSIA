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
}
