//
//  allExpense.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/17.
//

import SwiftUI
import SwiftData

struct allExpense: View {
    @Query var expenses: [Expense]
    @Environment(\.modelContext) var modelContext
    
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
