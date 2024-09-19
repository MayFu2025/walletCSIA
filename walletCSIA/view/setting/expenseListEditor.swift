//
//  expenseListEditor.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/19.
//

import SwiftUI
import SwiftData

struct expenseListEditor: View {
    @Environment(\.modelContext) private var context
    
    @Query var expenses: [Expense]
    
    @State private var isPresentingConfirmation = false
    @State private var expenseToDelete: Expense?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses, id: \.self) { expense in
                    Text(expense.note)
                }
                .onDelete(perform: confirmDelete)
            }
            .navigationTitle("All Expenses")
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
    
    // Trigger the confirmation dialog
    private func confirmDelete(at offsets: IndexSet) {
        if let index = offsets.first {
            expenseToDelete = expenses[index]
            isPresentingConfirmation = true
        }
    }
    
    // Delete the category and save the context
    private func deleteExpense(_ expense: Expense) {
        context.delete(expense)
        do {
            try context.save()
        } catch {
            print("Failed to delete the expense: \(error)")
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Category.self)
    return expenseListEditor()
        .modelContext(container.mainContext)
}
