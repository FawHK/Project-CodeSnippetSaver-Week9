//
//  SnippetListView.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 24.09.24.
//

import SwiftUI

struct SnippetListView: View {
    
    // MARK: - Properties
    
    @State var snippets = ["empty"]
    @State private var newSnippet: String = ""
    
    
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Add Snippet")
                    .font(.subheadline)
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    TextField("Your Code snippets", text: $newSnippet)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    Button {
                        addSnippet()
                    } label: {
                        Text("Add")
                    }
                    .padding(.trailing)
                }
                
                List(snippets, id: \.self) { snippet in
                    Section("Categories") {
                        Text(snippet)
                    }
                }
            }
        }
    }
    
    // MARK: - Functions
    
    private func addSnippet() {
        snippets.append(newSnippet)
        newSnippet = ""
    }
}

#Preview {
    SnippetListView()
}
