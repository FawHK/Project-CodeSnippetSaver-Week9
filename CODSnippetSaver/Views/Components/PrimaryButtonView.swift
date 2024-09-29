//
//  PrimaryButtonView.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 29.09.24.
//

import SwiftUI

struct PrimaryButtonView: View {
    
    // MARK: - Properties
    
    let title: String
    let action: () -> Void
    
    
    // MARK: - Body
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding()
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .background(.turquoise)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.horizontal)
        }
        .background(.clear)
    }
}

#Preview {
    PrimaryButtonView(title: "Enter") { }
}
