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
    
    @State private var isPresentingConfirmation = false // Controls the confirmation dialog
    @State private var expenseToDelete: Expense? // Stores the expense to delete
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(byDate.keys.sorted(), id: \.self) { date in
                    Section(header: Text(date.dashSeparated())) {
                        
                        if let expensesForDate = byDate[date] {
                            ForEach(expensesForDate, id: \.self) { expense in
                                NavigationLink(destination: expenseDetails(expense: expense)) {
                                    HStack{
                                        Text(expense.currency.symbol)
                                        Text(String(format: "%.2f", expense.amount))
                                    }
                                }
                                .contextMenu {
                                    Button("Delete", role: .destructive) {
                                        expenseToDelete = expense
                                        isPresentingConfirmation = true
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Past Expenses")
            .confirmationDialog(
                "Are you sure you want to delete this expense?",
                isPresented: $isPresentingConfirmation,
                titleVisibility: .visible
            ) {
                Button("Delete", role: .destructive) {
                    if let expense = expenseToDelete {
                        deleteExpense(expense)
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
    
    private func deleteExpense(_ expense: Expense) {
        modelContext.delete(expense)
        do {
            try modelContext.save()
        } catch {
            print("Failed to delete the expense: \(error)")
        }
    }
}

#Preview {
    allExpense()
}
