//
//  currency.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/17.
//

import Foundation
import SwiftData

@Model
class Currency {
    @Attribute(.unique) var acronym: String
    var name: String
    var symbol: String
    
    @Relationship(deleteRule: .cascade, inverse: \Expense.currency)
    var expenses: [Expense]?
    
    init(acronym: String) {
        self.acronym = acronym
        let reference = worldCurrency(rawValue: acronym)
        self.name = reference?.name ?? "Unknown"
        self.symbol = reference?.symbol ?? "Unknown"
    }
}
