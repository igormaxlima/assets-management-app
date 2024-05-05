//
//  AssetRowView.swift
//  assets-management-app
//
//  Created by Igor Max de Lima Nunes on 05/05/24.
//

import SwiftUI

struct AssetRowView: View {
    let asset: Asset
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            
            Circle()
                .fill(asset.status.statusColor)
                .frame(width: 10, height: 10)
                .padding(.top, 15)

            
            VStack(alignment: .leading, spacing: 4) {
                Text(asset.name)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(asset.description)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                    .frame(maxWidth: UIScreen.main.bounds.width - 100, alignment: .leading)
            }
            
            HStack {
                Text("\(ConvertData.convertDateStringToDateAndFormat(asset.nextMaintenance, from: "EEE, dd MMM yyyy HH:mm:ss 'GMT'", to: "dd/MM/yyyy") ?? " ")")
                Image(systemName: "clock.arrow.circlepath")
            }
            .font(.footnote)
            .foregroundStyle(.gray)
            
        }
        .frame(height: 72)
        
    }
}
