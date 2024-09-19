//
//  currencyListEditor.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/19.
//

import SwiftUI
import SwiftData

struct currencyListEditor: View {
    @Environment(\.modelContext) private var context // Access the model context
    @Query var currencies: [Currency] // Fetching categories from the model
    @State private var isPresentingConfirmation = false // Controls the confirmation dialog
    @State private var currencyToDelete: Currency? // Stores the category to delete
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(currencies, id: \.self) { currency in
                    Text(currency.name)
                }
                .onDelete(perform: confirmDelete)
            }
            .navigationTitle("All Currencies")
            .toolbar {
                ToolbarItem {
                    NewCurrencyView()
                        .padding()
                }
            }
            .confirmationDialog(
                "Are you sure you want to delete this currency?\n(This action will also delete all expenses associated to this currency!)",
                isPresented: $isPresentingConfirmation,
                titleVisibility: .visible
            ) {
                Button("Delete", role: .destructive) {
                    if let currency = currencyToDelete {
                        deleteCurrency(currency)
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
    
    // Trigger the confirmation dialog
    private func confirmDelete(at offsets: IndexSet) {
        if let index = offsets.first {
            currencyToDelete = currencies[index]
            isPresentingConfirmation = true // Show the confirmation dialog
        }
    }
    
    // Delete the category and save the context
    private func deleteCurrency(_ currency: Currency) {
        context.delete(currency) // Delete the category from the context
        do {
            try context.save()
        } catch {
            print("Failed to delete the category: \(error)")
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Category.self)
    return currencyListEditor()
        .modelContext(container.mainContext)
}
