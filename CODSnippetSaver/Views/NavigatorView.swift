//
//  NavigatorView.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 27.09.24.
//

import SwiftUI

struct NavigatorView: View {
    
    // MARK: - Properties
    
    @StateObject private var snippetViewModel = SnippetViewModel()
    @StateObject private var categoryViewModel = CategoryViewModel()
    @EnvironmentObject var userViewModel: UserViewModel
    
    
    
    // MARK: - Body
    
    var body: some View {
        TabView {
            CategoryListView()
                .tabItem {
                    Label(Tab.categories.name, systemImage: Tab.categories.icon)
                }
                .environmentObject(snippetViewModel)
                .environmentObject(categoryViewModel)
            
            SnippetListView()
                .tabItem {
                    Label(Tab.snippets.name, systemImage: Tab.snippets.icon)
                }
                .environmentObject(snippetViewModel)
            
            ProfileView()
                .tabItem {
                    Label(Tab.profile.name, systemImage: Tab.profile.icon)
                }
                .environmentObject(userViewModel)
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = .black
        }
    }
}

#Preview {
    NavigatorView()
        .environmentObject(UserViewModel())
}
