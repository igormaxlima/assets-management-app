//
//  AssetFormViewModel.swift
//  assets-management-app
//
//  Created by Igor Max de Lima Nunes on 04/05/24.
//

import Foundation
import Combine

@Observable
class AssetFormViewModel {
    var isAddingDependency = false
    var nextMaintanceAssetDataFormat = Date()
    var nextMaintanceDependencyDataFormat = Date()
    
    var initialNextMaintenanceDate: Date {
        if !asset.nextMaintenance.isEmpty {
            var nextMaintenanceString = asset.nextMaintenance
            
            if let index = nextMaintenanceString.range(of: " GMT")?.lowerBound {
                nextMaintenanceString = String(nextMaintenanceString.prefix(upTo: index))
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
            return dateFormatter.date(from: nextMaintenanceString) ?? Date()
        } else {
            return Date()
        }
    }
    
    var isEditing = false
    
    var asset = Asset(userId: "",
                      name: "",
                      description: "",
                      status: .HEALTHY,
                      nextMaintenance: "",
                      value: 0.0,
                      dependencies: []
    )
    
    var dependency = Dependency(name: "",
                                description: "",
                                status: .HEALTHY,
                                value: 0.0,
                                nextMaintenance: ""
    )
    
    
    init(asset: Asset?) {
        if let asset = asset {
            self.asset = asset
        }
    }
    
    func postAsset() {
        asset.nextMaintenance = formatNextMaintenance(date: nextMaintanceAssetDataFormat)
        asset.userId = UserService.shared.currentUser?.uid ?? "lucasmartins"
        Task {
            do {
                try await ApiService.postAsset(asset: self.asset)
            } catch(let error) {
                print("ERROR DE POST: \(error): \(error.localizedDescription)")
            }
        }
    }
    
    func updateAsset() {
        asset.nextMaintenance = formatNextMaintenance(date: nextMaintanceAssetDataFormat)
        Task {
            do {
                try await ApiService.updateAsset(assetId: self.asset.id, asset: self.asset)
            } catch {
                print("ERROR DE PUT: \(error): \(error.localizedDescription)")
            }
        }
    }
    
    func addDependencyToAsset() {
        dependency.nextMaintenance = formatNextMaintenance(date: nextMaintanceDependencyDataFormat)
        self.asset.dependencies.append(self.dependency)
        resetDependency()
    }
    
}

extension AssetFormViewModel {
    func resetDependency() {
        self.dependency = Dependency(name: "",
                                description: "",
                                status: .HEALTHY,
                                value: 0.0,
                                nextMaintenance: ""
        )
        self.nextMaintanceDependencyDataFormat = Date()
    }
    
    var disableAssetForm: Bool {
        asset.name.isEmpty || asset.description.isEmpty || asset.value < 1
    }
    
    var disableDependencyForm: Bool {
        dependency.name.isEmpty || dependency.description.isEmpty || dependency.value < 1
    }
    
    func formatNextMaintenance(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}
