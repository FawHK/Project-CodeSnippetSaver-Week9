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
//    var currentSnippet: FireSnippet?
    @State private var title = ""
    @State private var newSnippet: String = ""
    @Binding var isPresented: Bool
    
   
    
    
    // MARK: - Body
    
    var body: some View {
        VStack {
//            List(snippet)

            Text(snippet.title)
            Text(snippet.code)
            Text(snippet.userId ?? "")
            
            Button {
                isPresented.toggle()
            } label: {
                Text("Edit")
            }
        }
    }
}

#Preview {
    SnippetDetailView(snippet: FireSnippet(title: "TEST", code: "FUNCTIONS", userId: "1234567"), isPresented: .constant(true))
        .environmentObject(SnippetViewModel())
}
