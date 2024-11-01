//
//  editExpenseSheet.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/11/01.
//

import SwiftUI
import SwiftData

struct editExpenseSheet: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var expenseEditing: Expense
    
    @Query private var creditCards: [creditCard]
    @Query private var currencies: [Currency]
    @Query private var categories: [Category]
    
    @State private var amount: Double = 0.0
    @State private var currency: Currency?
    @State private var card: creditCard?
    @State private var category: Category?
    @State private var date: Date = .init()
    @State private var note: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Card") {
                    Picker("Select Card:", selection: $card){
                        ForEach(creditCards, id: \.self) { card in
                            Text(card.name).tag(card as creditCard?)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section("Currency"){
                    Picker("Select Currency:", selection: $currency){
                        ForEach(currencies, id: \.self) { currency in
                            Text("\(currency.acronym) (\(currency.symbol))").tag(currency as Currency?)
                        }
                    }
                    .pickerStyle(.menu)
                    //                    .onChange(of: currency) { newCurrency in
                    //                        // Update format when currency changes
                    //                        let code = newCurrency?.acronym ?? "USD"
                    //                        amountFormat = .currency(code: code)
                    //                        print("Currency set to: \(code.acronym)")
                    //                    }
                }
                
                Section("Amount") {
                    HStack {
                        Text(currency?.symbol ?? "")
                        TextField("0.0", value: $amount, format: .number)
                            .keyboardType(.decimalPad)
                        Text(currency?.acronym ?? "")
                    }
                }
                //                .onChange(of: currency) { _ in
                //                    amountFormat = .currency(code: defaultCurrency?.acronym ?? "USD")
                //                }
                
                Section("Category") {
                    Picker("Select Category:", selection: $category){
                        ForEach(categories, id: \.self) { category in
                            Text(category.name).tag(category as Category?)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section("Date") {
                    DatePicker("Select Date:", selection: $date, in: ...Date(), displayedComponents: [.date])
                }
                
                Section("Note") {
                    TextField("Additional notes (Optional)", text: $note)
                }
                Section("Add Expense"){
                    Button("Update") {
                        Task {
                            do {
                                try await updateExpense()
                                dismiss()
                            } catch {
                                print("Failed to update expense: \(error)")
                            }
                        }
                    }
                    .disabled(amount.isZero)
                }
                .navigationTitle("Update Expense")
                .onAppear {
                    amount = expenseEditing.amount
                    currency = expenseEditing.currency
                    card = expenseEditing.card
                    category = expenseEditing.category
                    date = expenseEditing.date
                    note = expenseEditing.note
                }
            }
        }
    }
    
    func updateExpense() async throws {
        var adjusted = amount
        if !currency!.isDefault {
            adjusted = try await getExchangedValue(amount: amount, date: date, base: currency!, target: currencies.first(where: { $0.isDefault })!)
        }
        
        expenseEditing.amount = amount
        expenseEditing.adjustedAmount = adjusted
        expenseEditing.currency = currency ?? currencies.first(where: { $0.isDefault })!
        expenseEditing.card = card ?? creditCards.first!
        expenseEditing.category = category ?? categories.first(where: { $0.isDefault })!
        expenseEditing.date = date
        expenseEditing.note = note
        
        do {
            try context.save()
            print("Expense updated.")
        } catch {
            print("Failed to update expense: \(error)")
        }
    }
}
