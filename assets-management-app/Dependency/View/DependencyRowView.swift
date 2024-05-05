//
//  DependencyRowView.swift
//  assets-management-app
//
//  Created by Igor Max de Lima Nunes on 04/05/24.
//

import SwiftUI

struct DependencyRowView: View {
    let dependency: Dependency
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            
            Circle()
                .fill(dependency.status.statusColor)
                .frame(width: 10, height: 10)
                .padding(.top, 15)

            
            VStack(alignment: .leading, spacing: 4) {
                Text(dependency.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(dependency.description)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            
            VStack(spacing: 3) {
                Label("\(ConvertData.convertDateStringToDateAndFormat(dependency.nextMaintenance, from: "EEE, dd MMM yyyy HH:mm:ss 'GMT'", to: "dd/MM/yyyy") ?? " ")", systemImage: "clock.arrow.circlepath")
                .font(.footnote)
                .foregroundStyle(.gray)
                
                Label(dependency.status.title, systemImage: "eye.trianglebadge.exclamationmark")
                .font(.footnote)
                .foregroundStyle(.gray)
            }
            
        }
        .background(Color("background-color"))
        .frame(height: 72)
        .padding()
    }
}

#Preview {
    DependencyRowView(dependency: Dependency.DEPENDENCY_MOCK)
}
