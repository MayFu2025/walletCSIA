//
//  expenseDetails.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/11/01.
//

import SwiftUI
import SwiftData

struct expenseDetails: View {
    @Query var currencies: [Currency]

    
    var expense: Expense
    var defaultCurrency: Currency {
        return currencies.first(where: { $0.isDefault })!
    }
    
    
    var body: some View {
        NavigationStack{
            List{
                Section("Expense Date"){
                    Text(expense.date.dashSeparated())
                }
                
                Section("Category"){
                    Text(expense.category.name)
                }
                
                Section("Amount (selected currency)"){
                    HStack{
                        Text(String(expense.currency.symbol))
                        Text(String(expense.amount))
                        Text(String(expense.currency.acronym))
                    }
                }
                Section("Amount (default currency)"){
                    HStack{
                        Text(String(defaultCurrency.symbol))
                        Text(String(expense.adjustedAmount))
                        Text(String(defaultCurrency.acronym))
                    }
                }
                Section("Card Details"){
                    Text("Name: \(expense.card.name)")
                    Text("Currency: \(expense.card.defaultCurrency.name)")
                    Text("Cashback Rate: \(String(format: "%.2f", expense.card.cashbackRate*100))%")
                    Text("Expected Cashback (Default Currency): \(expense.card.defaultCurrency.symbol) \(String(format: "%.2f", expense.adjustedAmount*expense.card.cashbackRate))")
                }
                
                Section("Notes"){
                    Text(expense.note)
                }
            }
        }
        .navigationTitle("Expense Details")
    }
}
