//
//  CategoryListView.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 24.09.24.
//

import SwiftUI

struct CategoryListView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var categoryViewModel: CategoryViewModel
    @EnvironmentObject var snippetViewModel: SnippetViewModel
    
    @State private var newCategory: String = ""
    
    
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Add Category")
                    .font(.subheadline)
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                HStack {
                    TextField("", text: $newCategory)
                        .textFieldStyle(.roundedBorder)
                        .padding(.leading)
                    Button(action: addCategory) {
                        Image(systemName: "plus.circle")
                            .tint(.turquoise)
                    }
                    .disabled(newCategory.isEmpty)
                    .padding(.trailing)
                }
                
                List(categoryViewModel.categories) { category in
                        NavigationLink {
                            SnippetListView(category: category)
                                .environmentObject(SnippetViewModel(categoryId: category.id))
                        } label: {
                            Text(category.title)
                                .swipeActions {
                                    Button {
                                        categoryViewModel.deleteCategory(with: category.id)
                                    } label: {
                                        Image(systemName: "trash")
                                            .tint(.red)
                                    }
                                }
                        }
                }
            }
        }
        .environmentObject(snippetViewModel)
        .environmentObject(categoryViewModel)
    }
    // MARK: - Functions
    
    private func addCategory() {
        categoryViewModel.addCategory(title: newCategory)
    }
}

#Preview {
    CategoryListView()
        .environmentObject(SnippetViewModel())
        .environmentObject(CategoryViewModel())
}
