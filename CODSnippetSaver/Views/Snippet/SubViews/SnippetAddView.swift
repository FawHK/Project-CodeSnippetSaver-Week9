//
//  SnippetEditView.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 26.09.24.
//

import SwiftUI

struct SnippetAddView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var snippetViewModel: SnippetViewModel
    @EnvironmentObject var categoryViewModel: CategoryViewModel
    
    @State private var title = ""
    @State private var newSnippet: String = ""
    @State private var selectedCategoryId: String?
    
    @Binding var isPresented: Bool
    
    var snippet: FireSnippet?
    var category: FireCategory?

    
    
    
    // MARK: - Init
    
    init(snippet: FireSnippet? = nil, category: FireCategory? = nil, isPresented: Binding<Bool>) {
        if let snippet {
            self.snippet = snippet
            self._newSnippet = State(initialValue: snippet.code)
            self._title = State(initialValue: snippet.title)
        }
        self.category = category
        self._isPresented = isPresented
       
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("Snippet Title") {
                        TextField("", text: $title)
                    }
                    Section("Category") {
                        Picker("", selection: $selectedCategoryId) {
                            ForEach(categoryViewModel.categories) { cat in
                                Text(cat.title).tag(cat.id)
                            }
                        }
                        .pickerStyle(.menu)
                        .onAppear {
                            if let category { selectedCategoryId = category.id }
                        }
                    }
                    Section("Snippet Code") {
                        TextEditor(text: $newSnippet)
                            .frame(height: 500)
                    }
                }
               
                PrimaryButtonView(title: "Save", action: saveSnippet)
            }
            .navigationTitle("Add Snippet")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .tint(.red)
                    }
                }
            }
        }
        .environmentObject(snippetViewModel)
    }
    
    // MARK: - Functions
    
    private func saveSnippet() {
        if let snippet {
            snippetViewModel.updateSnippet(with: snippet.id, title: title , code: newSnippet)
        } else {
            guard let categoryId = selectedCategoryId ?? category?.id else { return }
            snippetViewModel.addSnippet(title: title, code: newSnippet, categoryId: categoryId)
            title = ""
            newSnippet = ""
        }
        isPresented.toggle()
    }
}

#Preview {
    SnippetAddView(snippet: FireSnippet(title: "sdsd", code: "sdsd", userId: "erwe", categoryId: "cat1"), isPresented: .constant(true))
        .environmentObject(SnippetViewModel())
        .environmentObject(CategoryViewModel())
}
