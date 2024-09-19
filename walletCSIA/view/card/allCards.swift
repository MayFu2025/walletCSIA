//
//  allCards.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/17.
//

import SwiftUI
import SwiftData

struct allCards: View {
    @Environment(\.modelContext) private var context
    @Query var creditCards: [creditCard]
    
    @State private var showNewCardSheet: Bool = false
    
    var body: some View {
        NavigationStack{
            ForEach(creditCards, id: \.self) { card in
                cardShape(card_name: card.name, holder_name: card.holder, providerIcon: card.cardProvider, color1: card.color1, color2: card.color2)
            }
                .navigationTitle("My Cards")
        }
    }
}

#Preview {
    allCards()
}
