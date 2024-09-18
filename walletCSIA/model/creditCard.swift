//
//  creditCard.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/17.
//

import Foundation
import SwiftData

@Model
class creditCard {
    @Attribute(.unique) var name: String
    var keyVisuals: [Array<String>] //Color 1, Color 2, CardProviderImage
    var defaultCurrency: Currency
    
    @Relationship(deleteRule: .cascade, inverse: \Expense.card)
    var expenses: [Expense]?
    
    init(name: String, keyVisuals: [Array<String>], defaultCurrency: Currency) {
        self.name = name
        self.keyVisuals = keyVisuals
        self.defaultCurrency = defaultCurrency
    }
}
