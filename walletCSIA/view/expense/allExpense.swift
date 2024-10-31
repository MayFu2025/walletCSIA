//
//  allExpense.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/17.
//

import SwiftUI
import SwiftData

struct allExpense: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    var byDate: Dictionary<Date, [Expense]> {sortByDate(expenseList: expenses)}
    
//    var groupedTransactions: Dictionary<String, Any> { Dictionary(grouping: expenses, by: { dateFormatter.string(from: $0.date) }) }
    
    var body: some View {
        NavigationStack {
            ScrollView{
                ForEach(expenses) { expense in
                    expenseRow(expense: expense)
                }
            }
            Text("")
                .navigationTitle("Past Expenses")
        }
    }
}

#Preview {
    allExpense()
}
