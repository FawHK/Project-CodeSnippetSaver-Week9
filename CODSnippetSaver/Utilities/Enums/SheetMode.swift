//
//  SheetMode.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 27.09.24.
//

import Foundation

enum SheetMode: String, Identifiable {
    case add, edit
    
    var id: String { rawValue }
}
