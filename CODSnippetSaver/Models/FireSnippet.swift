//
//  FireSnippet.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 26.09.24.
//

import Foundation
import FirebaseFirestore


struct FireSnippet: Codable, Identifiable {
    @DocumentID var id: String?
    
    let title: String
    let code: String
    let userId: String?
    
}
