//
//  EditProfileView.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 25.09.24.
//

import SwiftUI

struct EditProfileView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var userViewModel: UserViewModel
    
    @State private var email = ""
    @State private var name = ""
    @State private var age = ""
    @State private var nickname = ""
    
    @Binding var isPresented: Bool
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("", text: $name)
                }
                Section("Age") {
                    TextField("", text: $age)
                        .keyboardType(.numberPad)
                }
                Section("Nickname") {
                    TextField("", text: $nickname)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .tint(.red)
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: editUser) {
                       Text("Save")
                    }
                }
            }
            .onAppear {
                name = userViewModel.user?.name ?? ""
                age = userViewModel.user?.age ?? ""
                nickname = userViewModel.user?.nickName ?? ""
            }
        }
    }
    
    // MARK: - Functions
    
    private func editUser() {
        userViewModel.editUserDetails(withId: userViewModel.user?.id ?? "", name: name, age: age, nickName: nickname)
        isPresented.toggle()
    }
}

#Preview {
    EditProfileView(isPresented: .constant(true))
        .environmentObject(UserViewModel())
}
