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
                cardShape(cardName: card.name, holderName: card.holder, providerIcon: card.cardProvider, color1: card.color1, color2: card.color2)
            }
            Text("I need this to show the navigation title :(")
            .navigationTitle("My Cards")
            .toolbar{
                ToolbarItem{
                    Button(action: {showNewCardSheet.toggle()}, label: {
                        Image(systemName: "plus")
                    }).padding()
                }
            }
        }
    }
}

#Preview {
    allCards()
}
