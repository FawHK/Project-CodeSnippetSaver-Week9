//
//  LoginView.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 24.09.24.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - Properties
    
    @ObservedObject var userViewModel: UserViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            
            //            Button {
            //                userViewModel.register(email: userViewModel.email, password: userViewModel.password)
            //            } label: {
            //                Text("Register")
            //                    .padding()
            //                    .foregroundStyle(.white)
            //                    .frame(maxWidth: .infinity)
            //                    .background(.blue.opacity(0.5))
            //                    .clipShape(RoundedRectangle(cornerRadius: 10))
            //            }
            //
            //            Button {
            //                userViewModel.login(email: userViewModel.email, password: userViewModel.password)
            //            } label: {
            //                Text("Login")
            //                    .padding()
            //                    .foregroundStyle(.white)
            //                    .frame(maxWidth: .infinity)
            //                    .background(.yellow.opacity(0.5))
            //                    .clipShape(RoundedRectangle(cornerRadius: 10))
            //            }
            
            Button {
                userViewModel.loginAnonymously()
            } label: {
                Text("As a Guest")
                    .padding()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .background(.brown.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            
            
        }
    }
}

#Preview {
    LoginView(userViewModel: UserViewModel())
}
