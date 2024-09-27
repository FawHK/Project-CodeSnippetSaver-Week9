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
    
    var snippet: FireSnippet?

    
    
    
    // MARK: - Init
    init(snippet: FireSnippet? = nil, isPresented: Binding<Bool>) {
        if let snippet {
            self.snippet = snippet
            self._newSnippet = State(initialValue: snippet.code)
            self._title = State(initialValue: snippet.title)
        }
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
                    Section("Snippet Code") {
                        TextEditor(text: $newSnippet)
                            .frame(height: 500)
                    }
                }
                HStack {
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
            snippetViewModel.addSnippet(title: title, code: newSnippet)
        }
        isPresented.toggle()
//        title = ""
//        newSnippet = ""
    }
}

#Preview {
    SnippetAddView(snippet: FireSnippet(title: "sdsd", code: "sdsd", userId: "erwe"), isPresented: .constant(true))
        .environmentObject(SnippetViewModel())
}
