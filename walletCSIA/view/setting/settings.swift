//
//  settings.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/17.
//

import SwiftUI
import SwiftData

struct settings: View {
//    var userName = defaults.object(forKey:"Username") as? [String] ?? [String]()
    
    @Query var categories: [Category]
    @Query var currencies: [Currency]
    @Query var expenses: [Expense]
    
//    defaults.set(userName, forKey: "Username")
    
    var body: some View {
        NavigationStack{
            List{
                Section(header: Text("User")) {
                    HStack{
                        Text("Hold on")
                    }
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
            Text("This is settings screen")
                .navigationTitle("Settings")
        }
    }
}

#Preview {
    settings()
}
