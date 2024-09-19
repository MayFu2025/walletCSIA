//
//  settings.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/17.
//

import SwiftUI
import SwiftData

struct settings: View {
    
    @Query var categories: [Category]
    @Query var currencies: [Currency]
    @Query var expenses: [Expense]
    
//    defaults.set(userName, forKey: "Username")
    
    var body: some View {
        NavigationStack{
            List{
                Section(header: Text("Username")) {
                    HStack{
                        Text("Hold on") //TODO: User defaults and passcode/FaceID
                        Spacer()
                        Button(action: {}, label: {
                            Text("Edit")
                        })
                    }
                }
                Section(header: Text("Passcode and FaceID")) {
                    Text("Add toggle here to enable password/FaceID")
                }
                Section(header: Text("All Instances")) {
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
                    Text("Button with confirm popup")
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    settings()
}
