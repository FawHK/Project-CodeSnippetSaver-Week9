//
//  CODSnippetSaverApp.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 23.09.24.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct CODSnippetSaverApp: App {
    
    // MARK: - Init
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            CODSnippetView()
        }
    }
}
