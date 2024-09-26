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
    
    @State private var title = ""
    @State private var newSnippet: String = ""
    @Binding var isPresented: Bool
    private var snippetToEdit: FireSnippet?
    
    
    
    
    // MARK: - Init
    init(isPresented: Binding<Bool>, snippetToEdit: FireSnippet? = nil) {
        self._isPresented = isPresented
        self.snippetToEdit = snippetToEdit
        if let snippet = snippetToEdit {
            title = snippet.title
            newSnippet = snippet.code
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("Snippet Title") {
                        TextField("", text: $title)
                    }
                    Section("Snippet Code") {
                        TextEditor(text: $newSnippet)
                            .frame(height: 500)
                    }
                }
                Button(action: saveSnippet) {
                    Text("Save")
                        .padding()
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .background(.red.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal)
                }
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
        if let snippetToEdit = snippetToEdit {
            let updatedSnippet = snippetToEdit
            title = updatedSnippet.title
            newSnippet = updatedSnippet.code
            snippetViewModel.updateSnippet(with: snippetToEdit.id, title: title, code: newSnippet)
        } else {
            snippetViewModel.addSnippet(title: title, code: newSnippet)
            isPresented.toggle()
            title = ""
            newSnippet = ""
        }
    }
}

#Preview {
    SnippetAddView(isPresented: .constant(true))
        .environmentObject(SnippetViewModel())
}
