//
//  Asset.swift
//  assets-management-app
//
//  Created by Igor Max de Lima Nunes on 03/05/24.
//

import Foundation
import SwiftUI

enum Status: String, Codable, CaseIterable, Identifiable  {
    case HEALTHY
    case WARNING
    case CRITICAL
    
    var title: String {
        switch self {
        case .HEALTHY: return "Saudável"
        case .WARNING: return "Atenção"
        case .CRITICAL: return "Crítico"
        }
    }
    
    var statusColor: Color {
        switch self {
        case .CRITICAL: return .red
        case .WARNING: return .yellow
        case .HEALTHY: return .green
        }
    }
    
    var id: Self { self }
}

struct Asset: Codable, Identifiable, Hashable {
    var id = NSUUID().uuidString
    var userId: String
    var name: String
    var description: String
    var status: Status
    var nextMaintenance: String
    var value: Float
    var dependencies: [Dependency]
}

struct Dependency: Codable, Hashable, Identifiable {
    var id = NSUUID().uuidString
    var name: String
    var description: String
    var status: Status
    var value: Float
    var nextMaintenance: String
}

extension Asset {
    static let ASSET_MOCK = Asset(
        userId: "user123",
        name: "Servidor Principal",
        description: "Servidor principal da empresa",
        status: .CRITICAL,
        nextMaintenance: "Sun, 05 May 2024 00:00:00 GMT",
        value: 5000.0,
        dependencies: []
    )
    
    static let ASSETS_MOCK = [
        Asset(
            userId: "user123",
            name: "Servidor Principal",
            description: "Servidor principal da empresa",
            status: .CRITICAL,
            nextMaintenance: "2024-06-01",
            value: 5000.0,
            dependencies: Dependency.DEPENDENCIES_MOCK
        ),
        Asset(
            userId: "user456",
            name: "Computador Desktop",
            description: "Estação de trabalho para desenvolvimento de software",
            status: .HEALTHY,
            nextMaintenance: "2024-06-01",
            value: 2500.0,
            dependencies: []
        ),
        Asset(
            userId: "user789",
            name: "Switch de Rede",
            description: "Switch responsável pela rede local da empresa",
            status: .WARNING,
            nextMaintenance: "2024-06-01",
            value: 800.0,
            dependencies: []
        )
    ]
}

extension Dependency {
    static let DEPENDENCY_MOCK = Dependency(
        name: "Dependência A",
        description: "Descrição da Dependência A",
        status: .CRITICAL,
        value: 100.0,
        nextMaintenance: "2024-06-01"
    )
    
    static let DEPENDENCIES_MOCK = [
        Dependency(
            name: "Dependência A",
            description: "Descrição da Dependência A",
            status: .CRITICAL,
            value: 100.0,
            nextMaintenance: "2024-06-01"
        ),
        Dependency(
            name: "Dependência B",
            description: "Descrição da Dependência B",
            status: .HEALTHY,
            value: 50.0,
            nextMaintenance: "2024-06-01"
        ),
        Dependency(
            name: "Dependência C",
            description: "Descrição da Dependência C",
            status: .WARNING,
            value: 75.0,
            nextMaintenance: "2024-06-01"
        )
    ]
}
