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
    @Attribute(.unique) var name: String
    @Attribute(.unique) var acronym: String
    var symbol: String
    
    @Relationship(deleteRule: .cascade, inverse: \Expense.currency)
    var expenses: [Expense]?
    
    init(name: String, acronym: String, symbol: String) {
        self.name = name
        self.acronym = acronym
        self.symbol = symbol
    }
}
