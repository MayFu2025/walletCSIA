//
//  newCurrency.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/19.
//

import SwiftUI
import SwiftData

struct NewCurrencyView: View {
    @Environment(\.modelContext) private var context
    
    @State private var currencyCode: String = ""
    @State private var isDefault: Bool = false
    @State private var showCurrencyPopup: Bool = false
    
    @Query var currencies: [Currency]
    
    var body: some View {
        Button(action: {
            self.currencyCode = ""
            self.showCurrencyPopup = true
        }) {
            Image(systemName: "plus")
        }
        // Move the alert modifier outside the Button's label TODO: instead of entering textfield, use enum picker
        .alert("Enter New Currency Code", isPresented: $showCurrencyPopup) {
            TextField("3-letter ISO Currency Code", text: $currencyCode)
            Button("Confirm") {
                isDefault = checkIfDefault(currencies: currencies)
                newCurrencyObject(currencyCode: currencyCode, isDefault: isDefault)
            }
            Button("Cancel", role: .cancel, action: {})
        }
    }
    
    func newCurrencyObject(currencyCode: String, isDefault: Bool) {
        let newCurrency = Currency(acronym: currencyCode, isDefault: isDefault)
        context.insert(newCurrency)
        do {
            try context.save()
            print("Currency saved: \(newCurrency.name)")
        } catch {
            print("Failed to save currency: \(error)")
        }
    }
    
    func checkIfDefault(currencies: [Currency]) -> Bool {
        var output = false
        if currencies.isEmpty {
            output = true
        }
        return output
    }
}

#Preview {
    let container = try! ModelContainer(for: Category.self)
    return NewCurrencyView()
        .modelContext(container.mainContext)
}
