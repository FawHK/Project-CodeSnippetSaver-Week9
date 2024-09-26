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
    
    @Published var user: FireUser?
    @Published var errorMessage: String?
    
    var userIsLoggedIn: Bool {
        user != nil
    }
    
    
    
    // MARK: - Init
    
    init() {
        checkAuth()
    }
    
    
    
    // MARK: - Function
    
    private func checkAuth() {
        guard let user = FirebaseManager.shared.auth.currentUser else { return }
        self.fetchUser(with: user.uid)
    }
    
    func loginAnonymously() {
        FirebaseManager.shared.auth.signInAnonymously { authResult, error in
            if let error {
                print("Error signing in anonymously", error)
                return
            }
            
            guard let authResult else {
                print("Authintication Failure")
                return
            }
            print("User is signed in anonymously, ID: \(authResult.user.uid)")
            self.createUser(withId: authResult.user.uid, email: nil)
        }
    }
    
    func register(email: String, password: String) {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                self.handleError(error)
                return
            }
            
            guard let authResult, let email = authResult.user.email else { return }
            
            print("User with email '\(email)' is registered with id '\(authResult.user.uid)'")
            self.createUser(withId: authResult.user.uid, email: authResult.user.email)
        }
    }
    
    func login(email: String, password: String) {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                self.handleError(error)
                print("Login failed: ", error.localizedDescription)
                return
            }
            guard let authResult, let email = authResult.user.email else { return }
            print("User with email '\(email)' is logged in with id ‘\(authResult.user.uid)'")
            self.fetchUser(with: authResult.user.uid)
            
        }
    }
    
    private func handleError(_ error: Error) {
        
        switch error {
        case AuthErrorCode.emailAlreadyInUse:
            errorMessage = "The email is already in use"
        case AuthErrorCode.weakPassword :
            errorMessage = "The Password is too weak/short"
        case AuthErrorCode.invalidEmail:
            errorMessage = "The email is not valid"
        default:
            errorMessage = "Unknown Error occured"
        }
    }
    
    private func createUser(withId id: String, email: String?) {
        let newUser = FireUser(id: id, email: email ,registeredOn: Date())
        
        //        let user = FireUser(id: id, email: email, registeredOn: Date(), name: user.name, nickName: user?.nickName, age: user?.age)
        
        
        do {
            try FirebaseManager.shared.database.collection("Users").document(id).setData(from: newUser)
            self.fetchUser(with: id)
        } catch {
            print("Failed to save user: \(error)")
        }
    }
    
    private func fetchUser(with userId: String) {
        FirebaseManager.shared.database.collection("Users").document(userId).addSnapshotListener { document, error in
            if let error {
                print(error)
                return
            }
            
            guard let document else { return }
            
            do {
                let user = try document.data(as: FireUser.self)
                self.user = user
            } catch {
                print("Dokument ist kein User")
            }
        }
    }
    func editUserDetails(withId id: String, email: String, name: String, age: String, nickName: String) {
        FirebaseManager.shared.database.collection("Users").document(id).updateData(["email": email,"name": name, "age": age, "nickName": nickName]) { error in
            if error != nil {
                print("Details update Failed")
                return
            }
            print("Details updated")
        }
   
    }
}
