//
//  CODSnippetView.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 23.09.24.
//

import SwiftUI

struct CODSnippetView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("Crash") {
          fatalError("Crash was triggered")
        }
    }
}

#Preview {
    CODSnippetView()
}


//func passwordCheck(password: String) {
//    if password.count < 6 {
//        print("Password too short")
//    }
//}
//
//func emailCheck(email: String) {
//    if email == user?.email {
//        print("Email already in use")
//        
//    }
//}
