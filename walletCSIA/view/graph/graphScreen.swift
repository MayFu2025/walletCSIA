//
//  graphScreen.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/19.
//

import SwiftUI
import SwiftData

struct graphScreen: View {
    @State var isPresenting: Bool = false
    @Query var categories: [Category]
    
    var body: some View {
        NavigationStack{
            List(categories) {category in
                                Text(category.name)
                            }
            
            Text("This is month graph screen")
                .navigationTitle("Graph View")
                .toolbar{
                    ToolbarItem() {
                        NewCategoryView()
                        .padding()
                    }
                }
        }
        }
    }

#Preview {
    graphScreen()
}
