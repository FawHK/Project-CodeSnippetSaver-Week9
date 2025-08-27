//
//  SnippetListView.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 24.09.24.
//

import SwiftUI

struct SnippetListView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var snippetViewModel: SnippetViewModel
    var category: FireCategory?
    
    @State private var showAddSheet: Bool = false
    @State private var searchText = ""
    
    
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Search", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        snippetViewModel.searchSnippets(byTitle: searchText)
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    .padding(.leading)
                }
                .padding()
                
                List {
                    ForEach(snippetViewModel.snippets) { snippet in
                        NavigationLink {
                            SnippetDetailView(snippet: snippet)
                        } label: {
                            Text(snippet.title)
                                .swipeActions {
                                    Button {
                                        snippetViewModel.deleteSnippet(with: snippet.id)
                                    } label: {
                                        Image(systemName: "trash")
                                            .tint(.red)
                                    }
                                }
                        }
                    }
                }
                
                PrimaryButtonView(title: "Add", action: addSnippet)
            }
            .navigationTitle("Your Snippets")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showAddSheet) {
                SnippetAddView(category: category, isPresented: $showAddSheet)
            }
        }
        .onChange(of: searchText) {
            snippetViewModel.fetchSnippets()
        }
        .environmentObject(snippetViewModel)
    }
    
    // MARK: - Functions
    
    private func addSnippet() {
        showAddSheet.toggle()
    }
}

#Preview {
    SnippetListView()
        .environmentObject(SnippetViewModel())
}
