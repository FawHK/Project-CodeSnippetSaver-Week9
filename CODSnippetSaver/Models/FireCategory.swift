//
//  FireCategory.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 29.09.24.
//

import Foundation
import FirebaseFirestore

struct FireCategory: Codable, Identifiable {
    @DocumentID var id: String?
    
    let title: String
    var userId: String
}
