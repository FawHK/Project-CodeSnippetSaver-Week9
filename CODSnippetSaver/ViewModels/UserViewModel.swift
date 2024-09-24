//
//  UserViewModel.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 24.09.24.
//

import Foundation
import FirebaseAuth


class UserViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let auth = Auth.auth()
    
    @Published var user: User?
    
    var userIsLoggedIn: Bool {
        user != nil
    }
    
    
    
    // MARK: - Init
     
    init() {
        checkAuth()
    }
    

    
    // MARK: - Function
    
    private func checkAuth() {
        guard let user = auth.currentUser else { return }
        self.user = user
    }
    
    func loginAnonymously() {
        auth.signInAnonymously { authResult, error in
            if let error {
                print("Error signing in anonymously", error)
                return
            }
            
            guard let authResult else {
                print("Authintication Failure")
                return
            }
            print("User is signed in anonymously, ID: \(authResult.user.uid)")
            self.user = authResult.user
        }
    }
}
