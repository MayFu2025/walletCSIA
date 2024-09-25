//
//  sortByCategory.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/25.
//

import Foundation

func sortThisMonth(expenses: [Expense]) -> [Expense]{
    let currentDate = Date()
    let calendar = Calendar.current
    let currentYear = calendar.component(.year, from: currentDate)
    let currentMonth = calendar.component(.month, from: currentDate)
    
    let filteredExpenses = expenses.filter { expense in
        let expenseYear = calendar.component(.year, from: expense.date)
        let expenseMonth = calendar.component(.month, from: expense.date)
        return expenseYear == currentYear && expenseMonth == currentMonth
    }
    
    return filteredExpenses
}


func sortThisYear(expenses: [Expense]) -> [Expense]{
    let currentDate = Date()
    let calendar = Calendar.current
    let currentYear = calendar.component(.year, from: currentDate)
    
    let filteredExpenses = expenses.filter { expense in
        let expenseYear = calendar.component(.year, from: expense.date)
        return expenseYear == currentYear
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
            sum += ex.amount
        }
        totalsDictionary[key] = sum
    }
    return totalsDictionary
}
