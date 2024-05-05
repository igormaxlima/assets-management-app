//
//  ApiService.swift
//  assets-management-app
//
//  Created by Igor Max de Lima Nunes on 04/05/24.
//

import Foundation

class ApiService {

    static func fetchAssets(userId: String) async throws -> [Asset] {
        let endpoint = "http://localhost:5001/assets/\(userId)"
        
        guard let url = URL(string: endpoint) else { throw APIError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw APIError.invalidResponse }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([Asset].self, from: data)
        } catch(let error) {
            print("ERRO DIRETO DA REQUISICAO: \(error): \(error.localizedDescription)")
            throw APIError.invalidData
        }
    }
    
    static func postAsset(asset: Asset) async throws {
        let endpoint = "http://localhost:5001/assets"
        
        guard let url = URL(string: endpoint) else { throw APIError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let jsonData = try JSONEncoder().encode(asset)
        
        do {
            let (_, response) = try await URLSession.shared.upload(for: request, from: jsonData)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else { throw APIError.invalidResponse }
        } catch(let error) {
            print("ERRO DIRETO DA REQUISICAO: \(error): \(error.localizedDescription)")
        }
    }
    
    static func deleteAsset(assetId: String) async throws {
        let endpoint = "http://localhost:5001/assets/\(assetId)"
        
        guard let url = URL(string: endpoint) else { throw APIError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw APIError.invalidResponse }
            
            print("Asset \(assetId) deleted successfully")
        } catch {
            throw APIError.serverError
        }
        
    }
    
    static func updateAsset(assetId: String, asset: Asset) async throws {
        let endpoint = "http://localhost:5001/assets/\(assetId)"
        
        guard let url = URL(string: endpoint) else { throw APIError.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try JSONEncoder().encode(asset)
        
        do {
            let (_, response) = try await URLSession.shared.upload(for: request, from: jsonData)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else { throw APIError.invalidResponse }
        } catch(let error) {
            print("Erro ao codificar o objeto para JSON - \(error): \(error.localizedDescription)")
            return
        }
    }
    
    
    enum APIError: Error {
        case invalidURL
        case invalidResponse
        case invalidData
        case serverError
        case unknown(Error)
    }
}
