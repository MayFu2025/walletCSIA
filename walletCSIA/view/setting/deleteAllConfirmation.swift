//
//  deleteAllConfirmation.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/25.
//

import SwiftUI

struct deleteAllConfirmation: View {
    @Environment(\.modelContext) private var context
    @State private var showDeleteConfirmation: Bool = false
    
    var body: some View {
        Button(action: {
            self.showDeleteConfirmation = true
        }) {
            Text("Delete all Entries")
        }
        
        .alert("Delete all Entries?\n(Doing this will delete all credit cards, categories, currencies, and expenses!)", isPresented: $showDeleteConfirmation) {
            Button("Confirm") {
                do {
                    try context.delete(model: Currency.self)
                    try context.delete(model: Category.self)
                    try context.delete(model: creditCard.self)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            Button("Cancel", role: .cancel, action: {})
            }
        }
    }

#Preview {
    deleteAllConfirmation()
}
