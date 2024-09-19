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
    @State private var isDefaultCurrency: Bool = false
    @State private var showCurrencyPopup: Bool = false
    
    @Query var currencies: [Currency]
    
    var body: some View {
        Button(action: {
            self.currencyCode = ""
            self.showCurrencyPopup = true
        }) {
            Image(systemName: "plus")
        }
        // Move the alert modifier outside the Button's label
        .alert("Enter New Currency Code", isPresented: $showCurrencyPopup) {
            TextField("3-letter ISO Currency Code", text: $currencyCode)
            Button("Confirm") {
                isDefaultCurrency = checkIfDefault(currencies: currencies)
                newCurrencyObject(currencyCode: currencyCode, isDefaultCurrency: isDefaultCurrency)
            }
            Button("Cancel", role: .cancel, action: {})
        }
    }
    
    func newCurrencyObject(currencyCode: String, isDefaultCurrency: Bool) {
        let newCurrency = Currency(acronym: currencyCode, isDefaultCurrency: isDefaultCurrency)
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
