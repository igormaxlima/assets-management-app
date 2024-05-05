//
//  HomeView.swift
//  assets-management-app
//
//  Created by Igor Max de Lima Nunes on 03/05/24.
//

import SwiftUI

struct HomeView: View {
    @State var homeViewModel = HomeViewModel()
    
    private var user: User? {
        return homeViewModel.currentUser
    }
    
    var body: some View {
        NavigationStack {
            if homeViewModel.currentUser == nil {
                ProgressView("Carregando...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Olá, \(user?.fullname ?? "")")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Text("Gerencie seus ativos com facilidade. Acompanhe, atualize e visualize informações importantes em um só lugar.")
                            .font(.subheadline)
                            .fontWeight(.light)
                        
                        CarouselView(images: [
                            "imagem-ativo1",
                            "imagem-ativo2",
                            "imagem-ativo3"
                        ].shuffled())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Gerencie seus ativos:")
                            .font(.headline)
                            .padding(.leading)
                        
                        SearchBarView(placeholder: "Pesquise seu ativo...", searchText: $homeViewModel.searchText)
                            .padding(.horizontal)
                        
                        HStack {
                            Text("Todos")
                                .font(.footnote)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Button {
                                homeViewModel.isShowingCreateAssetView.toggle()
                            } label: {
                                Text("Adicionar novo ativo")
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                
                            }
                        }
                        .padding(.top, 5)
                        .padding(.horizontal, 28)
                        
                        if homeViewModel.filteredAssets.isEmpty {
                            ContentUnavailableView("Não existe ativos criados...", systemImage: "exclamationmark.bubble", description: Text("Que tal criar um novo para começar?"))
                                .padding(.top)
                        } else {
                            List {
                                ForEach(homeViewModel.filteredAssets) { asset in
                                    NavigationLink(destination: AssetDetailView(asset: asset)) {
                                        AssetRowView(asset: asset)
                                    }
                                }
                                .onDelete(perform: homeViewModel.handleAssetDeletion)
                                
                                
                                //                            .alert(isPresented: $homeViewModel.showingAlert) {
                                //                                Alert(
                                //                                    title: Text("Excluir Ativo"),
                                //                                    message: Text("Você realmente deseja excluir esse ativo e todas suas dependências?"),
                                //                                    primaryButton: .destructive(Text("Excluir"), action: {
                                //                                        homeViewModel.deleteAsset(assetId: homeViewModel.filteredAssets[indexSet]))
                                //                                    }),
                                //                                    secondaryButton: .cancel()
                                //                                )
                                //                            }
                            }
                            .listStyle(PlainListStyle())
                            .frame(height: UIScreen.main.bounds.height - 100)
                            
                        }
                    }
                }
                .fullScreenCover(isPresented: $homeViewModel.isShowingCreateAssetView, content: {
                    AssetFormView(editingAsset: nil)
                })
                .onAppear { homeViewModel.loadData(userId: user?.uid ?? "") }
                .refreshable { homeViewModel.handleRefresh(userId: user?.uid ?? "") }
                .navigationDestination(for: Asset.self, destination: { asset in
                    AssetDetailView(asset: asset)
                })
                .navigationDestination(for: User.self, destination: { user in
                    ProfileView(user: user)
                })
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        NavigationLink(value: user) {
                            CircularProfileImageView(user: user, size: .xSmall)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            homeViewModel.isShowingCreateAssetView.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(.black, Color(.systemGray5))
                        }
                    }
                }
            }
        }
        
        
    }
}

#Preview {
    HomeView()
}

struct CarouselView: View {
    let images: [String]
    @State private var currentIndex: Int = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(0..<images.count, id: \.self) { index in
                    Image(images[index])
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 150)
            .cornerRadius(30)
        }
        .padding(.vertical)
        .onAppear {
            // Inicia um timer para mudar automaticamente as imagens a cada 3 segundos
            let timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                withAnimation {
                    currentIndex = (currentIndex + 1) % images.count
                }
            }
            // Garante que o timer seja invalidado quando a visualização é descartada
            RunLoop.main.add(timer, forMode: .common)
        }
    }
}
