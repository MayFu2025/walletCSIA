//
//  graphView.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/25.
//

import SwiftUI

struct graphScreen: View {
    var body: some View {
        NavigationStack {
            monthGraph()
                .navigationTitle("Monthly Graph")
        }
    }
}

#Preview {
    graphScreen()
}
