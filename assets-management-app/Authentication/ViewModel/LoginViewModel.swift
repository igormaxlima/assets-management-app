//
//  LoginViewModel.swift
//  assets-management-app
//
//  Created by Igor Max de Lima Nunes on 03/05/24.
//

import SwiftUI

@Observable
class LoginViewModel {
    
    var email = ""
    var password = ""
    
    func login() async throws {
        try await AuthService.shared.login(withEmail: email, password: password)
    }
}
