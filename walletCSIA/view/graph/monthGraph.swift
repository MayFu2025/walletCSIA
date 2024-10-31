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
    @Query var currencies: [Currency]
    
    @State private var clickedAngle: Double?
    
    var monthExpenses: Dictionary<Category, [Expense]> {
        sortByCategory(expenseList: sortThisMonth(expenses: expenses))
    }
    var monthExpenseTotals: Dictionary<Category, Double> {
        totalsByCategory(expensesSorted: monthExpenses)
    }
    
    var monthSum : Double {
        var thisMonth = sortThisMonth(expenses: expenses)
        var amounts = thisMonth.map { $0.amount }
        return amounts.reduce(0, +)
    }
    
    var defaultCurrency: Currency {
        currencies.first(where: {$0.isDefault})!
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
                    .foregroundStyle(by: .value("Category", key.name))
                    .cornerRadius(10.0)
                }
            }
            .chartAngleSelection(value: $clickedAngle)
            .frame(width: 300, height: 300)
            .chartBackground { chartProxy in
              GeometryReader { geometry in
                if let anchor = chartProxy.plotFrame {
                  let frame = geometry[anchor]
                    VStack{
                        Text("\(currentDate.monthName()) by Category")
                        Text("\(defaultCurrency.symbol)\(monthSum)")
                    }
                    .position(x: frame.midX, y: frame.midY)
                }
              }
            }
        }
    }
}
