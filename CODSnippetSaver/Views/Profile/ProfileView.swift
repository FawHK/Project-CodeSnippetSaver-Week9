//
//  ProfileView.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 25.09.24.
//

import SwiftUI

struct ProfileView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var userViewModel: UserViewModel
    
    @State private var showEditSheet = false
    
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let userDetails = [
                    "ID: \(userViewModel.user?.id ?? "")",
                    "Name: \(userViewModel.user?.name ?? "")",
                    "Email: \(userViewModel.user?.email ?? "")",
                    "Age: \(userViewModel.user?.age ?? "")",
                    "Nickname: \(userViewModel.user?.nickName ?? "")",
                    "Regiastered on: \(userViewModel.user?.registeredOn.formatted(date: .abbreviated,time: .omitted) ?? "")"
                ]
                VStack {
                    ForEach(userDetails, id: \.self) { text in
                        Text(text)
                            .font(.subheadline)
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.blue.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
            }
            .padding()
            
            PrimaryButtonView(title: "Sign out", action: logout)
            
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button(action: editProfile) {
                        Text("Edit")
                            .foregroundStyle(.blue)
                    }
                }
            }
        }
        .sheet(isPresented: $showEditSheet) {
            EditProfileView(isPresented: $showEditSheet)
                .presentationDetents([.medium, .large])
        }
        .environmentObject(userViewModel)
    }
    
    // MARK: - Functions
    
    private func logout() {
        userViewModel.logout()
    }
    
    private func editProfile() {
        showEditSheet.toggle()
    }
}

#Preview {
    ProfileView()
        .environmentObject(UserViewModel())
}
