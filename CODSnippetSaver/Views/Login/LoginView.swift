//
//  LoginView.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 24.09.24.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var userViewModel: UserViewModel

    @State private var email = ""
    @State private var password = ""
    
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Text("Log In")
                .font(.largeTitle)
                .fontDesign(.rounded)
                .bold()
                .padding(.bottom, 50)
            
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .frame(width: 280)
                
            
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .frame(width: 280)
                .padding(.bottom, 50)
            
            if let error = userViewModel.errorMessage {
                Text(error)
            }
      
            
            HStack {
                Button {
                    userViewModel.login(email: email, password: password)
                    
                    
                } label: {
                    Text("Log In")
                        .padding()
                        .foregroundStyle(.white)
                        .frame(width: 140)
                        .background(.yellow.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Button {
                    userViewModel.loginAnonymously()
                } label: {
                    Text("As a Guest")
                        .padding()
                        .foregroundStyle(.white)
                        .frame(width: 140)
                        .background(.brown.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            Spacer()
            
            HStack {
                Text("Don't have an account ? ")
                    .font(.subheadline)
                    .bold()
                
                Button {
                    userViewModel.register(email: email, password: password)
                } label: {
                    Text("Register")
                        .bold()
                        .foregroundStyle(.blue)
                }
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(UserViewModel())
}
