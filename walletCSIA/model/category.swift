//
//  category.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/17.
//

import Foundation
import SwiftData

@Model
class Category {
    @Attribute(.unique) var name: String
    
    @Relationship(deleteRule: .cascade, inverse: \Expense.category)
    var expenses: [Expense]?
    
    init(name: String) {
        self.name = name
    }
}
