//
//  settings.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/17.
//

import SwiftUI

struct settings: View {
    var body: some View {
        NavigationStack{
            List{
                Section(header: Text("User")) {
                    Text("Test text")
                }
            }
            Text("This is settings screen")
                .navigationTitle("Settings")
        }
    }
}

#Preview {
    settings()
}
