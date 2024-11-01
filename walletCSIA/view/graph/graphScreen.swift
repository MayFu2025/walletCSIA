//
//  graphView.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/25.
//

import SwiftUI

struct graphScreen: View {
    @State var graphDate: Date
    
    var body: some View {
        NavigationStack {
            
            DatePicker("Get Month from Date",
                    selection: $graphDate,
                       displayedComponents: [.date]
                )
                .datePickerStyle(.compact)
            
            monthGraph()  //TODO: work on this
                .navigationTitle("Monthly Graph")
        }
    }
}
