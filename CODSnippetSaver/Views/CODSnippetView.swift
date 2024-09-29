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

