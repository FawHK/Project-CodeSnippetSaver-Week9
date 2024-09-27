//
//  SnippetViewModel.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 26.09.24.
//

import Foundation


class SnippetViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var snippets: [FireSnippet] = []

    
    
    
    // MARK: - Init
    
    init() {
        fetchSnippets()
    }
    
    
    
    // MARK: - Functions
    
    func addSnippet(title: String, code: String) {
        guard let userId = FirebaseManager.shared.userId else { return }
        
        let snippet = FireSnippet(title: title, code: code, userId: userId)
        do {
            try FirebaseManager.shared.database.collection("Snippets").addDocument(from: snippet)
        } catch {
            print("Add Snippet Error", error)
        }
    }
    
    func deleteSnippet(with id: String?) {
        guard let id else { return }
        
        FirebaseManager.shared.database.collection("Snippets").document(id).delete() { error in
            if let error {
                print("Snippet could not be deleted", error)
                return
            }
            print("Snippet with ID: \(id) deleted successfully")
        }
    }
    
    
    func fetchSnippets() {
        guard let userId = FirebaseManager.shared.userId else { return }
        
        FirebaseManager.shared.database.collection("Snippets")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { querySnapshot, error in
                if let error {
                    print(error)
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("Fehler beim Laden der Tasks")
                    return
                }
                
                self.snippets = documents.compactMap {
                    try? $0.data(as: FireSnippet.self)
                }
            }
    }
    
    func updateSnippet(with id: String?, title: String, code: String) {
        guard let id else { return }
        
        let data = ["title": title, "code": code]
        
        FirebaseManager.shared.database.collection("Snippets").document(id).updateData(data) { error in
            if let error {
                print("Snippet update Failed", error)
                return
            }
            
            print("Snippet updated!")
        }
    }
}
