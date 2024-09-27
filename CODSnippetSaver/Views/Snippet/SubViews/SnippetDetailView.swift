//
//  SnippetDetailView.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 26.09.24.
//

import SwiftUI


struct SnippetDetailView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var snippetViewModel: SnippetViewModel
    
    let snippet: FireSnippet

    @State private var isPresented = false
    
   
    
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(snippet.title)
                Text(snippet.code)
                
                Button {
                    isPresented.toggle()
                } label: {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            SnippetAddView(snippet: snippet, isPresented: $isPresented)
        }
        .environmentObject(snippetViewModel)
    }
    
}

#Preview {
    SnippetDetailView(snippet: FireSnippet(title: "TEST", code: "FUNCTIONS", userId: "1234567"))
        .environmentObject(SnippetViewModel())
}
