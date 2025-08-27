//
//  SnippetViewModel.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 26.09.24.
//

import Foundation
import FirebaseFirestore


class SnippetViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var snippets: [FireSnippet] = []
    
    private var categoryId: String?
    
    
    
    // MARK: - Init
    
    init() {
        fetchSnippets()
    }
    
    init(categoryId: String?) {
        self.categoryId = categoryId
        fetchSnippets()
    }
    
    
    
    // MARK: - Functions
    
    func fetchSnippets(searchText: String = "") {
        guard let userId = FirebaseManager.shared.userId else { return }
        
        var query = FirebaseManager.shared.database.collection("Snippets")
            .whereField("userId", isEqualTo: userId)
        
        if let categoryId {
            query = query.whereField("categoryId", isEqualTo: categoryId)
        }
        
        if !searchText.isEmpty {
            query =
            query.whereField("title", isGreaterThanOrEqualTo: searchText)
            query.order(by: "title")
        }
        query.addSnapshotListener { querySnapshot, error in
            if let error {
                print(error)
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("Loading Failed")
                return
            }
            
            self.snippets = documents.compactMap {
                try? $0.data(as: FireSnippet.self)
            }
            
        }
    }
    
    func addSnippet(title: String, code: String, categoryId: String) {
        guard let userId = FirebaseManager.shared.userId else { return }
      
        
        let snippet = FireSnippet(title: title, code: code, userId: userId, categoryId: categoryId)
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
    
    func searchSnippets(byTitle title: String) {
        self.snippets = snippets.filter { $0.title.lowercased().contains(title.lowercased()) }
    }
}
