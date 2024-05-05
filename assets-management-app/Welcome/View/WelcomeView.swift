//
//  WelcomeView.swift
//  assets-management-app
//
//  Created by Igor Max de Lima Nunes on 05/05/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Spacer()
                
                ImageLoginView()
                
                
                VStack(alignment: .leading) {
                    FirstTextView(text: "Gerencie seus")
                    
                    TitleTextView(titleText: "Ativos 💻")
                    
                    
                    SubscriptionTextView(text: "Esta aplicação oferece uma solução completa para a manutenção e organização dos ativos de tecnologia da sua empresa.")
                }
                .padding()
                
                Spacer()
                
                HStack {
                    ThreeRectanglesView()
                    
                    Spacer()
                    ButtonLoginView(buttonText: "Iniciar")

                }
                .padding(25)
            }
            .background(Color("background-color"))
            
        }
    }
}

#Preview {
    WelcomeView()
}

struct ImageLoginView: View {
    var body: some View {
        Image("login-image")
            .resizable()
            .scaledToFit()
            .padding(20)
    }
}

struct FirstTextView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 24)).fontWeight(.regular)
    }
}

struct TitleTextView: View {
    let titleText: String
    
    var body: some View {
        Text(titleText)
            .font(.system(size: 38)).fontWeight(.semibold)
    }
}

struct SubscriptionTextView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 14)).fontWeight(.light)
            .padding(.vertical, 3 )
    }
}

struct ThreeRectanglesView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color("primary-color"))
            .frame(width: 19, height: 7)
        
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.gray.opacity(0.5))
            .frame(width: 7, height: 7)
        
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.gray.opacity(0.5))
            .frame(width: 7, height: 7)
    }
}

struct ButtonLoginView: View {
    let buttonText: String
    
    var body: some View {
        NavigationLink(destination: LoginView(), label: {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color("primary-color"))
                .frame(width: 200, height: 60)
                .shadow(color: Color("primary-color").opacity(0.3),radius: 2, x: 5,y: 5)
                .overlay {
                    HStack {
                        Text(buttonText)
                            .bold()
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                    }
                    .padding(.horizontal, 20)
                    .foregroundStyle(Color.white)
                }
        })
    }
}

