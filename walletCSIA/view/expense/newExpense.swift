//
//  newExpense.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/17.
//

import SwiftUI

struct newExpense: View {
    @Environment(\.modelContext) private var context
    @State private var amount: Double = 0.0
    @State private var currency: Currency?
    @State private var card: creditCard?
    @State private var category: Category?
    @State private var date: Date = .init()
    @State private var note: String = ""
    
    var submitDisabled: Bool {
        return amount.isZero || currency == nil || card == nil
    }
    
    private var testList: Array<String> = ["Category1", "Category2", "Category3"]
    private var currencySymbol: String = "$"
    
    var presentSuccess: Bool = false
    var presentFailiure: Bool = false
    func createNewExpense(){
        let expense = Expense(amount: amount, date: date, category: category!, card: card!, currency: currency!, note: note)
        context.insert(expense)
    }
   
    
    var body: some View {
        NavigationStack {
            List {
                Section("Card") {
                    Picker("Select Card Used", selection: $card) {
                        ForEach(testList, id: \.self) {
                            testItem in Text(testItem).tag(testItem)
                        }
                    }
                }
                
                Section("Amount") {
                    Picker("Select Currency", selection: $currency){
                        ForEach(testList, id: \.self) {
                            testItem in
                            Text(testItem)
                                .tag(testItem)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    HStack{
                        Text(currencySymbol)
                        TextField("0.0", value: $amount, format: .currency(code: "US"))
                    }
                }
                
                Section("Date"){DatePicker(
                    "",
                    selection: $date,
                    in: ...Date(),
                    displayedComponents: [.date]
                ).datePickerStyle(.wheel)
                }
                
                Section("Category"){
                    Picker("Select Category", selection: $category){
                        ForEach(testList, id: \.self) {
                            testItem in
                            Text(testItem)
                                .tag(testItem)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section("Note"){
                    TextField("Additional Notes", text: $note)
                }
                
                Button(action: createNewExpense) {
                    Text("Submit")
                }.disabled(submitDisabled)
            }
            .navigationTitle("Log New Expense")
        }
    }
    
}

#Preview {
    newExpense()
}
