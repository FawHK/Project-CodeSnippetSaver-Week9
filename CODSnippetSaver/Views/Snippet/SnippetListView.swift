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
    
    @State private var showAddSheet: Bool = false
    
    
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(snippetViewModel.snippets) { snippet in
                        NavigationLink {
                            SnippetDetailView(snippet: snippet)
                        } label: {
                            Text(snippet.title)
                            Text(snippet.code)
                            
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
                
                Button {
                    showAddSheet.toggle()
                } label: {
                    Text("Add")
                        .foregroundStyle(.blue)
                }
            }
            .navigationTitle("Your Snippets")
            .sheet(isPresented: $showAddSheet) {
                SnippetAddView(isPresented: $showAddSheet)
            }
        }
        .environmentObject(snippetViewModel)
    }
}

#Preview {
    SnippetListView()
        .environmentObject(SnippetViewModel())
}
