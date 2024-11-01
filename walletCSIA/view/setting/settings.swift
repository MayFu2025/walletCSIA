//
//  settings.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/17.
//

import SwiftUI
import SwiftData

struct settings: View {
    @Environment(\.modelContext) private var context
    
    @Query var categories: [Category]
    @Query var currencies: [Currency]
    @Query var expenses: [Expense]
    
    var defaultName: String {
        UserDefaults.standard.string(forKey: "defaultName") ?? ""
    }
    @State var changeDefaultName: Bool = false
    @State var tentativeNewName: String = ""
    
    
    var body: some View {
        NavigationStack{
            List{
                Section(header: Text("Default Name")) {
                    HStack{
                        Text(defaultName)
                        Spacer()
                        Button(action: { self.changeDefaultName = true}, label: {
                            Text("Edit")
                        })
                        .alert("Enter New Default Name", isPresented: $changeDefaultName) {
                            TextField("New Name", text: $tentativeNewName)
                            Button("Confirm") {
                                UserDefaults.standard.set(tentativeNewName, forKey: "defaultName")
                            }
                            Button("Cancel", role: .cancel, action: {})
                        }
                    }
                }
                
                
                Section(header: Text("All Entries")) {
                    NavigationLink(destination: categoryListEditor()) {
                        Text("Categories")
                    }
                    NavigationLink(destination: currencyListEditor()) {
                        Text("Currencies")
                    }
                    NavigationLink(destination: expenseListEditor()) {
                        Text("Expenses")
                    }
                }
                
                Section(header: Text("Reset")) {
                    deleteAllConfirmation()
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    settings()
}
