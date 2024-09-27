//
//  CategoryListView.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 24.09.24.
//

import SwiftUI

struct CategoryListView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var snippetViewModel: SnippetViewModel
    
    @State var categories = ["Swift"]
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
                    TextField("Category", text: $newCategory)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    Button {
                        addCategory()
                    } label: {
                        Text("Add")
                    }
                    .padding(.trailing)
                }
                
                List(categories, id: \.self) { category in
                    Section("Categories") {
                        NavigationLink {
                            SnippetListView()
                        } label: {
                            Text(category)
                        }
                    }
                }
            }
        }
        .environmentObject(snippetViewModel)
    }
    // MARK: - Functions
    
    private func addCategory() {
        categories.append(newCategory)
        newCategory = ""
    }
}

#Preview {
    CategoryListView()
        .environmentObject(SnippetViewModel())
}
