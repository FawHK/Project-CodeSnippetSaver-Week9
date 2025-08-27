//
//  CategoryViewModel.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 29.09.24.
//

import Foundation
import FirebaseFirestore

class CategoryViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var categories: [FireCategory] = []
    @Published var snippets: [FireSnippet] = []
    
    private var categoryListener: ListenerRegistration?
    private var snippetListener: ListenerRegistration?
    
    // MARK: - Init
    
    init() {
        fetchCategories()
    }
    
    
    
    // MARK: - Functions
    
    func clearCategories() {
        categories.removeAll()
        snippets.removeAll()
        snippetListener?.remove()
        categoryListener?.remove()
    }
    
    func fetchCategories() {
        guard let userId = FirebaseManager.shared.userId else { return }
        
        categoryListener = FirebaseManager.shared.database.collection("Categories")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { querySnapshot, error in
            if let error {
                print("Error fetching categories", error)
                return
            }
            guard let documents = querySnapshot?.documents else {
                print("Loading categories Failed")
                return
            }
            self.categories = documents.compactMap {
                try? $0.data(as: FireCategory.self)
            }
        }
    }
    
    func fetchSnippets(for category: FireCategory) {
        guard let categoryId = category.id else { return }
        guard let userId = FirebaseManager.shared.userId else { return }
        
        
       snippetListener = FirebaseManager.shared.database.collection("Snippets")
            .whereField("userId", isEqualTo: userId)
            .whereField("categoryId", isEqualTo: categoryId)
            .addSnapshotListener { querySnapshot, error in
                if let error {
                    print("Error fetching snippets", error)
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching snippets")
                    return
                }
                self.snippets = documents.compactMap {
                    try? $0.data(as: FireSnippet.self)
                }
            }
    }
    
    func addCategory(title: String) {
        guard let userId = FirebaseManager.shared.userId else { return }
        
        let category = FireCategory(title: title, userId: userId)
        
        do {
            try FirebaseManager.shared.database.collection("Categories").addDocument(from: category)
        } catch {
            print("Error adding category", error)
        }
        
    }
    
    func deleteCategory(with id: String?) {
        guard let id else { return }
        
        FirebaseManager.shared.database.collection("Categories").document(id).delete() { error in
            if let error {
                print("Category could not be deleted", error)
                return
            }
            print("Category with ID: \(id) deleted successfully")
        }
    }
}
