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
    
    var cardExpenses: [Expense] {
        expenses.filter { expense in
            return expense.card == cardViewed
        }
    }
    
    var body: some View {
        NavigationView{
            cardShape(cardName: cardViewed.name, holderName: cardViewed.holder, providerIcon: cardViewed.cardProvider, color1: cardViewed.color1, color2: cardViewed.color2)
            List{
            }
                .navigationTitle("Expenses on \(cardViewed.name)")
        }
        
        
    }
}

//#Preview {
//    perCardView(creditCard)
//}
