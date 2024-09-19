//
//  ContentView.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/17.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var currentTab: String = "allExpenses"
    
    // App init.
    let locale = Locale.current
    @AppStorage("username") var username = ""
    @AppStorage("usePasscode") var usePasscode = false
    @AppStorage("useFaceID") var useFaceID = false
//    @AppStorage("systemDefaultCurrencyCode") var systemDefaultCurrency = (locale.currencyCode ?? "")

    var body: some View {
        TabView(selection: $currentTab) {
            graphScreen().tabItem { // Graphs
                Label("Graphs", systemImage: "chart.pie.fill")
            }
            .tag("graphs")
            
            allExpense().tabItem {
                Label("All Expenses", systemImage: "list.bullet.circle.fill")
            }
            .tag("allExpenses")
            
            newExpense().tabItem { // Log new expense
                Label("New Expense", systemImage: "plus.circle.fill")
            }
            .tag("newExpense")
            
            allCards().tabItem { // All cards
                Label("My Cards", systemImage: "creditcard.circle.fill")
            }
            .tag("cards")
            
            settings().tabItem { // All cards
                Label("Settings", systemImage: "gearshape.fill")
            }
            .tag("settings")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
