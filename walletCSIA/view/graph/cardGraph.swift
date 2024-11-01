//
//  cardGraph.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/11/01.
//

import SwiftUI
import Charts

struct cardGraph: View {
    var card: creditCard
    var expenses: [Expense]
    var month: Date
    
    private var monthExpenses: Dictionary<Category, [Expense]> {
        sortByCategory(expenseList: sortGivenMonth(dateOfMonth: month, expenses: expenses))
    }
    private var monthExpenseTotals: Dictionary<Category, Double> {
        totalsByCategory(expensesSorted: monthExpenses)
    }
    private var monthSum : Double {
        let expenseArray = sortGivenMonth(dateOfMonth: month, expenses: expenses)
        let amounts = expenseArray.map { $0.adjustedAmount }
        return amounts.reduce(0, +)
    }
    
    var body: some View {
            NavigationStack {
                Chart {
                    ForEach(Array(monthExpenseTotals.keys), id: \.self) { key in
                        SectorMark(
                            angle: .value(key.name, monthExpenseTotals[key] ?? 0),
                            innerRadius: .ratio(0.65),
                            angularInset: 2.0
                        )
                        .foregroundStyle(by: .value("Category", "\(key.name) (\(monthExpenseTotals[key] ?? 0))"))
                        .cornerRadius(10.0)
                    }
                }
                .frame(width: 300, height: 300)
                .chartBackground { chartProxy in
                  GeometryReader { geometry in
                    if let anchor = chartProxy.plotFrame {
                      let frame = geometry[anchor]
                        VStack{
                            Text("Total")
                            Text("\(card.defaultCurrency.symbol)\(String(format:"%.2f", monthSum))")
                        }
                        .position(x: frame.midX, y: frame.midY)
                    }
                  }
                }
            }
        }
    }

