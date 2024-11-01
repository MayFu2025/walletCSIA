//
//  graphView.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/25.
//

import SwiftUI
import SwiftData

struct graphScreen: View {
    @State var monthDate: Date = Date()
    @Query var expenses: [Expense]
    @Query var currencies: [Currency]
    
    var monthSum : Double {
        let thisMonth = sortGivenMonth(dateOfMonth: monthDate, expenses: expenses)
        let amounts = thisMonth.map { $0.adjustedAmount }
        return amounts.reduce(0, +)
    }
    
    var defaultCurrency: Currency {
        currencies.first(where: {$0.isDefault})!
    }
    
    var body: some View {
        NavigationStack {
            List{
                Section("Graph"){
                    HStack{
                        DatePicker("Get Month from Date:",
                                   selection: $monthDate,
                                   displayedComponents: [.date]
                        )
                        .datePickerStyle(.compact)
                        Spacer()
                    }
                    
                    monthGraph(month: monthDate)
                }
            }
            
                .navigationTitle("Monthly Graph")
        }
    }
}
