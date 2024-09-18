//
//  instanceListEditor.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/19.
//

import SwiftUI

struct instanceListEditor: View {
    var items = [Any]
    
    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                    Text(item)
                }
            }
    }
}

#Preview {
    instanceListEditor()
}
