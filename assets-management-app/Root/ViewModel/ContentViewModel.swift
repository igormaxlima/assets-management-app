//
//  ContentViewModel.swift
//  assets-management-app
//
//  Created by Igor Max de Lima Nunes on 05/05/24.
//

import Firebase
import Combine

@Observable
class ContentViewModel {
    var userSession: FirebaseAuth.User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
      setupSubscribers()
    }
    
    private func setupSubscribers() {
        AuthService.shared.$userSession.sink { [weak self] userSessionFromAuthService in
            self?.userSession = userSessionFromAuthService
        }.store(in: &cancellables)
    }
}
