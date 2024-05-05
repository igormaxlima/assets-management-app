//
//  HomeViewModel.swift
//  assets-management-app
//
//  Created by Igor Max de Lima Nunes on 03/05/24.
//

import Foundation
import Firebase
import Combine

@Observable
class HomeViewModel {
    var assets: [Asset] = []
    var searchText = ""
    var showingAlert = false
    var isShowingCreateAssetView = false
    var showDetail = false
    var selectedAsset: Asset?
    var selectedIndex: Int?
    
    var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    
    private func setupSubscribers() {
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
        }.store(in: &cancellables)
    }
    
    init() {
        setupSubscribers()
    }
    
    var filteredAssets: [Asset] {
            guard !searchText.isEmpty else {
                return self.assets
            }
        return self.assets.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    func loadData(userId: String) {
        Task {
            do {
                let assets = try await ApiService.fetchAssets(userId: userId)
                self.assets = assets
            } catch(let error) {
                print("ERROR GET: \(error): \(error.localizedDescription)")
            }
        }
    }

    
    func handleRefresh(userId: String) {
        assets.removeAll()
        Task {
            loadData(userId: userId)
        }
    }
    
    func handleAssetDeletion(at indexSet: IndexSet) {
        guard let assetIndex = indexSet.first else { return }
        let asset = filteredAssets[assetIndex]
        
        Task {
            do {
                try await ApiService.deleteAsset(assetId: asset.id)
                DispatchQueue.main.async {
                    self.assets.remove(at: assetIndex)
                }
            } catch(let error) {
                print("ERROR DELETE: \(error): \(error.localizedDescription)")
            }
        }
    }
}
