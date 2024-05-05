//
//  User.swift
//  assets-management-app
//
//  Created by Igor Max de Lima Nunes on 03/05/24.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable, Identifiable, Hashable {
    @DocumentID var uid: String?
    let fullname: String
    let email: String
    
    var id: String {
        return uid ?? NSUUID().uuidString
    }
}

extension User {
    static let MOCK_USER = User(uid:"lucasmartins", fullname: "Lucas Martins", email: "lucas.martins@idp.edu.br")
}
