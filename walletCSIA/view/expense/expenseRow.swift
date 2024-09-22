//
//  expenseRow.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/23.
//

import SwiftUI

struct expenseRow: View {
    private var expense = Expense?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 5)
                .frame(width: 350, height: 100)
            VStack{
                Text("Date of Expense here")
            }
        }
    }
}

#Preview {
    expenseRow()
}
