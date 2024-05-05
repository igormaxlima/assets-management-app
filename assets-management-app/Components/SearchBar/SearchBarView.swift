//
//  SearchBarView.swift
//  assets-management-app
//
//  Created by Igor Max de Lima Nunes on 03/05/24.
//

import SwiftUI

struct SearchBarView: View {
    let placeholder: String
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? Color.secondary : Color.black
                )
            
            TextField(placeholder, text: $searchText)
                .foregroundStyle(Color.black)
                .autocorrectionDisabled(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(.black)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            searchText = " "
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemGray6))
//                .shadow(color: .gray.opacity(0.25), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    SearchBarView(placeholder: "Pesquise seu ativo...", searchText: .constant(""))
}
