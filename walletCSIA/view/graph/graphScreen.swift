//
//  graphScreen.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/19.
//

import SwiftUI
import SwiftData

struct graphScreen: View {
    let calendar = Calendar.current
    let currentDate = Date()
    
    @State var isPresenting: Bool = false
    @Query var categories: [Category]
    @Query var expenses: [Expense]
    
    @State var graphCondition: String = "month"
    @State var filteredExpenses: [Expense]?

    var body: some View {
        NavigationStack {
            List(filteredExpenses ?? []) { expense in
                Text(String(expense.amount))
            }
            Text("This is month graph screen")
                .navigationTitle("Graph View")
        }
        .onAppear {
            let currentYear = calendar.component(.year, from: currentDate)
            let currentMonth = calendar.component(.month, from: currentDate)
            
            filteredExpenses = expenses.filter { expense in
                let expenseYear = calendar.component(.year, from: expense.date)
                let expenseMonth = calendar.component(.month, from: expense.date)
                return expenseYear == currentYear && expenseMonth == currentMonth
            }
    }
}
}

#Preview {
    graphScreen()
}

