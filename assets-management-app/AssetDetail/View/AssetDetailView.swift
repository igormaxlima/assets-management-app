//
//  AssetDetailView.swift
//  assets-management-app
//
//  Created by Igor Max de Lima Nunes on 04/05/24.
//

import SwiftUI

struct AssetDetailView: View {
    let asset: Asset
    @Environment(\.dismiss) var dismiss
    @State var isEditing = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {
                
                HStack(alignment: .top) {
                    Circle()
                        .fill(asset.status.statusColor)
                        .frame(width: 10, height: 10)
                        .padding(.top, 25)
                    
                    Text(asset.name)
                        .font(.largeTitle).bold()
                        .foregroundStyle(Color(asset.status.statusColor))
                        .padding(.top, 10)
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                
                Group {
                    
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text(asset.description)
                            .font(.subheadline)
                            .fontWeight(.light)
                            .padding(.vertical)
                        
                        ForEach([
                            ("\(ConvertData.convertDateStringToDateAndFormat(asset.nextMaintenance, from: "EEE, dd MMM yyyy HH:mm:ss 'GMT'", to: "dd/MM/yyyy") ?? " ")", "calendar.badge.clock"),
                            ("\(asset.value.rounded())", "dollarsign"),
                            ("\(asset.status.title)", "stethoscope")
                        ], id: \.0) { label, imageName in
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(asset.status.statusColor).opacity(0.9).gradient) // Cor de fundo personalizada
                                Label(label, systemImage: imageName)
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding()
                            }
                            .frame(maxWidth: .infinity)
                        }
                        
                    }
                    
                    
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                
                VStack {
                    HStack {
                        Text("Dependências: ")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    if asset.dependencies.isEmpty {
                        ContentUnavailableView("Não há dependências!", systemImage: "doc.badge.ellipsis", description: Text("Que tal criar uma nova dependência para começar?"))
                            .padding(.top)
                    } else {
                        
                            ForEach(asset.dependencies) { dependency in
                                DependencyRowView(dependency: dependency)
                                Divider()
                            }
                            .background(Color("background-color"))
                        
//                        .listStyle(PlainListStyle())
//                        .background(Color(.red))
//                        .frame(height: UIScreen.main.bounds.height - 120)
                    }
                    
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .background(Color("background-color"))
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .foregroundStyle(.black)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isEditing.toggle()
                } label: {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.black, Color(.black).opacity(0.8))
                }
                .foregroundStyle(.black)
            }
            
        }
        .fullScreenCover(isPresented: $isEditing, content: {
            AssetFormView(editingAsset: asset)
        })
        
        
    }
}

#Preview {
    AssetDetailView(asset: Asset.ASSET_MOCK)
}
