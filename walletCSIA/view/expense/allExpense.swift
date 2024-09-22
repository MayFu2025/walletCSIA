//
//  allExpense.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/17.
//

import SwiftUI
import SwiftData

struct allExpense: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    var body: some View {
        NavigationStack{
            Text("")
                .navigationTitle("Past Expenses")
        }
    }
}

#Preview {
    allExpense()
}
