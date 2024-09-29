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
    
    // MARK: - Properties
    
    @StateObject private var userViewModel = UserViewModel()
    
    
    
    // MARK: - Init
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            if userViewModel.userIsLoggedIn {
                NavigatorView()
                    .environmentObject(userViewModel)
                    .preferredColorScheme(.dark)
            } else {
                LoginView()
                    .environmentObject(userViewModel)
                    .preferredColorScheme(.dark)
            }
        } 
    }
}
