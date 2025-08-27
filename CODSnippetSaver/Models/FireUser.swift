//
//  User.swift
//  CODSnippetSaver
//
//  Created by Fawwaz Hajj Khalid on 25.09.24.
//

import Foundation


struct FireUser: Codable {
    
    let id: String
    let email: String?
    let registeredOn: Date
    var name: String?
    var nickName: String?
    var age: String?
}
