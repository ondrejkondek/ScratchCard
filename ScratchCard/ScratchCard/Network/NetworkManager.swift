//
//  NetworkManager.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 04/11/2025.
//

import Foundation

class NetworkManager: NetworkManagable {
    func request(_ urlRequest: URLRequest) async throws -> URLResponse {
        let (_, response) = try await URLSession.shared.data(for: urlRequest)
        return response
    }
    
    func request<T: Decodable & Sendable>(_ urlRequest: URLRequest, body: T.Type) async throws -> T {
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

// TODO: Implement Mocked Network Manager
class MockedNetworkManager: NetworkManagable {
    func request(_ urlRequest: URLRequest) async throws -> URLResponse {
        fatalError("Mock not implemented")
    }
    
    func request<T: Decodable & Sendable>(_ urlRequest: URLRequest, body: T.Type) async throws -> T {
        fatalError("Mock not implemented")
    }
}

