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
                ScrollView {
                    Text(snippet.code)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.blue.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        
                    
                }
                .padding(.horizontal)
            }
            PrimaryButtonView(title: "Edit", action: editSnippet)
            
            .navigationTitle(snippet.title)
            .navigationBarTitleDisplayMode(.inline)
        }
        .background(.black)
        .sheet(isPresented: $isPresented) {
            SnippetAddView(snippet: snippet, isPresented: $isPresented)
        }
        .environmentObject(snippetViewModel)
    }
    
    // MARK: - Functions
    
    private func editSnippet() {
        isPresented.toggle()
    } 
}

#Preview {
    SnippetDetailView(snippet: FireSnippet(title: "TEST", code: """
private var auth = Auth.auth()
@Published var user: User?

func register(email: String, password: String) {
    auth.createUser(withEmail: email, password: password) { authResult, error in
        if let error {
            print("Login failed: ", error.localizedDescription)
            return
        }
        
        guard let authResult, let email = authResult.user.email else { return }
        
        print("User with email 'fawwaz.hk@gmail' is registered with id 111111111")
        self.user = authResult.user
    }
}
private var auth = Auth.auth()
@Published var user: User?

func register(email: String, password: String) {
    auth.createUser(withEmail: email, password: password) { authResult, error in
        if let error {
            print("Login failed: ", error.localizedDescription)
            return
        }
        
        guard let authResult, let email = authResult.user.email else { return }
        
        print("User with email 'fawwaz.hk@gmail' is registered with id 111111111")
        self.user = authResult.user
    }
}
private var auth = Auth.auth()
@Published var user: User?

func register(email: String, password: String) {
    auth.createUser(withEmail: email, password: password) { authResult, error in
        if let error {
            print("Login failed: ", error.localizedDescription)
            return
        }
        
        guard let authResult, let email = authResult.user.email else { return }
        
        print("User with email 'fawwaz.hk@gmail' is registered with id 111111111")
        self.user = authResult.user
    }
}
""", userId: "1234567", categoryId: "444"))
        .environmentObject(SnippetViewModel())
}


