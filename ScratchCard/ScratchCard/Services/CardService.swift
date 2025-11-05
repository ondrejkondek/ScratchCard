//
//  CardService.swift
//  ScratchCard
//
//  Created by Ondrej Kondek on 05/11/2025.
//

import Foundation

class CardService: ServiceProvider, CardServiceProtocol {
    let networkManager: NetworkManagable
    
    required init(networkManager: NetworkManagable) {
        self.networkManager = networkManager
    }
    
    func generateId() async throws -> UUID {
        // TODO: Simulation of API Call
        try? await Task.sleep(nanoseconds: 5 * 1_000_000_000)
        
        return UUID()
    }
    
    func activateCard(code: UUID) async throws -> VersionResponse {
        let request = ApiEndpoints.activate(code: code).request
        let model = try await self.networkManager.request(request, body: VersionResponse.self)
        return model
    }
}
