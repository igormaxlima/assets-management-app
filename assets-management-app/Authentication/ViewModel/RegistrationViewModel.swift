//
//  RegistrationViewModel.swift
//  assets-management-app
//
//  Created by Igor Max de Lima Nunes on 03/05/24.
//

import SwiftUI

@Observable class RegistrationViewModel {
    
    var email: String = ""
    var password: String = ""
    var fullname: String = ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(withEmail: self.email, password: self.password, fullname: self.fullname)
    }
    
}
