//
//  perCardView.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/26.
//

import SwiftUI
import SwiftData

struct perCardView: View {
    let cardViewed: creditCard
    @Query var expenses: [Expense]
    
    @State private var showEditCardSheet: Bool = false
    @State var monthDate: Date = Date()
    
    private var cardExpenses: [Expense] {
        expenses.filter { expense in
            return expense.card == cardViewed
        }
    }
    private var cardExpensesByDate: Dictionary<Date, [Expense]> {sortByDate(expenseList: cardExpenses)}
    
    private var monthSum : Double {
        let expenseArray = sortGivenMonth(dateOfMonth: monthDate, expenses: cardExpenses)
        let amounts = expenseArray.map { $0.adjustedAmount }
        return amounts.reduce(0, +)
    }
    private var monthCashback : Double {
        return monthSum * cardViewed.cashbackRate
    }
    
    
    var body: some View {
        NavigationStack{
            List{
                Section("Statistics"){
                    HStack{
                        DatePicker("Get Month from Date:",
                                   selection: $monthDate,
                                   displayedComponents: [.date]
                        )
                        .datePickerStyle(.compact)
                        Spacer()
                    }
                    cardGraph(card: cardViewed, expenses: cardExpenses, month: monthDate)
                    Text("Month Cashback: \(cardViewed.defaultCurrency.symbol) \(monthCashback)")
                }
                
                ForEach(cardExpensesByDate.keys.sorted(), id: \.self) { date in
                    Section(header: Text(date.dashSeparated())) {
                        if let expensesForDate = cardExpensesByDate[date] {
                            ForEach(expensesForDate, id: \.self) { expense in
                                NavigationLink(destination: expenseDetails(expense: expense)) {
                                    HStack{
                                        Text(expense.currency.symbol)
                                        Text(String(format: "%.2f", expense.amount))
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Card: \(cardViewed.name)")
            .toolbar{
                ToolbarItem{
                    Button(action: {showEditCardSheet.toggle()}, label: {
                        Image(systemName: "pencil")
                    })
                    .padding()
                    .sheet(isPresented: $showEditCardSheet) {
                        editCardSheet(cardEditing: cardViewed)
                    }
                }
            }
        }
    }
}

//#Preview {
//    perCardView(creditCard)
//}

//cardShape(cardName: cardViewed.name, holderName: cardViewed.holder, providerIcon: cardViewed.cardProvider, color1: cardViewed.color1, color2: cardViewed.color2)
