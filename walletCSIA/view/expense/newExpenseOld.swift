//
//  newExpense.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/17.
//

//import SwiftUI
//import SwiftData
//
//struct newExpenseOld: View {
//    @Environment(\.modelContext) private var context
//    @Query private var creditCards: [creditCard]
//    @Query private var currencies: [Currency]
//    @Query private var categories: [Category]
//    
//    @Query(filter: #Predicate<Currency> { currency in
//        currency.isDefaultCurrency == true
//    }) var defaultCurrency: [Currency]
//    
//    @State private var amount: Double = 0.0
//    @State private var currency: Currency?
//    @State private var card: creditCard?
//    @State private var category: Category?
//    @State private var date: Date = .init()
//    @State private var note: String = ""
//    
//    var submitDisabled: Bool {
//        return amount.isZero || card == nil
//    }
//    
//    var presentSuccess: Bool = false
//    var presentFailiure: Bool = false
//    
//    func createNewExpense(){
//        let expense = Expense(amount: amount, date: date, category: category, card: card!, currency: currency, note: note)
//        context.insert(expense)
//    }
//    
//    private func setDefaultValues() {
//        let defaultCurrency = currencies.first(where: { $0.isDefaultCurrency })
//        currency = defaultCurrency!
//        
//        let unclassifiedCategories = categories.filter { $0.name == "Unclassified" }
//        if let defaultCategory = unclassifiedCategories.first {
//            category = defaultCategory
//        }
//        }
//    
//    setDefaultValues()
//   
//    
//    var body: some View {
//        NavigationStack {
//            List {
//                Section("Card") {
//                    Picker("Select Card Used", selection: $card) {
//                        ForEach(creditCards, id: \.self) {
//                            card in Text(card.name).tag(card)
//                        }
//                    }
//                }
//                
//                Section("Amount") {
//                    Picker("Select Currency", selection: $currency){
//                        ForEach(currencies, id: \.self) {
//                            currency in
//                            Text(currency.acronym)
//                                .tag(currency)
//                        }
//                    }
//                    .pickerStyle(.menu)
//                    
//                    HStack{
//                        Text(currency.symbol)
//                        TextField("0.0", value: $amount, format: .currency(code: "US"))
//                    }
//                }
//                
//                Section("Date"){DatePicker(
//                    "",
//                    selection: $date,
//                    in: ...Date(),
//                    displayedComponents: [.date]
//                ).datePickerStyle(.wheel)
//                }
//                
//                Section("Category"){
//                    Picker("Select Category", selection: $category){
//                        ForEach(categories, id: \.self) {
//                            category in
//                            Text(category.name)
//                                .tag(category)
//                        }
//                    }
//                    .pickerStyle(.menu)
//                }
//                
//                Section("Note"){
//                    TextField("Additional Notes", text: $note)
//                }
//                
//                Button(action: createNewExpense) {
//                    Text("Submit")
//                }.disabled(submitDisabled)
//            }
//            .navigationTitle("Log New Expense")
//        }
//        .onAppear {
//                    setDefaultValues()
//                }
//    }
//    
//}
//
//#Preview {
//    newExpense()
//}
