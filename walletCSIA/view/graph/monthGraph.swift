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
    var month: Date
    
    @State var isPresenting: Bool = false
    @Query var categories: [Category]
    @Query var expenses: [Expense]
    @Query var currencies: [Currency]
    
    @State private var clickedAngle: Double?
    
    var monthExpenses: Dictionary<Category, [Expense]> {
        sortByCategory(expenseList: sortGivenMonth(dateOfMonth: month, expenses: expenses))
    }
    var monthExpenseTotals: Dictionary<Category, Double> {
        totalsByCategory(expensesSorted: monthExpenses)
    }
    
    var monthSum : Double {
        let thisMonth = sortGivenMonth(dateOfMonth: month, expenses: expenses)
        let amounts = thisMonth.map { $0.adjustedAmount }
        return amounts.reduce(0, +) // basically like the map function of an operation onto a variable (in this case 0), cool
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
                    .foregroundStyle(by: .value("Category", "\(key.name) (\(monthExpenseTotals[key] ?? 0))"))
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
                        Text("\(month.yearValue()) \(month.monthName()) Total")
                        Text("\(defaultCurrency.symbol)\(String(format:"%.2f", monthSum))")
                    }
                    .position(x: frame.midX, y: frame.midY)
                }
              }
            }
        }
    }
}
