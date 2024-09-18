//
//  newCategory.swift
//  walletCSIA
//
//  Created by May Fujita on 2024/09/19.
//

import SwiftUI
import SwiftData

struct NewCategoryView: View {
    @Environment(\.modelContext) private var context
    
    @State private var categoryName: String = ""
    @State private var showCategoryPopup: Bool = false
    
    @Query var categories: [Category]
    
    var body: some View {
        Button(action: {
            self.categoryName = ""
            self.showCategoryPopup = true
        }) {
            Image(systemName: "plus")
        }
        // Move the alert modifier outside the Button's label
        .alert("Enter New Category Name", isPresented: $showCategoryPopup) {
            TextField("Category Name", text: $categoryName)
            Button("Confirm") {
                newCategoryObject(categoryName: categoryName)
            }
            Button("Cancel", role: .cancel, action: {})
        }
    }
    
    func newCategoryObject(categoryName: String) {
        let newCategory = Category(name: categoryName)
        context.insert(newCategory)
        do {
            try context.save()
            print("Category saved: \(newCategory.name)")
        } catch {
            print("Failed to save category: \(error)")
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Category.self)
    return NewCategoryView()
        .modelContext(container.mainContext)
}
