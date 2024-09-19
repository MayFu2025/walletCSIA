//
//  instanceListEditor.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/19.
//

import SwiftUI
import SwiftData

struct categoryListEditor: View {
    @Query var categories: [Category]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories, id: \.self) { category in
                    Text(category.name)
                    }
                .onDelete(perform: {})
                }
            .navigationTitle("All Categories")
            .toolbar{
                ToolbarItem{
                    Button(action: {}, label: {Image(systemName:"plus")})
                        .padding()
                }
            }
        }
    }
    
    func deleteItem() {
        
    }
}

#Preview {
    categoryListEditor()
}
