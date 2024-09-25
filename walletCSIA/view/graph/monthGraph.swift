//
//  graphScreen.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/19.
//
import SwiftUI
import SwiftData
import Charts

struct monthGraph: View {
    let calendar = Calendar.current
    let currentDate = Date()
    
    @State var isPresenting: Bool = false
    @Query var categories: [Category]
    @Query var expenses: [Expense]
    var monthExpenses: Dictionary<Category, [Expense]> {
        sortByCategory(expenseList: sortThisMonth(expenses: expenses))
    }
    var monthExpenseTotals: Dictionary<Category, Double> {
        totalsByCategory(expensesSorted: monthExpenses)
    }
    
    var body: some View {
        NavigationStack {
                Chart {
                    ForEach (Array(monthExpenseTotals.keys), id: \.self) { key in
                        SectorMark(
                            angle: .value(key.name, monthExpenseTotals[key]!),
                            angularInset: 2.0
                        )
                    }
                }
                .frame(height: 500)
            }
        }
    }
