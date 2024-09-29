//
//  Tab.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 27.09.24.
//

import Foundation

enum Tab: String ,Identifiable {
    case categories, snippets, profile
    
    var id: String { rawValue }
    
    var name: String {
        switch self {
        case .categories: "Categories"
        case .snippets: "Snippets"
        case .profile: "Profile"
        }
    }
    var icon: String {
        switch self {
        case .categories: "square.grid.3x3.topright.fill"
        case .snippets: "curlybraces.square"
        case .profile: "person.crop.circle.fill"
        }
    }

}
