//
//  newExpense.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/20.
//
import SwiftUI
import SwiftData

struct newExpense: View {
    @Environment(\.modelContext) private var context
    @Query private var creditCards: [creditCard]
    @Query private var currencies: [Currency]
    @Query private var categories: [Category]
    
    @State private var amount: Double = 0.0
    @State private var currency: Currency?
    @State private var card: creditCard?
    @State private var category: Category?
    @State private var date: Date = .init()
    @State private var note: String = ""
    
    func addExpense(amount: Double, currency: Currency, card: creditCard, category: Category, date: Date, note: String) {
        let newExpense = Expense(amount: amount, date: date, category: category, card: card, currency: currency, note: note)
        context.insert(newExpense)
        do {
            try context.save()
        } catch {
            print("Failed to insert the expense: \(error)")
        }
    }
    
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
                }
                
                Section("Amount") {
                    HStack {
                        TextField("0.0", value: $amount, format: .currency(code: currency?.acronym ?? ""))
                        Text(currency?.acronym ?? "")
                    }
                }
                
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
                    Button("Submit", action: {
                        addExpense(amount: amount, currency: currency!, card: card!, category: category!, date: date, note: note)
                    })
                    .disabled(amount.isZero)
                }
            }
            .navigationTitle("Log New Expense")
            .onAppear {
                // Set default values once the data is fetched because you cannot initialize these values at the same time as all the other variables
                if currency == nil {
                    currency = currencies.first(where: { $0.isDefault })
                }
                if card == nil {
                    card = creditCards.first
                }
                if category == nil {
                    category = categories.first(where: { $0.isDefault })
                }
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Currency.self, creditCard.self, Category.self, Expense.self)

    // Create default entities
    let defaultCurrency = Currency(acronym: "JPY", isDefault: true)
    let testCurrency = Currency(acronym: "HKD", isDefault: false)
    let defaultCreditCard = creditCard(name: "Test", holder: "May Fu", color1: Color.red, color2: Color.blue, cardProvider: "MasterCardIcon", defaultCurrency: defaultCurrency, cashbackRate: 0.05)
    let defaultCategory = Category(name: "Uncategorized", isDefault: true)
    let testCategory = Category(name: "Test Category", isDefault: false)

    // Insert default entities into the context
    let context = container.mainContext
    context.insert(testCategory)
    context.insert(testCurrency)
    context.insert(defaultCurrency)
    context.insert(defaultCreditCard)
    context.insert(defaultCategory)
    
    return newExpense()
        .modelContext(context)
}
