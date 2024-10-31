//
//  ContentView.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/17.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var locale = Locale.current
    @Environment(\.modelContext) private var context
    @State private var currentTab: String = "allExpenses"
    @State private var showFirstLaunch: Bool = false

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
        .onAppear{
//            if UserDefaults.standard.bool(forKey: "usePasscode") {
//                authenticateUser()
//            }
            showFirstLaunch = returnCheckFirstLaunch()
        }
        .sheet(isPresented: $showFirstLaunch) {
                uponFirstLaunch()}
    }
}
    

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
