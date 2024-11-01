//
//  sortByCategory.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/25.
//

import Foundation

func sortGivenMonth(dateOfMonth: Date, expenses: [Expense]) -> [Expense]{
    let calendar = Calendar.current
    let givenYear = calendar.component(.year, from: dateOfMonth)
    let givenMonth = calendar.component(.month, from: dateOfMonth)
    
    let filteredExpenses = expenses.filter { expense in
        let expenseYear = calendar.component(.year, from: expense.date)
        let expenseMonth = calendar.component(.month, from: expense.date)
        return expenseYear == givenYear && expenseMonth == givenMonth
    }
    
    return filteredExpenses
}


func sortByCategory(expenseList: [Expense]) -> Dictionary<Category, [Expense]> {
    return Dictionary(grouping: expenseList, by: {$0.category})
}


func totalsByCategory(expensesSorted: Dictionary<Category, [Expense]>) -> Dictionary<Category, Double> {
    var totalsDictionary = [Category: Double]()
    for (key, value) in expensesSorted {
        var sum = 0.0
        for ex in value {
            sum += ex.adjustedAmount
        }
        totalsDictionary[key] = sum
    }
    return totalsDictionary
}

func sortByDate(expenseList: [Expense]) -> Dictionary<Date, [Expense]> {
    return Dictionary(grouping: expenseList, by: {$0.date})
}
