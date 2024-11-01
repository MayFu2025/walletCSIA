//
//  uponFirstLaunch.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/25.
//

import Foundation
import SwiftUI
import SwiftData

func returnCheckFirstLaunch() -> Bool {
    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
    if launchedBefore  {
        return false
    } else {
        return true
    }
}

struct uponFirstLaunch: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    let userLocal = Locale.current
    var currencyCode: String { userLocal.currency!.identifier}
    
    @State var defaultName: String = ""
    @State var selectionCurrency: String = "USD"
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Set Default Name") {
                    TextField("Default Card Holder Name", text: $defaultName)
                }
                Section("Set Default Currency") {
                    Picker("Select Default:", selection: $selectionCurrency) {
                        ForEach(worldCurrency.allCases) { option in
                            Text(option.name).tag(option)
                        }
                    }
                    .pickerStyle(.menu)
                    }

            }
            .navigationTitle("Welcome \(defaultName)")
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button(action: {
                        appInit()
                        dismiss()
                    }, label: {Text("Let's Go!")})
                }
            }
        }
        .onAppear {selectionCurrency = currencyCode}
    }
    
    func appInit() {
        let defaultCurrency = Currency(acronym: selectionCurrency, isDefault: true)
        let defaultCategory = Category(name: "Uncategorized", isDefault: true)
        context.insert(defaultCurrency)
        context.insert(defaultCategory)
        UserDefaults.standard.set(defaultName, forKey: "defaultName")
        do {
            try context.save()
            print("App Initialized")
        } catch {
            print("Failed to initialize app: \(error)")
        }
    }
}

#Preview {
    uponFirstLaunch()
}


//UserDefaults.standard.set(true, forKey: "launchedBefore")


//Text("App-detected Recommended Default Currency:\n\(currencyCode)")

//TextField("3-letter ISO Code", text: $selectionCurrency)
////                        .onChange(of: selectionCurrency) { selectionCurrency = String(selectionCurrency.prefix(3))}
////                        .onSubmit {
////                            if selectionCurrency.isEmpty {
////                                selectionCurrency = currencyCode
////                            }
////                        }
