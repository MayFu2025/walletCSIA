//
//  expenseRow.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/23.
//

import SwiftUI
import SwiftData
import Foundation

struct expenseRow: View {
    @Environment(\.modelContext) private var context
    var expense: Expense
    
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
    
    var body: some View { //TODO: this ugly asf
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 5)
                .frame(width: 350, height: 100)
            
            VStack{
                Text(dateFormatter.string(from: expense.date))
                    .font(.footnote)
                HStack{
                    Text(expense.currency.symbol)
                        .font(.largeTitle)
                    Text(String(expense.amount))
                        .font(.largeTitle)
                }
                Text(expense.category.name)
            }
        }
    }
}

#Preview {
    // Initialize the model container for your model types
    let container = try! ModelContainer(for: Currency.self, creditCard.self, Category.self, Expense.self)
    
        // Create instances of your models
        let category = Category(name: "Test", isDefault: true)
        let currency = Currency(acronym: "JPY", isDefault: true)
        let creditCard = creditCard(name: "Test Card", holder: "May", color1: .red, color2: .blue, cardProvider: "VisaIcon", defaultCurrency: currency, cashbackRate: 0.05)
        let expense = Expense(amount: 10.0, date: .init(), category: category, card: creditCard, currency: currency, note: "")
        
        // Use the modelContext to insert objects into the container
        let context = container.mainContext
        context.insert(category)
        context.insert(currency)
        context.insert(creditCard)
        context.insert(expense)
    
    // Return the view with the modelContext applied
    return expenseRow(expense: expense)
        .modelContext(context)
}

