//
//  ContentView.swift
//  Recipes-App
//
//  Created by Igor Max de Lima Nunes on 12/01/24.
//

import SwiftUI

struct ContentView: View {
    @State var contentViewModel = ContentViewModel()
    
    var body: some View {
        Group {
            if contentViewModel.userSession != nil {
                HomeView()
            } else {
                WelcomeView()
            }
        }
    }
}

#Preview {
    ContentView()
}
